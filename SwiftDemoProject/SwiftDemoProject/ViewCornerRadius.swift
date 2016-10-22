//
//  ViewCornerRadius.swift
//  SwiftDemoProject
//
//  Created by  Rohit on 11/10/16.
 
//

import Foundation
import UIKit

// MARK: - Set view corner radius and border
extension UIView {

    func setViewCornerRadiusWithBorder(radius:Float, viewBorderWidth:Float, viewBorderColor:UIColor) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
        self.layer.borderWidth=CGFloat(viewBorderWidth)
        self.layer.borderColor=viewBorderColor.cgColor
    }
    
    func setViewCornerRadius(radius:Float) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
    }
}
// MARK: - end

// MARK: - Set button corner radius and border
extension UIButton {
    
    func setButtonCornerRadiusWithBorder(radius:Float, viewBorderWidth:Float, viewBorderColor:UIColor) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
        self.layer.borderWidth=CGFloat(viewBorderWidth)
        self.layer.borderColor=viewBorderColor.cgColor
    }
    
    func setButtonCornerRadius(radius:Float) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
    }
}
// MARK: - end

// MARK: - Set textfield corner radius and border
extension UITextField {
    
    func setTextFieldCornerRadiusWithBorder(radius:Float, viewBorderWidth:Float, viewBorderColor:UIColor) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
        self.layer.borderWidth=CGFloat(viewBorderWidth)
        self.layer.borderColor=viewBorderColor.cgColor
    }
    
    func setTextFieldCornerRadius(radius:Float) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
    }
}
// MARK: - end

// MARK: - Set textView corner radius and border
extension UITextView {
    
    func setTextViewCornerRadiusWithBorder(radius:Float, viewBorderWidth:Float, viewBorderColor:UIColor) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
        self.layer.borderWidth=CGFloat(viewBorderWidth)
        self.layer.borderColor=viewBorderColor.cgColor
    }
    
    func setTextViewCornerRadius(radius:Float) {
        
        self.layer.cornerRadius=CGFloat(radius)
        self.layer.masksToBounds=true
    }
}
// MARK: - end
