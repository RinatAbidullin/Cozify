//
//  Cozify
//
//  Created by Rinat Abidullin on 12.12.2021.
//

import UIKit

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0x00ff00) >> 8) / 255
        let b = CGFloat((hex & 0x0000ff) >> 0) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        guard hex.hasPrefix("#") else { return nil }
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        guard hexColor.count == 6 else { return nil }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        let r, g, b: CGFloat
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
