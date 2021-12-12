//
//  Cozify
//
//  Created by Rinat Abidullin on 12.12.2021.
//

import UIKit

public extension UIColor {
    func isEqualAfterConvertsToSameColorSpace (
        _ comparedColor: UIColor
    ) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        comparedColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return r1.isNearlyEqual(to: r2)
            && g1.isNearlyEqual(to: g2)
            && b1.isNearlyEqual(to: b2)
            && a1.isNearlyEqual(to: a2)
    }
}
