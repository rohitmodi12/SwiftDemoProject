//
//  TextfieldPadding.swift
//  SwiftDemoProject
//
//  Created by  Rohit on 11/10/16.
 
//

import Foundation
import UIKit

extension UITextField {

    func setLeftPadding() {
        let leftPadding:UIView=UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.leftView=leftPadding
        self.leftViewMode=UITextFieldViewMode.always
    }
}
//UIView *leftPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
//textfield.leftView = leftPadding;
//textfield.leftViewMode = UITextFieldViewModeAlways;
