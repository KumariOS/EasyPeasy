// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

/**
    Struct wrapping a value that is going to be used as ``NSLayoutConstraint`
    multiplier. Might look a bit silly but is required to avoid breaking
    backwards compatibility with the prefix operator *
 */
public struct Multiplier {
    
    /// Multiplier value
    let value: CGFloat
    
    /**
        Creates a `Multiplier` instance with value the `CGFloat` provided
        - parameter value: Multiplier value
     */
    init(_ value: CGFloat) {
        self.value = value
    }
}

prefix operator * {}

/**
    Prefix operator that eases the creation of a `Multiplier` with the `CGFloat`
    at the right hand side of the operator.
    - parameter rhs: Value for the `Multiplier`
    - returns: The resulting `Multiplier` struct
 */
public prefix func * (rhs: CGFloat) -> Multiplier {
    return Multiplier(rhs)
}

/// Alias of `NSLayoutRelation`
typealias Relation = NSLayoutRelation

/**
    Struct that aggregates `NSLayoutRelation`, constant and multiplier of a
    layout constraint eventually created
 */
public struct Constant {
    
    /// Value of the constant
    let value: CGFloat
    
    /// Multiplier applied to the `value` of the `Constant`
    let multiplier: Multiplier
    
    /// Relation applied to the `value` of the `Constant`
    let relation: NSLayoutRelation
    
    /**
        This initializer creates a `Constant` with the value supplied
        and the relation `.Equal`
        - parameter value: Value of the `Constant`
        - returns: the `Constant` struct created
     */
    init(_ value: CGFloat) {
        self.value = value
        self.multiplier = Multiplier(1.0)
        self.relation = .Equal
    }
    
    /**
        This initializer creates a `Constant` with the `value` and `relation`
        supplied.
        - parameter value: Value of the `Constant`
        - paramter multiplier:
        - parameter relation: Relation applied to the `value`
        - returns: the `Constant` struct created
     */
    init(value: CGFloat, relation: Relation, multiplier: Multiplier) {
        self.value = value
        self.multiplier = multiplier
        self.relation = relation
    }
    
    /**
        Determines the `CGFloat` value of the `multiplier` property
        - returns: `CGFloat` multiplier
     */
    internal func layoutMultiplier() -> CGFloat {
        return self.multiplier.value
    }
    
    /**
        Value of the `Constant`
        - returns: `CGFloat` value of the `Constant`
     */
    internal func layoutValue() -> CGFloat {
        return self.value
    }
    
}

prefix operator >= {}

/**
    Prefix operator that eases the creation of a `Constant` with a
    `.GreaterThanOrEqual` relation.
    - parameter rhs: Value for the `Constant`
    - returns: The resulting `Constant` struct
 */
public prefix func >= (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, relation: .GreaterThanOrEqual, multiplier: Multiplier(1.0))
}

prefix operator <= {}

/**
    Prefix operator that eases the creation of a `Constant` with a
    `.LessThanOrEqual` relation.
    - parameter rhs: Value for the `Constant`
    - returns: The resulting `Constant` struct
 */
public prefix func <= (rhs: CGFloat) -> Constant {
    return Constant(value: rhs, relation: .LessThanOrEqual, multiplier: Multiplier(1.0))
}
