//
//  DeleteVC.swift
//  MAlada
//
//  Created by Maahi on 13/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class DeleteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.black
        
        
        
        
        
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

    
    
    
    func deletePhoto(_ photoId:String) -> Bool {
        
        
        var userId = ""
        if let data = UserDefaults.standard.data(forKey: UserDetails),
            let myUser = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
            userId = myUser.UserId!
        }
        
        
        //Call api
        let reachability = Reachability()!
        if !reachability.isReachable {
            let alert = UIAlertController(title: "Alert", message: "No internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        self.activityIndicator.startAnimating()
        
        let urlString = BaseUrl + MAlada_ImageDelete + "UserID=\(userId)&PhotoID=\(photoId)"
        
        self.CallImageApiWithoutParameter(urlString) { (responce, status) in
            
            
            
            
            
        }
    }
    
    
    
    
}
