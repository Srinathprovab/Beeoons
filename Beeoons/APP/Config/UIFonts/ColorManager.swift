//
//  ColorManager.swift
//  DoorcastRebase
//
//  Created by Codebele 07 on 04/05/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    public static var AppBackgroundColor : UIColor {
        
        get {
            return UIColor(named: "AppBackgroundColor")!
        }
    }
    
    
    public static var AppHolderViewColor : UIColor {
        
        get {
           // return UIColor(named: "AppBGColor")!
            return HexColor("#F2F2F2", alpha: 0.60)
          //  return HexColor("#E6E8E7")
        }
    }
    
    
    public static var AppNavBackColor : UIColor {
        
        get {
            return UIColor(named: "AppBtnColor")!
        }
    }
    
    public static var AppLabelColor : UIColor {
        
        get {
            return UIColor(named: "AppLabelColor")!
        }
    }
    
    
    public static var WhiteColor : UIColor {
        
        get {
            return UIColor(named: "WhiteColor")!
        }
    }
    
    
    public static var AppBorderColor : UIColor {
        
        get {
            return UIColor.lightGray.withAlphaComponent(0.3)
        }
    }
    
    
    
    public static var SubTitleColor : UIColor {
        
        get {
            return UIColor(named: "AppSubtitleColor")!
        }
    }
    
    
    
    
    public static var AppJournyTabSelectColor : UIColor {
        
        get {
            return UIColor(named: "AppJournyTabSelectColor")!
        }
    }
    
    
    
    public static var AppBGcolor : UIColor {
        
        get {
            return HexColor("#F2F2F2", alpha: 0.50)
        }
    }
    
    public static var Refundcolor : UIColor {
        
        get {
            return UIColor(named: "refundcolor")!
        }
    }
    
    
}
