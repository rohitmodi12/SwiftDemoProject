//
//  ActivityIndicatorView.swift
//  SwiftDemo
//
//  Created by Hema on 10/10/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

import UIKit
import Foundation

class ActivityIndicatorView: UIView {

    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(uiView: UIView) {
        container.frame = CGRect(x: 0,y: 0,width: uiView.frame.size.width,height: uiView.frame.size.height)
        container.center = uiView.center
        container.tag = 1000
        container.backgroundColor=UIColor (colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
       // container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
      let rect = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.frame = rect
        loadingView.center = uiView.center
        loadingView.backgroundColor=UIColor (colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        let rect1 = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.frame = rect1
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y:loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                          uiView.addSubview(self.container)
            }, completion: { (finished) -> Void in
                // ....
        })
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
//        container.removeFromSuperview()
        
        for container in uiView.subviews{
            if container.tag == 1000 {
                UIView.animate(withDuration: 0.1,
                               delay: 0.1,
                               options: UIViewAnimationOptions.curveEaseInOut,
                               animations: { () -> Void in
                                   container.removeFromSuperview()
                    }, completion: { (finished) -> Void in
                        // ....
                })
            }
        }
        }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}

