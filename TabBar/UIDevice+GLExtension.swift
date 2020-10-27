//
//  UIDevice+GLExtension.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/17.
//  Copyright © 2020 yinhe. All rights reserved.
//

import Foundation
import UIKit

/*
 iPhone 12 Pro Max    428 x 926             3x
 iPhone 12 Pro        390 x 844             3x
 iPhone 12            390 x 844             3x
 iPhone 12 mini       360 x 780             3x
 
 iPhone SE 2nd:       375 x 667             2x
 
 iPhone 11:           414 x 896             2x
 iPhone 11 Pro:       375 x 812             3x
 iPhone 11 Pro Max:   414 x 896             3x
 
 iPhone XR:           414 x 896             2x
 iPhone Xs Max:       414 x 896             3x
 iPhone Xs:           375 x 812             3x
 iPhone X:            375 x 812             3x
 
 iPhone 8:            375 x 667             2x
 iPhone 8 Plus:       414 x 736             3x
 
 iPhone 7:            375 x 667             2x
 iPhone 7 plus:       414 x 736             3x
 
 iPhone 6:            375 x 667             2x
 iPhone 6s:           375 x 667             2x  (UI design drawings are generally based on 6s, if not, then hammer him)
 iPhone 6 Plus:       414 x 736             3x
 iPhone 6s plus:      414 x 736             3x
 
 iPhone SE:           320 x 568             2x
 
 iPhone 5:            320 x 568             2x
 iPhone 5s:           320 x 568             2x
 */
public enum GLDeviceInfoType {
    case description(identifiers: [String], deviceType: GLDeviceType, name: String)
}


public enum GLDeviceType {
    // iPhone
    case iPhone_12_Pro_Max
    case iPhone_12_Pro
    case iPhone_12
    case iPhone_12_mini
    case iPhone_SE_2nd_generation
    case iPhoneX_S_Max
    case iPhoneXS
    case iPhoneXR
    case iPhoneX
    case iPhone_11
    case iPhone_11_Pro
    case iPhone_11_Pro_Max
    case iPhone_8_Plus
    case iPhone_8
    case iPhone_7_Plus
    case iPhone_7
    case iPhone_SE_1st_generation
    case iPhone_6s_Plus
    case iPhone_6s
    case iPhone_6_Plus
    case iPhone_6
    case iPhone_5s
    case iPhone_5c
    case iPhone_5
    case iPhone_4s
    case iPhone_4
    case iPhone_3GS
    case iPhone_3G
    case iPhone
    // iPod touch
    case iPod_touch_7th_generation
    case iPod_touch_6th_generation
    case iPod_touch_5th_generation
    case iPod_touch_4th_generation
    case iPod_touch_3rd_generation
    case iPod_touch_2nd_generation
    case iPod_touch
    // iPad
    case iPad
    case iPad_2
    case iPad_3rd_generation
    case iPad_4th_generation
    case iPad_5th_generation
    case iPad_6th_generation
    case iPad_7th_generation
    case iPad_8th_generation
    // iPad Air
    case iPad_Air
    case iPad_Air_2
    case iPad_Air_3rd_generation
    case iPad_Air_4th_generation
    // iPad Pro
    case iPad_Pro_9_7_inch
    case iPad_Pro_10_5_inch
    case iPad_Pro_11_inch
    case iPad_Pro_11_inch_2nd_generation
    case iPad_Pro_12_9_inch
    case iPad_Pro_12_9_inch_2nd_generation
    case iPad_Pro_12_9_inch_3rd_generation
    case iPad_Pro_12_9_inch_4th_generation
    // iPad mini
    case iPad_mini
    case iPad_mini_2
    case iPad_mini_3
    case iPad_mini_4
    case iPad_mini_5th_generation
    // AirPods
    case AirPods_1st_generation
    case AirPods_2nd_generation
    case AirPods_Pro
    // Apple TV
    case Apple_TV_1st_generation
    case Apple_TV_2nd_generation
    case Apple_TV_3rd_generation
    case Apple_TV_4th_generation
    case Apple_TV_4K
    // Apple Watch
    case Apple_Watch_1st_generation
    case Apple_Watch_Series_1
    case Apple_Watch_Series_2
    case Apple_Watch_Series_3
    case Apple_Watch_Series_4
    case Apple_Watch_Series_5
    case Apple_Watch_SE
    case Apple_Watch_Series_6
    // HomePod
    case HomePod
    // Simulator
    case simulator
}

