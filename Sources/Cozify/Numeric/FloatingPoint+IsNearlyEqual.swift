//
//  Cozify
//
//  Created by Rinat Abidullin on 12.12.2021.
//

import Foundation

extension FloatingPoint {
    func isNearlyEqual(to value: Self) -> Bool {
        return abs(self - value) <= .ulpOfOne
    }
}
