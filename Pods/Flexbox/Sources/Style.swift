/// CSS styles https://www.w3.org/TR/css-flexbox/
/// that interacts with https://github.com/facebook/yoga .
///
/// - Note: Some values are unimplemented / tweaked in facebook/yoga.
/// - SeeAlso: facebook/yoga/YGEnums.h
public enum Style
{
    /// ## CSS spec
    /// - Value:    row | row-reverse | column | column-reverse
    /// - Initial:    row
    /// - Applies to:    flex containers
    public enum FlexDirection: UInt32
    {
        case column = 0
        case columnReverse = 1
        case row = 2
        case rowReverse = 3
    }

    /// ## CSS spec
    /// - Value:    nowrap | wrap | wrap-reverse
    /// - Initial:    nowrap
    /// - Applies to:    flex containers
    public enum FlexWrap: UInt32
    {
        case nowrap = 0
        case wrap = 1
        //case wrapReverse  // not in facebook/yoga
    }

    /// ## CSS spec
    /// - Value:    flex-start | flex-end | center | space-between | space-around
    /// - Initial:    flex-start
    /// - Applies to:    flex containers
    public enum JustifyContent: UInt32
    {
        case flexStart = 0
        case center = 1
        case flexEnd = 2
        case spaceBetween = 3
        case spaceAround = 4
    }

    /// ## CSS spec
    /// - Value:    flex-start | flex-end | center | baseline | stretch
    /// - Initial:    stretch
    /// - Applies to:    flex containers
    public enum AlignItems: UInt32
    {
        case auto = 0       // only in facebook/yoga
        case flexStart = 1
        case center = 2
        case flexEnd = 3
        case stretch = 4
        // case baseline    // not in facebook/yoga
    }

    /// ## CSS spec
    /// - Value:    flex-start | flex-end | center | space-between | space-around | stretch
    /// - Initial:    stretch
    /// - Applies to:    multi-line flex containers
    public enum AlignContent: UInt32
    {
        case auto = 0       // only in facebook/yoga
        case flexStart = 1
        case center = 2
        case flexEnd = 3
        case stretch = 4    // only in facebook/yoga
    }

    /// ## CSS spec
    /// - Value:    auto | flex-start | flex-end | center | baseline | stretch
    /// - Initial:    auto
    /// - Applies to:    flex items
    public enum AlignSelf: UInt32
    {
        case auto = 0
        case flexStart = 1
        case center = 2
        case flexEnd = 3
        case stretch = 4
        // case baseline    // not in facebook/yoga
    }

    /// ## CSS spec
    /// https://www.w3.org/TR/css-position-3/
    /// - Value:    static | relative | absolute | sticky | fixed
    /// - Initial:    static
    /// - Applies to:    all elements except table-column-group and table-column
    public enum PositionType: UInt32
    {
        case relative = 0
        case absolute = 1
    }

    /// ## CSS spec
    /// https://www.w3.org/TR/css-overflow-3/
    /// - Value:    visible | hidden | clip | scroll | auto
    /// - Initial:    see individual properties
    /// - Applies to:    block containers [CSS21], flex containers [CSS3-FLEXBOX], and grid containers [CSS3-GRID-LAYOUT]
    public enum Overflow: UInt32
    {
        case visible = 0
        case hidden = 1
        case scroll = 2
    }

    /// ## CSS spec
    /// https://www.w3.org/TR/css-writing-modes-3/
    /// - Value:    ltr | rtl
    /// - Initial:    ltr
    /// - Applies to:    all elements
    public enum Direction: UInt32
    {
        case inherit = 0
        case ltr = 1
        case rtl = 2
    }
}
