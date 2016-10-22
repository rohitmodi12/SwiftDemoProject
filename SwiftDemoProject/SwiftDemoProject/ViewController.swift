//
//  ViewController.swift
//  SwiftDemoProject
//
//  Created by Ranosys on 10/10/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BSKeyboardControlsDelegate {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var loginView: UIView!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var presentTextfield:UITextField!
    var keyboardControls: BSKeyboardControls?
    var fields:NSArray = []
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //Set textfields in bsKeyboard controller
        fields=[self.emailField,self.passwordField]
        self.keyboardControls = BSKeyboardControls(fields: fields as! [UITextField])
        self.keyboardControls?.delegate = self
        
        //Set keyboard show and hide notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Set background image using UIImageView
        let devicespecificObject=DeviceSpecificMedia()
    self.backgroundImage.image=UIImage(named:devicespecificObject.imageForDeviceWithName(fileName: "bg"))
        /*Set background image in self.view
        let devicespecificObject=DeviceSpecificMedia()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named:devicespecificObject.imageForDeviceWithName(fileName: "bg"))?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        */
        
        //View customization
        viewCustomization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //Remove notification observer
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - end
    
    // MARK: - Keyboard show-hide methods
    func keyboardWillShow(notification: NSNotification) {
        
        let info:NSDictionary=notification.userInfo as NSDictionary!
        let aValue:NSValue=info.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        //Get selected field position
        let viewY:CGFloat = (UIScreen.main.bounds.size.height/2)-(presentTextfield.frame.size.height/2)
        
        if (viewY+presentTextfield.frame.origin.y+presentTextfield.frame.size.height)<UIScreen.main.bounds.size.height-aValue.cgRectValue.size.height {
            self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
        else {
            self.scrollView.setContentOffset(CGPoint(x:0,y:(viewY+presentTextfield.frame.origin.y+presentTextfield.frame.size.height - (UIScreen.main.bounds.size.height-aValue.cgRectValue.size.height))), animated: true)
        }
        
        //After selecting textfield, View is scrolled till last textField
        if (aValue.cgRectValue.size.height-(self.mainView.frame.size.height-(viewY+self.passwordField.frame.size.height))>0) {
            
            self.scrollView.contentSize=CGSize(width:0 , height:self.mainView.frame.size.height+self.passwordField.frame.size.height+44.0)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        self.scrollView.contentSize=CGSize(width:0 , height:self.mainView.frame.size.height)
        self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    // MARK: - end
    
    // MARK: - Custom accessors
    func viewCustomization() {
        
        //Set corner radius with border
        self.emailField.setTextFieldCornerRadiusWithBorder(radius: 5.0, viewBorderWidth: 1.0, viewBorderColor: UIColor.lightGray)
        self.passwordField.setTextFieldCornerRadiusWithBorder(radius: 5.0, viewBorderWidth: 1.0, viewBorderColor: UIColor.lightGray)
        //Set corner radius
        self.loginButton.setButtonCornerRadius(radius: 5)
        
        //Set left padding
        self.emailField.setLeftPadding()
        self.passwordField.setLeftPadding()
    }
    // MARK: - end
    
    // MARK: - BSKeyboardController delegates
    func keyboardControls(keyboardControls: BSKeyboardControls, selectedField field: UIView, inDirection direction: BSKeyboardControlsDirection) {
        
        var view:UIView
        view=(field.superview?.superview?.superview)!
    }
    
    func keyboardControlsDonePressed(keyboardControls: BSKeyboardControls) {
        
        keyboardControls.activeField?.resignFirstResponder()
    }
    // MARK: - end
    
    // MARK: - Textfield delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        keyboardControls?.activeField = textField
        presentTextfield=textField
    }
    // MARK: - end
    
    // MARK: - Perform login validation
    func performLoginValidation() -> Bool {
        
        if emailField.isEmpty() || passwordField.isEmpty() {
            showAlertView(message: "All fields are required.")
            return false
        }
        else if !emailField.isValidEmail() {
            showAlertView(message: "Your email address is invalid")
            return false
        }
        else if (passwordField.text?.characters.count)!<6 {
            showAlertView(message: "Please enter atleast 6 charater in password field.")
            return false
        }
        return true;
    }
    // MARK: - end
    
    // MARK: - IBActions
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if performLoginValidation() {
            //Show indicator
            ActivityIndicatorView().showActivityIndicator(uiView: UIApplication.shared.keyWindow!)
            self.perform( #selector(callLoginService), with: nil, afterDelay: 2.0)
        }
    }
    // MARK: - end
    
    // MARK: - Webservice
    func callLoginService() {
        
        //Hide indicator and navigate to dashboard screen
        ActivityIndicatorView().hideActivityIndicator(uiView: UIApplication.shared.keyWindow!)
        UserDefaults.standard.setValue(self.emailField.text, forKey: "userEmail")
        
        //Navigate to profile screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        UIApplication.shared.keyWindow?.rootViewController = nextViewController
    }
    // MARK: - end
    
    // MARK: - Show alertView
    func showAlertView(message:String) {
        
        let alertController = UIAlertController(title:"Alert", message:message, preferredStyle:.alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

