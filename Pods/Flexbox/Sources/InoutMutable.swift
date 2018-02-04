public protocol InoutMutable
{
    /// Alias of `init()` to **not force users to implement extra `init()`**
    /// when techinically-same initializer e.g. `init(x: Int = 0)` is already declared.
    /// (This problem occurs due to Swift compiler not been wise enough.)
    ///
    /// - Note: Implementation should always be `return self.init()`.
    static func emptyInit() -> Self
}

extension InoutMutable
{
    public init(_ closure: (inout Self) -> ())
    {
        self = Self.emptyInit()
        closure(&self)
    }

    public mutating func mutate(_ closure: (inout Self) -> ()) -> Self
    {
        closure(&self)
        return self
    }
}
