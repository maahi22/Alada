//
//  ImageVC.swift
//  MAlada
//
//  Created by Maahi on 14/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import ReachabilitySwift



class ImageVC: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    var prod: Photo = Photo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  imageView.image = image
        
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
    
    
    
    
    
    
    @IBAction func deleteImage(_ sender: Any) {
    
        var photoId = prod.PhotoID
        
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
        
      /*  self.CallImageApiWithoutParameter(urlString) { (responce, status) in
            
            
            
            
            
        }*/
    
    }
    
    
    
}
