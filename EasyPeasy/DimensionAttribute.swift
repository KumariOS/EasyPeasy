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
    Superclass for those `Attribute` objects that imply dimension
    constraints like width and height
 */
public class DimensionAttribute: Attribute { }

/**
    The width of the object’s alignment rectangle
 */
public class Width: DimensionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .Width
    }

}

/**
    The height of the object’s alignment rectangle
 */
public class Height: DimensionAttribute {
    
    /// `Attribute` applied to the view
    public override var createAttribute: ReferenceAttribute {
        return .Height
    }
    
}

/**
    The size of the object’s rectangle
 */
public class Size: CompoundAttribute {
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with `constant = 0.0`,
        `multiplier = 1.0` and `relatedBy = .Equal`
        - returns: the `CompoundAttribute` instance created
     */
    public override init() {
        super.init()
        self.attributes = [
            Width(),
            Height()
        ]
    }
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with `constant = value`,
        `multiplier = 1.0` and `relatedBy = .Equal`
        - parameter value: `constant` of the constraint
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ value: CGFloat) {
        super.init()
        self.attributes = [
            Width(value),
            Height(value)
        ]
    }
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with the `constant`,
        `multiplier` and `relatedBy` defined by the `Constant` supplied
        - parameter constant: `Constant` struct aggregating `constant`, 
        `multiplier` and `relatedBy` properties
        - returns: the `CompoundAttribute` instance created
     */
    public override init(_ constant: Constant) {
        super.init()
        self.attributes = [
            Width(constant),
            Height(constant)
        ]
    }
    
    /**
        Initializer which creates an `Attribute` instance
        with `constant = 0`, relatedBy = .Equal` and
        `Multiplier` the struct provided
        - parameter multiplier: `Multiplier` applied to the
        `NSLayoutConstraint`
        - returns: the `Attribute` instance created
     */
    public override init(_ multiplier: Multiplier) {
        super.init()
        self.attributes = [
            Width(multiplier),
            Height(multiplier)
        ]
    }
    
    /**
        Initializer which creates an `Attribute` instance
        with `constant = value`, `relatedBy = .Equal` and
        `Multiplier` the multiplier supplied
        - parameter value: `constant` of the constraint
        - parameter multiplier: `Multiplier` applied to the
        `NSLayoutConstraint`
        - returns: the `Attribute` instance created
     */
    public override init(_ value: CGFloat, _ multiplier: Multiplier) {
        super.init()
        self.attributes = [
            Width(value, multiplier),
            Height(value, multiplier)
        ]
    }
    
    /**
        Initializer which creates an `Attribute` instance
        with the `constant`, `multiplier` and `relatedBy`
        specified by the `Constant` and the `Multiplier`
        struct provided
        - parameter constant: `Constant` struct aggregating
        `constant` and `relatedBy` properties
        - parameter multiplier: `Multiplier` applied to the
        `NSLayoutConstraint`
        - returns: the `Attribute` instance created
     */
    public override init(_ constant: Constant, _ multiplier: Multiplier) {
        super.init()
        self.attributes = [
            Width(constant, multiplier),
            Height(constant, multiplier)
        ]
    }
    
    /**
        Initializer which creates a `CompountAttribute` instance formed
        by `Width` and `Height` attributes with `constant = size.width`
        and `constant = size.height` respectively, `multiplier = 1.0`
        and `relatedBy = .Equal`
        - parameter size: `CGSize` that sets the constants for the `Width`
        and `Height` *subattributes*
        - returns: the `CompoundAttribute` instance created
     */
    public init(_ size: CGSize) {
        super.init()
        self.attributes = [
            Width(CGFloat(size.width)),
            Height(CGFloat(size.height))
        ]
    }

}
