//
//  IssuePatchContentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public typealias LineMetadata = (Int?, Int?, LineChangeType)
final class ChunkGutterRenderer: GutterLayoutManagerDelegate {

    weak var chunk: Chunk?
    private var lineMetadata = [LineMetadata]()
    private var maxGutterDigits: Int = 3
    private let fileMode: FileMode

    init(chunk: Chunk, fileMode: FileMode = .modified) {
        self.chunk = chunk
        self.fileMode = fileMode
        createLineNumberCache()
    }

    private func createLineNumberCache() {
        guard let chunk = chunk else { return }

        let start = chunk.added.start
        let old = chunk.removed.start

        var newLineNumber = start
        var oldLineNumber = old

        chunk.changes.forEach { change in
            lineMetadata.append(
                (
                    newLineNumber,
                    oldLineNumber,
                    change.type
                )
            )

            if change.type == .addedLine {
                newLineNumber += 1
            } else if change.type == .deletedLine {
                oldLineNumber += 1
            } else if change.type == .line {
                newLineNumber += 1
                oldLineNumber += 1
            }
        }

        let highestNumber = max(start, old) + chunk.changes.count
        maxGutterDigits = "\(highestNumber)".count
    }

    public func getLineDetails(for lineNumber: Int) -> LineMetadata?  {
        let lineIndex = lineNumber - 1
        guard lineMetadata.indices.contains(lineIndex) else { return nil }
        return lineMetadata[lineIndex]
    }

    func getLineForLine(gutterLayoutManager: GutterLayoutManager, lineNumber: Int, for line: String) -> String {
        guard let lineInfo = self.getLineDetails(for: lineNumber) as LineMetadata? else { return "" }

        var oldLineNumber = ""
        var newLineNumber = ""
        if lineInfo.1 != nil {
            oldLineNumber = "\(lineInfo.1!)"
        }
        if lineInfo.0 != nil {
            newLineNumber = "\(lineInfo.0!)"
        }

        // If it's an added or deleted file, we only see one row line numbers
        switch fileMode {
        case .added, .deleted:
            return "\(lineNumber)"
        case .modified:
            return "\(oldLineNumber) \(newLineNumber)"
        }
    }

    func getMaximumGutterWidth(gutterLayoutManager: GutterLayoutManager) -> CGFloat {
        let fillerString = String(repeating: "9", count: maxGutterDigits)
        var maxGutterString = ""
        switch fileMode {
        case .added, .deleted:
            maxGutterString = " \(fillerString) "
        case .modified:
            maxGutterString = " \(fillerString) \(fillerString) "
        }

        let maxGutterSize = (maxGutterString as NSString).size(withAttributes: [NSAttributedStringKey.font: gutterLayoutManager.gutterFont])
        let calculatedGutterWidth = ceil(maxGutterSize.width)
        return calculatedGutterWidth
    }
}

final class IssuePatchContentViewController: UIViewController {

    private let file: File
    private let client: GithubClient
    private let scrollView = UIScrollView()
    private var chunkViews = [AttributedStringView]()

    init(file: File, client: GithubClient) {
        self.file = file
        self.client = client
        super.init(nibName: nil, bundle: nil)

        title = file.filename

        let chunkContentSize = prepareChunkViews()

        scrollView.contentSize = chunkContentSize
    }

    private func prepareChunkViews() -> CGSize {
        let width: CGFloat = 0
        var chunkContentSize = CGSize.zero

        let diffParser = DiffParser(content: self.file.patch)
        guard diffParser.parse() == true else {
            return chunkContentSize
        }

        // Iterate through all the chunks of this file and render it on the screen
        diffParser.files.forEach { currentFile in
            currentFile.chunks.forEach { chunk in
                let chunkContent = "\(chunk.content)"

                // Check the mode by combining the GitHub API data and what the diff parser detected
                var fileMode = currentFile.mode
                switch self.file.status {
                case "added": fileMode = .added
                case "deleted": fileMode = .deleted
                default: fileMode = .modified
                }

                let chunkGutterRenderer = ChunkGutterRenderer(chunk: chunk, fileMode: fileMode)

                let colorCodedChunkContent = CreateColorCodedString(code: chunkContent, includeDiff: true) { line, index in
                    guard let lineInfo = chunkGutterRenderer.getLineDetails(for: index + 1) as LineMetadata? else { return .unknown }

                    switch lineInfo.2 {
                    case .addedLine: return .addedLine
                    case .deletedLine: return .deletedLine
                    default: return .unknown
                    }
                }

                let text = NSAttributedStringSizing(
                    containerWidth: width,
                    attributedText: colorCodedChunkContent,
                    inset: Styles.Sizes.textViewInset,
                    backgroundColor: .white,
                    exclusionPaths: [],
                    maximumNumberOfLines: 0,
                    lineFragmentPadding: 0.0,
                    allowsNonContiguousLayout: true,
                    hyphenationFactor: 0.0,
                    showsInvisibleCharacters: false,
                    showsControlCharacters: false,
                    usesFontLeading: true,
                    screenScale: UIScreen.main.scale,
                    showGutter: true,
                    showLineNumbers: true,
                    gutterDelegate: chunkGutterRenderer
                )

                let chunkSize = text.textViewSize(width)
                if chunkSize.width >= chunkContentSize.width {
                    chunkContentSize.width = chunkSize.width
                }

                chunkContentSize.height += chunkSize.height + Styles.Sizes.gutter

                let chunkAttributeView = AttributedStringView()
                chunkAttributeView.configureAndSizeToFit(text: text, width: width)

                chunkViews.append(chunkAttributeView)
            }
        }

        return chunkContentSize
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)

        var currentY: CGFloat = 0
        chunkViews.forEach { [weak self] chunkView in
            chunkView.frame = chunkView.frame.offsetBy(dx: 0, dy: currentY)
            self?.scrollView.addSubview(chunkView)

            currentY = chunkView.frame.origin.y + chunkView.frame.height + Styles.Sizes.gutter
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }
}
