//
//  QGAppConstant.swift
//  QuoteGuru
//
//  Created by indianic on 17/04/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import UIKit


//ScreenSize
let FRAME_WIDTH         = UIScreen.main.bounds.size.width
let FRAME_HEIGHT        = UIScreen.main.bounds.size.height
let FRAME_MAX_LENGTH    = max(FRAME_WIDTH, FRAME_HEIGHT)
let FRAME_MIN_LENGTH    = min(FRAME_WIDTH, FRAME_HEIGHT)


//DeviceType
let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && FRAME_MAX_LENGTH < 568.0
let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && FRAME_MAX_LENGTH == 568.0
let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && FRAME_MAX_LENGTH == 667.0
let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && FRAME_MAX_LENGTH == 736.0
let IS_IPAD_AIR          = UIDevice.current.userInterfaceIdiom == .pad && FRAME_MAX_LENGTH == 1024.0
let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && FRAME_MAX_LENGTH == 1366.0


let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad

let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone

let IS_LANDSCAPE         = UIApplication.shared.statusBarOrientation == .landscapeLeft ||
                            UIApplication.shared.statusBarOrientation == .landscapeRight

let IS_POTRAIT           = UIApplication.shared.statusBarOrientation == .portrait


let objAppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate






