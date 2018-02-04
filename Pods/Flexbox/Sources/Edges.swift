/// Container for 4-direction `CGFloat` values.
public struct Edges
{
    public let left: CGFloat
    public let right: CGFloat
    public let top: CGFloat
    public let bottom: CGFloat

    public init(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0)
    {
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
    }

    public init(uniform: CGFloat)
    {
        self.left = uniform
        self.right = uniform
        self.top = uniform
        self.bottom = uniform
    }

    public static let zero = Edges(uniform: 0)
    public static let undefined = Edges(uniform: .nan)
}

extension Edges: Equatable
{
    public static func == (l: Edges, r: Edges) -> Bool
    {
        if !_isCGFloatEqual(l.left, r.left) { return false }
        if !_isCGFloatEqual(l.right, r.right) { return false }
        if !_isCGFloatEqual(l.top, r.top) { return false }
        if !_isCGFloatEqual(l.bottom, r.bottom) { return false }

        return true
    }
}
