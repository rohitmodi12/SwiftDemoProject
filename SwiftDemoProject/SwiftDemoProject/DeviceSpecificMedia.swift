//
//  DeviceSpecificMedia.swift
//  SureAppInSwift
//
//  Created by  Rohit on 07/05/15.
//  Copyright (c) 2015  Rohit. All rights reserved.
//

import UIKit

class DeviceSpecificMedia: NSObject {
    enum thisDeviceClass:Int {
    
       case thisDeviceClass_iPhone
       case thisDeviceClass_iPhoneRetina
       case thisDeviceClass_iPhone5
       case thisDeviceClass_iPhone6
       case thisDeviceClass_iPhone6plus
        
        // we can add new devices when we become aware of them
        
       case thisDeviceClass_iPad
       case thisDeviceClass_iPadRetina
        
        
        case thisDeviceClass_unknown
        // enumeration definition goes here
    }
    
    func imageForDeviceWithName(fileName: String)->String {
        
//        var result = UIImage(CGImage: nil);

        let nameWithSuffix1=fileName + DeviceSpecificMedia.magicSuffixForDeviceForOtherImages()
//        NSString *nameWithSuffix = [fileName stringByAppendingString:[UIImage magicSuffixForDevice]];
        
//        result=UIImage(named: nameWithSuffix1)
////        result = [UIImage imageNamed:nameWithSuffix];
//        if var otherThing = result as UIImage?
//        {
//            result=UIImage(named: fileName)
//        }
        return nameWithSuffix1;
    }
    
    
    func currentDeviceClass1()->thisDeviceClass{
        
        let greaterPixel=max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)

//@property(nonatomic, readonly) CGFloat scale      //[[UIScreen mainScreen]scale]
//    This value reflects the scale factor needed to convert from the default logical coordinate space into the device coordinate space of this screen. The default logical coordinate space is measured using points. For standard-resolution displays, the scale factor is 1.0 and one point equals one pixel. For Retina displays, the scale factor is 2.0 and one point is represented by four pixels.
        print(greaterPixel)
        switch greaterPixel{
        case 480:
            return UIScreen.main.scale>1.0 ? thisDeviceClass.thisDeviceClass_iPhoneRetina:thisDeviceClass.thisDeviceClass_iPhone
//            return (( [[UIScreen mainScreen]scale] > 1.0) ? thisDeviceClass_iPhoneRetina : thisDeviceClass_iPhone );
            
        case 568:
            return thisDeviceClass.thisDeviceClass_iPhone5;
            
        case 667:
            return thisDeviceClass.thisDeviceClass_iPhone6;
            
        case 736:
            return thisDeviceClass.thisDeviceClass_iPhone6plus;
            
        case 1024:
            return UIScreen.main.scale>1.0 ?  thisDeviceClass.thisDeviceClass_iPadRetina : thisDeviceClass.thisDeviceClass_iPad ;
            
        default:
            return thisDeviceClass.thisDeviceClass_unknown;
            
        }

    }

    class func magicSuffixForDeviceForOtherImages()->String {
        // type method implementation goes here
    
        let a=DeviceSpecificMedia()
        
        switch a.currentDeviceClass1()
            {
        case thisDeviceClass.thisDeviceClass_iPhone:
            return "";
           
        case thisDeviceClass.thisDeviceClass_iPhoneRetina:
            return "";
            
        case thisDeviceClass.thisDeviceClass_iPhone5:
            return "-568h@2x";
           
        case thisDeviceClass.thisDeviceClass_iPhone6:
            return "-667h@2x"; //or some other arbitrary string..
           
        case thisDeviceClass.thisDeviceClass_iPhone6plus:
            return "-736h@3x";
           
        case thisDeviceClass.thisDeviceClass_iPad:
            return "~ipad";
            
        case thisDeviceClass.thisDeviceClass_iPadRetina:
            return "~ipad@2x";
            
        case thisDeviceClass.thisDeviceClass_unknown:
            fallthrough
        default:
            return "";
        
        }
    }
    
    
}
