//
//  MenubarViewController.swift
//  SwiftDemoProject
//
//  Created by  Rohit on 13/10/16.
 
//

import UIKit

class GlobalMenubarViewController: UIViewController,SWRevealViewControllerDelegate {

    var barButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addLeftBarButtonWithImage(menuImage: UIImage(named: "menu")!)
        let revealController:SWRevealViewController=self.revealViewController()
        /*//Uncomment to remove slide menubar
         revealController.panGestureRecognizer()
         */
        revealController.tapGestureRecognizer()
        
        // Do any additional setup after loading the view.
    }
    
    func addLeftBarButtonWithImage(menuImage:UIImage) {
        
        let frame:CGRect=CGRect(x:0 ,y:0 ,width:menuImage.size.width ,height:menuImage.size.height)
        let menuItem = UIButton(frame: frame)
        menuItem.setBackgroundImage(menuImage, for: UIControlState.normal)
        barButton=UIBarButtonItem(customView: menuItem)
        self.navigationItem.leftBarButtonItem = barButton
        let revealViewController:SWRevealViewController?=self.revealViewController()
        if (revealViewController != nil) {
            
            menuItem.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
