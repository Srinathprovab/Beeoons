//
//  UIFontHelper.swift
//  Example-Projects
//
//  Created by Codebele 05 on 03/02/20.
//  Copyright © 2020 Codebele 05. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    
    //MARK:- shifu app
    
    
    public static func poppinsSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size)!
    }
    public static func poppinsItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Italic", size: size)!
    }
    public static func poppinsLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size)!
    }
    public static func poppinsMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size)!
    }
    public static func poppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size)!
    }
    
    public static func poppinsBoldItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-BoldItalic", size: size)!
    }
    
    
    
    public static func OswaldSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Oswald-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func OswaldMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Oswald-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func OswaldBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Oswald-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func OswaldRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Oswald-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func OswaldLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Oswald-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func MyriadProBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Myriad Pro Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func  MyriadProBold(size: CGFloat) -> UIFont {
        return UIFont(name: " Myriad Pro Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func MyriadProLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Myriad Pro Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func MyriadProRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Myriad Pro Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    
    public static func SigvarBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SigvarBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func SigvarRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SigvarRegular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func ProximaNovaRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Proxima Nova Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    func Hexacolor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



func HexColor(_ hex:String , alpha:CGFloat = 1.0) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
