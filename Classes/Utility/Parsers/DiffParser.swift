//
//  DiffParser.swift
//  Freetime
//
//  Created by Weyert de Boer on 14/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

extension String {

    func components(from matches: [NSTextCheckingResult]) -> [[String]] {
        let line = self
        return matches.map { result in
            (0..<result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? String(line[Range(result.range(at: $0), in: line)!])
                : ""
            }
        }
    }
}

public typealias ChunkOffset = (start: Int, lines: Int)
public typealias ChunkChange = (type: LineChangeType, content: String)

public enum FileMode {
    case added
    case deleted
    case modified
}

public enum LineChangeType {
    case line
    case start
    case index
    case addedFile
    case sourceFile
    case targetFile
    case deletedFile
    case addedLine
    case deletedLine
    case chunk
    case endOfFile
    case unknown
}

public class Chunk {
    public private(set) var content = ""
    public private(set) var chunkLine = ""
    public private(set) var changes = [ChunkChange]()
    public private(set) var added: ChunkOffset
    public private(set) var removed: ChunkOffset

    init(chunkLine: String, added: ChunkOffset, removed: ChunkOffset) {
        self.chunkLine = chunkLine
        self.added = added
        self.removed = removed
    }

    func addChange(_ type: LineChangeType, _ line: String) {
        content += line + "\n"
        changes.append( ChunkChange(type: type, content: line) )
    }
}

public class DiffFile {
    var mode: FileMode = .modified
    var sourceFile = ""
    var targetFile = ""
    public private(set) var chunks = [Chunk]()
    var deletions: Int = 0
    var additions: Int = 0

    func addChunk(chunk: Chunk) {
        chunks.append(chunk)
    }
}

public class DiffParser {

    private var currentChunk: Chunk?
    private var currentFile: DiffFile?
    private var isUnifiedFormat: Bool = true

    public private(set) var files = [DiffFile]()
    private var content: String

    private let schema: [String: LineChangeType] = [
        "^\\s+": .line,
        "^diff\\s": .start,
        "^new file mode \\d+$": .addedFile,
        "^deleted file mode \\d+$": .deletedFile,
        "^index\\s[\\da-zA-Z]+\\.\\.[\\da-zA-Z]+(\\s(\\d+))?$": .index,
        "^---\\s": .sourceFile,
        "^\\+\\+\\+\\s": .targetFile,
        "^@@\\s+\\-(\\d+),?(\\d+)?\\s+\\+(\\d+),?(\\d+)?\\s@@": .chunk,
        "^-": .deletedLine,
        "^\\+": .addedLine
    ]

    init(content: String) {
        self.content = content.trimmingCharacters(in: .whitespaces)
    }

    public func parse() -> Bool {
        guard !self.content.isEmpty else { return false }

        let lines = self.content.components(separatedBy: .newlines)

        // Determine if we are parsing the diff unified format
        isUnifiedFormat = true
        if let firstLine = lines.first, parseLine(firstLine) == .chunk {
            isUnifiedFormat = false
            currentFile = startNewFile()
        }

        lines.forEach { line in
            parseLine(line)
        }

        return true
    }

    private func processToken(_ type: LineChangeType, _ line: String, _ matches: [[String]]) {
        switch type {
        case .start:
            if currentFile == nil {
                currentFile = startNewFile(line)
                currentChunk = nil
            }
        case .sourceFile:
            restart()
            let sourceFilename = parseFilename(line)
            currentFile?.sourceFile = sourceFilename
        case .index:
            restart()
        case .targetFile:
            restart()
            let targetFilename = parseFilename(line)
            currentFile?.targetFile = targetFilename
        case .deletedFile:
            restart()
            currentFile?.mode = .deleted
            currentFile?.targetFile = "/dev/null"
        case .addedFile:
            restart()
            currentFile?.mode = .added
            currentFile?.sourceFile = "/dev/null"
        case .chunk:
            guard let newChunk = parseChunk(line, matches) else { return }
            currentFile?.addChunk(chunk: newChunk)
            currentChunk = newChunk
        case .line:
            currentChunk?.addChange(.line, line)
        case .addedLine:
            currentChunk?.addChange(type, line)
            currentFile?.additions += 1
        case .deletedLine:
            currentChunk?.addChange(type, line)
            currentFile?.deletions += 1
        default: print("Unsupported token type: \(type)")
        }
    }

    private func parseFilename(_ line: String) -> String {
        var trimCharacterSet = CharacterSet.whitespacesAndNewlines
        trimCharacterSet.insert(charactersIn: "+-")

        let trimmedLine = line.trimmingCharacters(in: trimCharacterSet)
        if trimmedLine.hasPrefix("a/") || trimmedLine.hasPrefix("b/") {
            return String(trimmedLine.dropFirst(2))
        }
        return trimmedLine
    }

    private func restart() {
        if currentFile == nil {
            self.currentFile = startNewFile()
            return
        }

        let chunks = currentFile!.chunks
        if !chunks.isEmpty {
            self.currentFile = startNewFile()
        }
    }

    private func startNewFile(_ line: String = "") -> DiffFile {
        let fileComponents = line.components(separatedBy: " ").suffix(2)
        let newFile = DiffFile()
        newFile.sourceFile = parseFilename(fileComponents.first ?? "")
        newFile.targetFile = parseFilename(fileComponents.last ?? "")
        files.append(newFile)
        return newFile
    }

    private func parseChunk(_ line: String, _ matches: [[String]]) -> Chunk? {
        let chunkComponents = matches.flatMap { $0 }
        let oldStart = Int(chunkComponents[1]) ?? 0
        let oldLines = Int(chunkComponents[2]) ?? 0
        let newStart = Int(chunkComponents[3]) ?? 0
        let newLines = Int(chunkComponents[4]) ?? 0
        return Chunk(chunkLine: line, added: ChunkOffset(start: newStart, lines: newLines), removed: ChunkOffset(start: oldStart, lines: oldLines))
    }

    @discardableResult
    private func parseLine(_ line: String, dryrun: Bool=false) -> LineChangeType {
        for (scheme, type) in schema {
            guard let regex = try? NSRegularExpression(pattern: scheme, options: []) else { continue }

            let matches = regex.matches(in: line, options: [], range: NSRange(line.startIndex..., in: line))
            if !matches.isEmpty {
                processToken(type, line, line.components(from: matches))
                return type
            }
        }

        if currentFile != nil, dryrun == false {
            processToken(.line, line, [])
        }

        return .unknown
    }
}
