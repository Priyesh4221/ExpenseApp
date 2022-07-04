//
//  Theme.swift
//  Expenseapp
//
//  Created by PRIYESH  on 3/18/19.
//  Copyright © 2019 PRIYESH . All rights reserved.
//

import Foundation
import UIKit

public class Theme
{
    public static let theme =  Theme()
    
    
    
    
//    private var _primarycolor = "BC1E1E" //"FEFDFB"
//    private var _secondarycolor = "CB941A"
//    private var _tertiarycolor = "000000"
//    private var _primaryfontcolor = "FFFFFF" //"CB941A"
//    private var _secondaryfontcolor = "FFFFFF"
//    private var _tertiaryfontcolor = "CB941A"
    
    
    
    private var _primarycolor = "FFFFFF" //"FEFDFB"
    private var _secondarycolor = "FFFFFF"
    private var _tertiarycolor = "000000"
    private var _primaryfontcolor = "274062" //"CB941A"
    private var _secondaryfontcolor = "274062"
    private var _tertiaryfontcolor = "CB941A"

    
//    private var _primarycolor = "000000"
//    private var _secondarycolor = "CB941A"
//    private var _tertiarycolor = "FFFFFF"
//    private var _primaryfontcolor = "CB941A"
//    private var _secondaryfontcolor = "000000"
//    private var _tertiaryfontcolor = "111111"
    
    public func getprimary() -> String
    {
        return self._primarycolor
    }
    public func getprimaryfont() -> String
    {
        return self._primaryfontcolor
    }
    public func getsecondary() -> String
    {
        return self._secondarycolor
    }
    public func getsecondaryfont() -> String
    {
        return self._secondaryfontcolor
    }
    public func gettertiary() -> String
    {
        return self._tertiarycolor
    }
    public func gettertiaryfont() -> String
    {
        return self._tertiaryfontcolor
    }
    
    
    
    
    public func setprimary( x:String, y:String)
    {
        self._primarycolor = x
        self._primaryfontcolor = y
    }
    public func setsecondry( x:String, y:String)
    {
        self._secondarycolor = x
        self._secondaryfontcolor = y
    }
    public func settertiary( x:String, y:String)
    {
        self._tertiarycolor = x
        self._tertiaryfontcolor = y
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
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
            alpha: CGFloat(1.0)
        )
    }
    
  
}
