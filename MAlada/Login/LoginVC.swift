//
//  LoginVC.swift
//  MAlada
//
//  Created by Rajeev kumar singh on 10/13/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import ReachabilitySwift



class LoginVC: UIViewController {

    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    @IBAction func userLogin(_ sender: Any) {
        
        guard
            let userName = txtUserName.text, !userName.isEmpty,
            let password = txtPassword.text, !password.isEmpty
            else {
                //doneBarButton.isEnabled = false
                
                let alert = UIAlertController(title: "Alert", message: "Please enter the login credential", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                txtUserName.resignFirstResponder()
                txtPassword.resignFirstResponder()
                return
        }
        
        let reachability = Reachability()!
        if !reachability.isReachable {
            let alert = UIAlertController(title: "Alert", message: "No internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        activityIndicator.startAnimating()
        let urlString = BaseUrl + MAlada_Login + "username=\(userName)&password=\(password)"
        
      //  let paramString = ["username":userName,"password":password] as [String : Any]
        ConnectionHelper.CallAgetApiWithoutParameter(urlString) { (responce, status) in
            
            if let statusVal = responce.object(forKey: "Status") { // If casting, use, eg, if let var = abc as? NSString
                
                
                if (statusVal as AnyObject).intValue == 1 {
                    
                    let users = User.DictionaryVal(jsonObject: responce )
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: users)
                    UserDefaults.standard.setValue(encodedData, forKey: UserDetails)
                    
                    DispatchQueue.main.async(execute: {  () -> Void  in
                        self.activityIndicator.stopAnimating()
                        self.performSegue(withIdentifier: "toHome", sender: self)
                    })
                    
                    
                }
                else if (statusVal as! NSNumber).intValue == 0 {
                    var message = "there is some problem"
                    
                    DispatchQueue.main.async(execute: {  () -> Void  in
                        self.activityIndicator.stopAnimating()
                        
                        if let errorMsf = responce.object(forKey: "message"){
                            message = errorMsf as! String
                        }
                        
                        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    })
                    
                    
                    
                    
                    
                }
                else{
                    DispatchQueue.main.async(execute: {  () -> Void  in
                        self.activityIndicator.stopAnimating()
                        
                    })
                }
                
            }
            
            
            
        }
        
        print("loginUser")
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func skipLogin(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toHome", sender: self)
        
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
