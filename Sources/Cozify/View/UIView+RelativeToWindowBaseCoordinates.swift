//
//  UIView+RelativeToWindowBaseCoordinates.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import UIKit

public extension UIView {
    /// The point converted to the window base coordinate system
    var originPositionRelativeToWindowBaseCoordinates: CGPoint? {
        return superview?.convert(frame.origin, to: nil)
    }
    
    /// The frame converted to the window base coordinate system
    var framePositionRelativeToWindowBaseCoordinates: CGRect? {
        return superview?.convert(frame, to: nil)
    }
}
