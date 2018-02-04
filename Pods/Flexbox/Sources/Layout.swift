import Foundation

/// An evaluated Flexbox layout.
/// - Note: Layouts will not be created manually.
public struct Layout
{
    public let frame: CGRect
    public let children: [Layout]

    internal init(frame: CGRect, children: [Layout])
    {
        self.frame = frame
        self.children = children
    }
}

extension Layout: CustomStringConvertible
{
    public var description: String
    {
        return _descriptionForDepth(0)
    }

    private func _descriptionForDepth(_ depth: Int) -> String
    {
        let selfDescription = "{origin={\(frame.origin.x), \(frame.origin.y)}, size={\(frame.size.width), \(frame.size.height)}}"
        if children.isEmpty {
            return selfDescription
        }
        else {
            let indentation = (0...depth).reduce("\n") { accum, _ in accum + "\t" }
            let childrenDescription = (children.map { $0._descriptionForDepth(depth + 1) }).joined(separator: indentation)
            return "\(selfDescription)\(indentation)\(childrenDescription)"
        }
    }
}

extension Layout: Equatable
{
    public static func == (lhs: Layout, rhs: Layout) -> Bool
    {
        if lhs.frame != rhs.frame { return false }
        if lhs.children != rhs.children { return false }

        return true
    }
}
