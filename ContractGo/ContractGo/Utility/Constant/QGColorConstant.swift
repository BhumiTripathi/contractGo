//
//  QGColorConstant.swift
//  QuoteGuru
//
//  Created by indianic on 17/04/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import UIKit


let kColorCarouselBg            = UIColor(red: 235.0/255, green: 107.0/255, blue: 104.0/255, alpha: 1.0)

//Categories
let kColorCategoryBg            = UIColor(red: 239.0/255, green: 65.0/255, blue: 101.0/255, alpha: 1.0)


//+(UIColor *)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha{
//    unsigned rgbValue = 0;
//    NSScanner *scanner = [NSScanner scannerWithString:hexString];
//    [scanner setScanLocation:1]; // bypass '#' character
//    [scanner scanHexInt:&rgbValue];
//    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
//}


    func colorWithHexString (hexString:String,alpha:CGFloat) -> UIColor {
        
        let r, g, b: CGFloat
        var getColor:UIColor!
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            getColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
 
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0xFF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0xFF) / 255
                    //   a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    getColor = UIColor(red: r, green: g, blue: b, alpha: alpha)
                }
                else
                {
                    getColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                }
            }
        }
        return getColor
    }


    func colorCodes(colornum:Int) -> String{
        
        var aStrColorCode:String!
        
        switch colornum {
            
        case 0:
            aStrColorCode = "#ffffff" //White
            break
            
        case 1:
            aStrColorCode = "#616161" //File or Folder Title
            break
            
        case 2:
            aStrColorCode = "#efefef" //Search view bg
            break
            
        case 3:
            aStrColorCode = "#f7f7f7" //Category view bg
            break
            
        case 4:
            aStrColorCode = "#1f1b1c" // black color Crop button title
            
            break
            
        case 5:
            aStrColorCode = "#fffefe" // Create New ( Opacity,brightness etc Done text color)
            break
            
        case 6:
            aStrColorCode = "#fb335c" //Home library btn bg
            break
            
        case 7:
            aStrColorCode = "#ff5121" //Home stock store bg
            break
            
        case 8:
            aStrColorCode = "#b10024" //Home Relationship bg
            break
            
        case 9:
            aStrColorCode = "#f23e63" //Categories selected color
            break
        case 10:
            aStrColorCode = "#D1CFCF" // gray color in
            
        case 11:
            aStrColorCode = "#F8333D" // corner radius back color
            break
            
        case 12:
            aStrColorCode = "#AAAAAA" //Popover bg color(Gray)
            break
            
        case 13:
            aStrColorCode = "#C8C8C8" //Border Color
            break
            
            
        
        default:
            break
        }
        return aStrColorCode
    }

func getCurrentDateTime() -> Date
{
    let dtf = DateFormatter()
    dtf.timeZone = TimeZone.current
    dtf.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let strDate = dtf.string(from: Date.init() )
    let dateFormatter = DateFormatter()
    //Your current Date Format
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    let finaldate = dateFormatter.date(from:strDate)!
    print("finaldate",finaldate)
    return finaldate
    
    
}