// Example: https://www.theiphonewiki.com/wiki/Models#iPhone
public let GLDeviceMachines: [GLDeviceInfoType] = [
    // AirPods
    .description(identifiers: ["AirPods1,1"], deviceType: .AirPods_1st_generation, name: "AirPods (1st generation)"),
    .description(identifiers: ["AirPods2,1"], deviceType: .AirPods_2nd_generation, name: "AirPods (2nd generation)"),
    .description(identifiers: ["iProd8,1"], deviceType: .AirPods_Pro, name: "AirPods Pro"),
    // Apple TV
    .description(identifiers: ["AppleTV1,1"], deviceType: .Apple_TV_1st_generation, name: "Apple TV (1st generation)"),
    .description(identifiers: ["AppleTV2,1"], deviceType: .Apple_TV_2nd_generation, name: "Apple TV (2nd generation)"),
    .description(identifiers: ["AppleTV3,1"], deviceType: .Apple_TV_3rd_generation, name: "Apple TV (3rd generation)"),
    .description(identifiers: ["AppleTV3,2"], deviceType: .Apple_TV_3rd_generation, name: "Apple TV (3rd generation)"),
    .description(identifiers: ["AppleTV5,3"], deviceType: .Apple_TV_4th_generation, name: "Apple TV (4th generation)"),
    .description(identifiers: ["AppleTV6,2"], deviceType: .Apple_TV_4K, name: "Apple TV 4K"),
    // Apple Watch
    .description(identifiers: ["Watch1,1", "Watch1,2"], deviceType: .Apple_Watch_1st_generation, name: "Apple Watch (1st generation)"),
    .description(identifiers: ["Watch2,6", "Watch2,7"], deviceType: .Apple_Watch_Series_1, name: "Apple Watch Series 1"),
    .description(identifiers: ["Watch2,3", "Watch2,4"], deviceType: .Apple_Watch_Series_2, name: "Apple Watch Series 2"),
    .description(identifiers: ["Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4"], deviceType: .Apple_Watch_Series_3, name: "Apple Watch Series 3"),
    .description(identifiers: ["Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4"], deviceType: .Apple_Watch_Series_4, name: "Apple Watch Series 4"),
    .description(identifiers: ["Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4"], deviceType: .Apple_Watch_Series_5, name: "Apple Watch Series 5"),
    .description(identifiers: ["Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12"], deviceType: .Apple_Watch_SE, name: "Apple Watch SE"),
    .description(identifiers: ["Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4"], deviceType: .Apple_Watch_Series_6, name: "Apple Watch Series 6"),
    // HomePod
    .description(identifiers: ["AudioAccessory1,1", "AudioAccessory1,2"], deviceType: .HomePod, name: "HomePod"),
    // iPad
    .description(identifiers: ["iPad1,1"], deviceType: .iPad, name: "iPad"),
    .description(identifiers: ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"], deviceType: .iPad_2, name: "iPad 2"),
    .description(identifiers: ["iPad3,1", "iPad3,2", "iPad3,3"], deviceType: .iPad_3rd_generation, name: "iPad (3rd generation)"),
    .description(identifiers: ["iPad3,4", "iPad3,5", "iPad3,6"], deviceType: .iPad_4th_generation, name: "iPad (4th generation)"),
    .description(identifiers: ["iPad6,11", "iPad6,12"], deviceType: .iPad_5th_generation, name: "iPad (5th generation)"),
    .description(identifiers: ["iPad7,5", "iPad7,6"], deviceType: .iPad_6th_generation, name: "iPad (6th generation)"),
    .description(identifiers: ["iPad7,11", "iPad7,12"], deviceType: .iPad_7th_generation, name: "iPad (7th generation)"),
    .description(identifiers: ["iPad11,6", "iPad11,7"], deviceType: .iPad_8th_generation, name: "iPad (8th generation)"),
    // iPad Air
    .description(identifiers: ["iPad4,1", "iPad4,2", "iPad4,3"], deviceType: .iPad_Air, name: "iPad Air"),
    .description(identifiers: ["iPad5,3", "iPad5,4"], deviceType: .iPad_Air_2, name: "iPad Air 2"),
    .description(identifiers: ["iPad11,3", "iPad11,4"], deviceType: .iPad_Air_3rd_generation, name: "iPad Air (3rd generation)"),
    .description(identifiers: ["iPad13,1", "iPad13,2"], deviceType: .iPad_Air_4th_generation, name: "iPad Air (4th generation)"),
    // iPad Pro
    .description(identifiers: ["iPad6,7", "iPad6,8"], deviceType: .iPad_Pro_12_9_inch, name: "iPad Pro (12.9-inch)"),
    .description(identifiers: ["iPad6,3", "iPad6,4"], deviceType: .iPad_Pro_9_7_inch, name: "iPad Pro (9.7-inch)"),
    .description(identifiers: ["iPad7,1", "iPad7,2"], deviceType: .iPad_Pro_12_9_inch_2nd_generation, name: "iPad Pro (12.9-inch) (2nd generation)"),
    .description(identifiers: ["iPad7,3", "iPad7,4"], deviceType: .iPad_Pro_10_5_inch, name: "iPad Pro (10.5-inch)"),
    .description(identifiers: ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"], deviceType: .iPad_Pro_11_inch, name: "iPad Pro (11-inch)"),
    .description(identifiers: ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"], deviceType: .iPad_Pro_12_9_inch_3rd_generation, name: "iPad Pro (12.9-inch) (3rd generation)"),
    .description(identifiers: ["iPad8,9", "iPad8,10"], deviceType: .iPad_Pro_11_inch_2nd_generation, name: "iPad Pro (11-inch) (2nd generation)"),
    .description(identifiers: ["iPad8,11", "iPad8,12"], deviceType: .iPad_Pro_12_9_inch_4th_generation, name: "iPad Pro (12.9-inch) (4th generation)"),
    // iPad mini
    .description(identifiers: ["iPad2,5", "iPad2,6", "iPad2,7"], deviceType: .iPad_mini, name: "iPad mini"),
    .description(identifiers: ["iPad4,4", "iPad4,5", "iPad4,6"], deviceType: .iPad_mini_2, name: "iPad mini 2"),
    .description(identifiers: ["iPad4,7", "iPad4,8", "iPad4,9"], deviceType: .iPad_mini_3, name: "iPad mini 3"),
    .description(identifiers: ["iPad5,1", "iPad5,2"], deviceType: .iPad_mini_4, name: "iPad mini 4"),
    .description(identifiers: ["iPad11,1", "iPad11,2"], deviceType: .iPad_mini_5th_generation, name: "iPad mini (5th generation)"),
    // iPhone
    .description(identifiers: ["iPhone1,1"], deviceType: .iPhone, name: "iPhone1,1"),
    .description(identifiers: ["iPhone1,2"], deviceType: .iPhone_3G, name: "iPhone 3G"),
    .description(identifiers: ["iPhone2,1"], deviceType: .iPhone_3GS, name: "iPhone 3GS"),
    .description(identifiers: ["iPhone3,1", "iPhone3,2", "iPhone3,3"], deviceType: .iPhone_4, name: "iPhone 4"),
    .description(identifiers: ["iPhone4,1"], deviceType: .iPhone_4s, name: "iPhone 4S"),
    .description(identifiers: ["iPhone5,1", "iPhone5,2"], deviceType: .iPhone_5, name: "iPhone 5"),
    .description(identifiers: ["iPhone5,3", "iPhone5,4"], deviceType: .iPhone_5c, name: "iPhone 5c"),
    .description(identifiers: ["iPhone6,1", "iPhone6,2"], deviceType: .iPhone_5s, name: "iPhone 5s"),
    .description(identifiers: ["iPhone7,2"], deviceType: .iPhone_6, name: "iPhone 6"),
    .description(identifiers: ["iPhone7,1"], deviceType: .iPhone_6_Plus, name: "iPhone 6 Plus"),
    .description(identifiers: ["iPhone8,1"], deviceType: .iPhone_6s, name: "iPhone 6s"),
    .description(identifiers: ["iPhone8,2"], deviceType: .iPhone_6s_Plus, name: "iPhone 6s Plus"),
    .description(identifiers: ["iPhone8,4"], deviceType: .iPhone_SE_1st_generation, name: "iPhone SE (1st generation)"),
    .description(identifiers: ["iPhone9,1", "iPhone9,3"], deviceType: .iPhone_7, name: "iPhone 7"),
    .description(identifiers: ["iPhone9,2", "iPhone9,4"], deviceType: .iPhone_7_Plus, name: "iPhone 7 Plus"),
    .description(identifiers: ["iPhone10,1", "iPhone10,4"], deviceType: .iPhone_8, name: "iPhone 8"),
    .description(identifiers: ["iPhone10,2", "iPhone10,5"], deviceType: .iPhone_8_Plus, name: "iPhone 8 Plus"),
    .description(identifiers: ["iPhone10,3", "iPhone10,6"], deviceType: .iPhoneX, name: "iPhone X"),
    .description(identifiers: ["iPhone11,8"], deviceType: .iPhoneXR, name: "iPhone XR"),
    .description(identifiers: ["iPhone11,2"], deviceType: .iPhoneXS, name: "iPhone XS"),
    .description(identifiers: ["iPhone11,6", "iPhone11,4"], deviceType: .iPhoneX_S_Max, name: "iPhone XS Max"),
    .description(identifiers: ["iPhone12,1"], deviceType: .iPhone_11, name: "iPhone 11"),
    .description(identifiers: ["iPhone12,3"], deviceType: .iPhone_11_Pro, name: "iPhone 11 Pro"),
    .description(identifiers: ["iPhone12,5"], deviceType: .iPhone_11_Pro_Max, name: "iPhone 11 Pro Max"),
    .description(identifiers: ["iPhone12,8"], deviceType: .iPhone_SE_2nd_generation, name: "iPhone SE (2nd generation)"),
    .description(identifiers: ["iPhone13,1"], deviceType: .iPhone_12_mini, name: "iPhone 12 mini"),
    .description(identifiers: ["iPhone13,2"], deviceType: .iPhone_12, name: "iPhone 12"),
    .description(identifiers: ["iPhone13,3"], deviceType: .iPhone_12_Pro, name: "iPhone 12 Pro"),
    .description(identifiers: ["iPhone13,4"], deviceType: .iPhone_12_Pro_Max, name: "iPhone 12 Pro Max"),
    // iPod touch
    .description(identifiers: ["iPod1,1"], deviceType: .iPod_touch, name: "iPod touch"),
    .description(identifiers: ["iPod2,1"], deviceType: .iPod_touch_2nd_generation, name: "iPod touch (2nd generation)"),
    .description(identifiers: ["iPod3,1"], deviceType: .iPod_touch_3rd_generation, name: "iPod touch (3rd generation)"),
    .description(identifiers: ["iPod4,1"], deviceType: .iPod_touch_4th_generation, name: "iPod touch (4th generation)"),
    .description(identifiers: ["iPod5,1"], deviceType: .iPod_touch_5th_generation, name: "iPod touch (5th generation)"),
    .description(identifiers: ["iPod7,1"], deviceType: .iPod_touch_6th_generation, name: "iPod touch (6th generation)"),
    .description(identifiers: ["iPod9,1"], deviceType: .iPod_touch_7th_generation, name: "iPod touch (7th generation)"),
    // Simulator
    .description(identifiers: ["i386", "x86_64"], deviceType: .simulator, name: "Simulator")
]

/// 刘海屏手机Size集合(Notch是缺口的意思)
public var GL_Notch_iPhone_Sizes: [CGSize] = [
    //
    CGSize(width: 375.0, height: 812.0),
    CGSize(width: 812.0, height: 375.0),
    //
    CGSize(width: 414.0, height: 896.0),
    CGSize(width: 896.0, height: 414.0),
    //
    CGSize(width: 390.0, height: 844.0),
    CGSize(width: 844.0, height: 390.0),
    //
    CGSize(width: 428.0, height: 926.0),
    CGSize(width: 926.0, height: 428.0),
    //
    CGSize(width: 360.0, height: 780.0),
    CGSize(width: 780.0, height: 360.0),
]

/// 刘海屏手机类型集合(真机)
public var GL_Notch_iPhone_Types: [GLDeviceType] {
    return [.iPhoneX,
            .iPhoneXR,
            .iPhoneXS,
            .iPhoneX_S_Max,
            .iPhone_11,
            .iPhone_11_Pro,
            .iPhone_11_Pro_Max,
            .iPhone_12,
            .iPhone_12_mini,
            .iPhone_12_Pro,
            .iPhone_12_Pro_Max]
}

extension UIDevice {
    /// 屏幕宽
    public static var gl_width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// 屏幕高
    public static var gl_height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 设备机器名字，例如`iPhone 7 Plus`.
    public static var gl_machineName: String {
        let machine = UIDevice._machine
        var machineName = machine
        for (_, m) in GLDeviceMachines.enumerated() {
            var isFind: Bool = false
            switch m {
                case .description(let identifiers, _, let name):
                    if identifiers.contains(machine) {
                        machineName = name
                        isFind = true
                    }
            }
            if isFind {
                break
            }
        }
        return machineName
    }
    
    /// 设备基本信息
    public static var gl_info: String {
        return
            "*******************************************************************"
            + "\n"
            + "Sysname:          \(UIDevice._sysname)"
            + "\n"
            + "Release:          \(UIDevice._release)"
            + "\n"
            + "Version:          \(UIDevice._version)"
            + "\n"
            + "Machine:          \(UIDevice._machine)"
            + "\n"
            + "SystemVersion:    \(UIDevice.current.systemVersion)"
            + "\n"
            + "MachineName:      \(UIDevice.gl_machineName)"
            + "\n"
            + "*******************************************************************"
    }
    
    /// 是否是模拟器
    public static var gl_isSimulator: Bool {
        let machine = UIDevice._machine
        var isSimulator: Bool = false
        for (_, m) in GLDeviceMachines.enumerated() {
            var isFind: Bool = false
            switch m {
                case .description(let identifiers, let deviceType, _):
                    if deviceType == .simulator && identifiers.contains(machine) {
                        isSimulator = true
                        isFind = true
                    }
            }
            if isFind {
                break
            }
        }
        return isSimulator
    }
    
    /// 是否是刘海屏手机，兼容真机和模拟器
    public static var gl_isNotchiPhone: Bool {
        let machine = UIDevice._machine
        var result: Bool = false
        for (_, m) in GLDeviceMachines.enumerated() {
            var isFind: Bool = false
            switch m {
                case .description(let identifiers, let deviceType, _):
                    if deviceType == .simulator && identifiers.contains(machine) && GL_Notch_iPhone_Sizes.contains(UIScreen.main.bounds.size) {
                        result = true
                        isFind = true
                    } else if GL_Notch_iPhone_Types.contains(deviceType) && identifiers.contains(machine) {
                        result = true
                        isFind = true
                    }
            }
            if isFind {
                break
            }
        }
        return result
    }
    
    /// 刘海高度，兼容真机和模拟器。仅仅只是刘海高度，不是状态栏的高度
    public static var gl_notchHeight: CGFloat {
        let machine = UIDevice._machine
        var height: CGFloat = .zero
        for (_, m) in GLDeviceMachines.enumerated() {
            var isFind: Bool = false
            switch m {
                case .description(let identifiers, let deviceType, _):
                    if deviceType == .simulator && identifiers.contains(machine) && GL_Notch_iPhone_Sizes.contains(UIScreen.main.bounds.size) {
                        if !UIApplication.shared.statusBarOrientation.isPortrait {
                            height = 0.0
                        } else {
                            height = 44.0
                        }
                        isFind = true
                    } else if GL_Notch_iPhone_Types.contains(deviceType) && identifiers.contains(machine) {
                        if !UIApplication.shared.statusBarOrientation.isPortrait {
                            height = 0.0
                        } else {
                            height = 44.0
                        }
                        isFind = true
                    }
            }
            if isFind {
                break
            }
        }
        return height
    }
    
    /// 状态栏高度
    public static var gl_statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 虚拟Home键高度，兼容真机和模拟器
    public static var gl_homeIndicatorHeight: CGFloat {
        if !UIDevice.gl_isNotchiPhone {
            return .zero
        }
        if !UIApplication.shared.statusBarOrientation.isPortrait {
            return 21.0
        } else {
            return 34.0
        }
    }
}



extension UIDevice {
    fileprivate static var _sys: utsname {
        var sys: utsname = utsname()
        uname(&sys)
        return sys
    }
    
    fileprivate static var _machine: String {
        var sys = UIDevice._sys
        return withUnsafePointer(to: &sys.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String(validatingUTF8: ptr) } ?? UIDevice.current.systemVersion
        }
    }
    fileprivate static var _release: String {
        var sys = UIDevice._sys
        return withUnsafePointer(to: &sys.release) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String(validatingUTF8: ptr) } ?? UIDevice.current.systemVersion
        }
    }
    fileprivate static var _version: String {
        var sys = UIDevice._sys
        return withUnsafePointer(to: &sys.version) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String(validatingUTF8: ptr) } ?? UIDevice.current.systemVersion
        }
    }
    fileprivate static var _sysname: String {
        var sys = UIDevice._sys
        return withUnsafePointer(to: &sys.sysname) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String(validatingUTF8: ptr) } ?? UIDevice.current.systemVersion
        }
    }
    fileprivate static var _nodename: String {
        var sys = UIDevice._sys
        return withUnsafePointer(to: &sys.nodename) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String(validatingUTF8: ptr) } ?? UIDevice.current.systemVersion
        }
    }
}
