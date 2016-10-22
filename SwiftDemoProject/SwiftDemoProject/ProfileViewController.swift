//
//  ProfileViewController.swift
//  SwiftDemoProject
//
//  Created by Ranosys on 10/10/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

import UIKit

class ProfileViewController: GlobalMenubarViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var profileTableView: UITableView!
    var profileDetail:NSMutableDictionary=[:]
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title="Profile";
        
        //Set background image in self.view
        let devicespecificObject=DeviceSpecificMedia()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named:devicespecificObject.imageForDeviceWithName(fileName: "bg"))?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //Set profile data
        setProfileData()
        // Do any additional setup after loading the view.
    }
    
    func setProfileData() {
        
        if (UserDefaults.standard.value(forKey: "profileData") != nil) {
        
            profileDetail=UserDefaults.standard.value(forKey: "profileData") as! NSMutableDictionary
        }
        else {
            
            let profileImage:UIImage = UIImage.init(named: "user_placeholder")!
            profileDetail.setValue(UIImageJPEGRepresentation(profileImage, 1), forKey: "ProfileImage")
            profileDetail.setValue("Rohit modi", forKey: "Name")
            profileDetail.setValue("21-03-1992", forKey: "DOB")
            profileDetail.setValue("Male", forKey: "Gender")
            profileDetail.setValue("Modern market, Bikaner", forKey: "Address")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - end

    // MARK: - Table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row==0 {
            
            return 144.0;
        }
        else if indexPath.row==1 {
            
            let dynamicHeight:CGFloat=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Name") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))
            return (dynamicHeight<25 ? 50 : (dynamicHeight+20))
        }
        else if indexPath.row==2 {
            
            let dynamicHeight:CGFloat=CGFloat(dynamicLableHeight(string: UserDefaults.standard.string(forKey: "userEmail")! , stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))
            return (dynamicHeight<25 ? 50 : (dynamicHeight+20))
        }
        else if indexPath.row==3 {
            
            let dynamicHeight:CGFloat=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "DOB") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))
            return (dynamicHeight<25 ? 50 : (dynamicHeight+20))
        }
        else if indexPath.row==4 {
            
            let dynamicHeight:CGFloat=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Gender") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))
            return (dynamicHeight<25 ? 50 : (dynamicHeight+20))
        }
        else if indexPath.row==5 {
            
            let dynamicHeight:CGFloat=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Address") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))
            return (dynamicHeight<25 ? 50 : (dynamicHeight+20))
        }
        else {
            return 0;
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row==0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImage", for: indexPath)
            let profileImage = self.view.viewWithTag(7) as? UIImageView
            profileImage?.layer.cornerRadius=50.0
            profileImage?.layer.masksToBounds=true
            if let imgData = profileDetail.value(forKey: "ProfileImage") as? NSData
            {
                if let image = UIImage(data: imgData as Data)
                {
                    //Set image in UIImageView imgSignature
                    profileImage?.image = image
                }
            }
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
            let infoTitle = self.view.viewWithTag(3) as? UILabel
            let titletext = self.view.viewWithTag(4) as? UILabel
            infoTitle?.numberOfLines=0;

            if indexPath.row==1 {
                infoTitle?.translatesAutoresizingMaskIntoConstraints=true;
                titletext?.translatesAutoresizingMaskIntoConstraints=true;
                var heightValue:CGFloat
                heightValue=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Name") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))<25 ? 50 : (CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Name") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))+20)
                infoTitle?.frame=CGRect(x: 126, y: 0, width: (Int(UIScreen.main.bounds.size.width)-164), height: Int(heightValue))
                titletext?.frame=CGRect(x: 15, y: 0, width: 93, height: heightValue)
                
                titletext?.text="Name"
                infoTitle?.text=profileDetail.value(forKey: "Name") as! String?
            }
            else if indexPath.row==2 {
                infoTitle?.translatesAutoresizingMaskIntoConstraints=true;
                titletext?.translatesAutoresizingMaskIntoConstraints=true;
                var heightValue:CGFloat
                heightValue=CGFloat(dynamicLableHeight(string: UserDefaults.standard.string(forKey: "userEmail")!, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))<25 ? 50 : (CGFloat(dynamicLableHeight(string: UserDefaults.standard.string(forKey: "userEmail")!, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))+20)
                infoTitle?.frame=CGRect(x: 126, y: 0, width: (Int(UIScreen.main.bounds.size.width)-164), height: Int(heightValue))
                titletext?.frame=CGRect(x: 15, y: 0, width: 93, height: heightValue)
                titletext?.text="Email"
                infoTitle?.text=UserDefaults.standard.string(forKey: "userEmail")
            }
            else if indexPath.row==3 {
                infoTitle?.translatesAutoresizingMaskIntoConstraints=true;
                titletext?.translatesAutoresizingMaskIntoConstraints=true;
                var heightValue:CGFloat
                heightValue=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "DOB") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))<25 ? 50 : (CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "DOB") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))+20)
                infoTitle?.frame=CGRect(x: 126, y: 0, width: (Int(UIScreen.main.bounds.size.width)-164), height: Int(heightValue))
                titletext?.frame=CGRect(x: 15, y: 0, width: 93, height: heightValue)
                titletext?.text="DOB"
                infoTitle?.text=profileDetail.value(forKey: "DOB") as! String?
            }
            else if indexPath.row==4 {
                infoTitle?.translatesAutoresizingMaskIntoConstraints=true;
                titletext?.translatesAutoresizingMaskIntoConstraints=true;
                var heightValue:CGFloat
                heightValue=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Gender") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))<25 ? 50 : (CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Gender") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))+20)
                infoTitle?.frame=CGRect(x: 126, y: 0, width: (Int(UIScreen.main.bounds.size.width)-164), height: Int(heightValue))
                titletext?.frame=CGRect(x: 15, y: 0, width: 93, height: heightValue)
                titletext?.text="Gender"
                infoTitle?.text=profileDetail.value(forKey: "Gender") as! String?
            }
            else if indexPath.row==5 {
                infoTitle?.translatesAutoresizingMaskIntoConstraints=true;
                titletext?.translatesAutoresizingMaskIntoConstraints=true;
                var heightValue:CGFloat
                heightValue=CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Address") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))<25 ? 50 : (CGFloat(dynamicLableHeight(string: profileDetail.value(forKey: "Address") as! String, stringWidth: (Int(UIScreen.main.bounds.size.width)-164)))+20)
                infoTitle?.frame=CGRect(x: 126, y: 0, width: (Int(UIScreen.main.bounds.size.width)-164), height: Int(heightValue))
                titletext?.frame=CGRect(x: 15, y: 0, width: 93, height: heightValue)
                titletext?.text="Address"
                infoTitle?.text=profileDetail.value(forKey: "Address") as! String?
            }
            else {
            }
            return cell
        }
        
    }
    
    func dynamicLableHeight(string:String, stringWidth:Int) -> Float {
        
        let size:CGSize=CGSize(width:stringWidth , height:1000)
        let textRect:CGRect=string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)], context: nil)
        
        return Float(textRect.height)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
