//
//  EditProfileViewController.swift
//  SwiftDemoProject
//
//  Created by Ranosys on 17/10/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

import UIKit

class EditProfileViewController: GlobalMenubarViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BSKeyboardControlsDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var DOBField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var femaleButton: UIButton!

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var toolBar: UIToolbar!
    
    var pickerToolBarHeight:Float=264.0
    var presentTextfield:UITextField!
    var keyboardControls: BSKeyboardControls?
    var fields:NSArray = []
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background image in self.view
        let devicespecificObject=DeviceSpecificMedia()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named:devicespecificObject.imageForDeviceWithName(fileName: "bg"))?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //Set initialize values
        self.maleButton.isSelected=true;
        self.femaleButton.isSelected=false;
        self.emailField.isEnabled=false;
        self.emailField.text=UserDefaults.standard.string(forKey: "userEmail")!
        
        //Set corner radius of profile imageView
        profileImage.layer.cornerRadius=50
        profileImage.layer.masksToBounds=true
        
        //Set textfields in bsKeyboard controller
        fields=[self.nameField,self.addressField]
        self.keyboardControls = BSKeyboardControls(fields: fields as! [UITextField])
        self.keyboardControls?.delegate = self
        
        customizeDatPickerView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Set keyboard show and hide notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    // MARK: - Custom accessors
    func customizeDatPickerView() {
        
        self.datePicker.backgroundColor=UIColor (colorLiteralRed: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        self.datePicker.datePickerMode=UIDatePickerMode.date
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        
        components.year = -18
        let maxDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        
        components.year = -100
        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        
        self.datePicker.minimumDate = minDate as Date
        self.datePicker.maximumDate = maxDate as Date
        
        self.datePicker.translatesAutoresizingMaskIntoConstraints = true;
        self.toolBar.translatesAutoresizingMaskIntoConstraints = true;
    }
    // MARK: - end
    
    // MARK: - Keyboard show-hide methods
    func keyboardWillShow(notification: NSNotification) {
        
        let info:NSDictionary=notification.userInfo as NSDictionary!
        let aValue:NSValue=info.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        //Get selected field position
        if (presentTextfield.frame.origin.y+presentTextfield.frame.size.height)<UIScreen.main.bounds.size.height-64.0-aValue.cgRectValue.size.height {
            self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
        else {
            self.scrollView.setContentOffset(CGPoint(x:0,y:(presentTextfield.frame.origin.y+presentTextfield.frame.size.height - (UIScreen.main.bounds.size.height-64.0-aValue.cgRectValue.size.height))), animated: true)
        }
        
        //After selecting textfield, View is scrolled till last textField
        if (aValue.cgRectValue.size.height-(self.mainView.frame.size.height-(self.addressField.frame.origin.y+self.addressField.frame.size.height+44))>0) {
            
            self.scrollView.contentSize=CGSize(width:0 , height:self.mainView.frame.size.height+self.addressField.frame.size.height+100.0)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        self.scrollView.contentSize=CGSize(width:0 , height:self.mainView.frame.size.height)
        self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
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
    
    // MARK: - IBActions
    @IBAction func dropDownAction(_ sender: UIButton) {
        
        self.view.endEditing(true);
        let dobPosition:CGFloat = (self.DOBField.frame.origin.y+self.DOBField.frame.size.height)
        let dobComparision:CGFloat = (UIScreen.main.bounds.size.height - CGFloat(64) - CGFloat(pickerToolBarHeight))
        //Get selected field position
        if dobPosition < dobComparision {
            self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
        else {
            self.scrollView.setContentOffset(CGPoint(x:0,y:(dobPosition - dobComparision)), animated: true);
        }
        
        let scrollViewContentSizeValue:CGFloat = (CGFloat(pickerToolBarHeight) - (CGFloat(self.mainView.frame.size.height) - (self.addressField.frame.origin.y + self.addressField.frame.size.height + CGFloat(44))))
        //After selecting textfield, View is scrolled till last textField
        if scrollViewContentSizeValue > 0 {
            
            self.scrollView.contentSize=CGSize(width:0 , height:self.mainView.frame.size.height+self.addressField.frame.size.height+CGFloat(100.0))
        }
        
        if (self.DOBField.text != "") {
            
            let dateFormatSwift:DateFormatter=DateFormatter.init()
            dateFormatSwift.dateFormat="dd/MM/yyyy"
            let dateValue:Date=dateFormatSwift.date(from: self.DOBField.text!)! as Date
            self.datePicker.date=dateValue as Date
        }
        showPickerAnimation()
    }
    
    @IBAction func datePickerDoneAction(_ sender: UIBarButtonItem) {
        
        let date:NSDate=self.datePicker.date as NSDate
        let dateFormatter:DateFormatter=DateFormatter.init()
        dateFormatter.dateFormat="dd/MM/yyyy"
        self.DOBField.text=dateFormatter.string(from: date as Date)
        
        hidePickerAnimation()
    }
    
    @IBAction func maleAction(_ sender: UIButton) {
        
        self.view.endEditing(true);
        self.maleButton.isSelected=true;
        self.femaleButton.isSelected=false;
    }
    
    @IBAction func femaleAction(_ sender: UIButton) {
        
        self.view.endEditing(true);
        self.maleButton.isSelected=false;
        self.femaleButton.isSelected=true;
    }
    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Initialize Actions
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action) -> Void in
         
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            //Dismiss view
        }
        
        // Add Actions
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if performUpdateValidation() {
            //Show indicator
            ActivityIndicatorView().showActivityIndicator(uiView: UIApplication.shared.keyWindow!)
            self.perform( #selector(callUpdateService), with: nil, afterDelay: 5.0)
        }
    }
    // MARK: - end
    
    // MARK: - Perform login validation
    func performUpdateValidation() -> Bool {
        
        if self.nameField.isEmpty() || self.DOBField.isEmpty() || self.addressField.isEmpty() {
            showAlertView(message: "All fields are required.")
            return false
        }
        else if(imageComparision(firstImage: profileImage.image!, secondImage: UIImage.init(named: "PlaceholderImage")!)){
            showAlertView(message: "Profile image is required.")
            return false
        }
        
        return true;
    }
    
    func imageComparision(firstImage: UIImage, secondImage: UIImage) -> Bool {
        
        let firstData:NSData = UIImagePNGRepresentation(firstImage)! as NSData
        let secondData:NSData = UIImagePNGRepresentation(secondImage)! as NSData
        
        return firstData.isEqual(to: (secondData as NSData) as Data)
    }
    // MARK: - end
    
    // MARK: - Webservice (Set locally data)
    func callUpdateService() {
        
        //Hide indicator and navigate to dashboard screen
        ActivityIndicatorView().hideActivityIndicator(uiView: UIApplication.shared.keyWindow!)
        
        let alertController = UIAlertController(title:"Alert", message:"Your profile is successfully updated.", preferredStyle:.alert)
        
        let profileAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            UserDefaults.standard.setValue(self.emailField.text, forKey: "userEmail")
            
            let profileDetail:NSMutableDictionary=NSMutableDictionary.init()
            
            profileDetail.setValue(UIImageJPEGRepresentation(self.profileImage.image!, 1), forKey: "ProfileImage")
            profileDetail.setValue(self.nameField.text, forKey: "Name")
            profileDetail.setValue(self.DOBField.text, forKey: "DOB")
            profileDetail.setValue(self.maleButton.isSelected ? "Male" : "Female", forKey: "Gender")
            profileDetail.setValue(self.addressField.text, forKey: "Address")
            
            UserDefaults.standard.setValue(profileDetail, forKey: "profileData")
            //Navigate to profile screen
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            UIApplication.shared.keyWindow?.rootViewController = nextViewController
            }
        )
        alertController.addAction(profileAlertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - end
    
    // MARK: - UIImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
        
        let tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = tempImage
        
        dismiss(animated: true, completion: nil)
    }
    // MARK: - end
    
    // MARK: - Show/Hide animation method
    func showPickerAnimation() {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        
        self.datePicker.frame=CGRect(x: self.datePicker.frame.origin.x, y:self.view.bounds.size.height - self.datePicker.frame.size.height ,width: self.view.bounds.size.width, height:self.datePicker.frame.size.height)
        self.toolBar.frame=CGRect(x: self.toolBar.frame.origin.x, y:self.datePicker.frame.origin.y - 44 ,width: self.view.bounds.size.width, height:self.toolBar.frame.size.height)
        
        UIView.commitAnimations()
    }
    
    func hidePickerAnimation() {
        
        self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        
        self.datePicker.frame=CGRect(x: self.datePicker.frame.origin.x, y:1000 - self.datePicker.frame.size.height ,width: self.view.bounds.size.width, height:self.datePicker.frame.size.height)
        self.toolBar.frame=CGRect(x: self.toolBar.frame.origin.x, y:954 ,width: self.view.bounds.size.width, height:self.toolBar.frame.size.height)
        
        UIView.commitAnimations()
    }
    // MARK: - end
    
    // MARK: - Show alertView
    func showAlertView(message:String) {
        
        let alertController = UIAlertController(title:"Alert", message:message, preferredStyle:.alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - end
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
