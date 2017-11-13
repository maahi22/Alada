//
//  MenuVC.swift
//  MAlada
//
//  Created by Maahi on 13/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
   
    
    @IBOutlet weak var tblViewMenu: UITableView!
    
    var menuItemArray = [["icon":"iconHome","Text":"Home"],["icon":"myprofile","Text":"Feature Image"],["icon":"IconCurrency","Text":"Insert"],["icon":"IconCurrency","Text":"Delete"],["icon":"Settings","Text":"Share"],["icon":"logout","Text":"Logout"]]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
   
    
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

extension MenuVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1.0
        }else{
            return 2.0
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItemArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let dict = menuItemArray[indexPath.row]
        
        let text = dict ["Text"]
        
        cell.textLabel?.text = text
        if let imgeName = dict ["icon"] {
            let img = imgeName
            cell.imageView?.image = UIImage(named: img)?.withRenderingMode(.alwaysTemplate)
            cell.imageView?.tintColor = .lightGray
        }
        
        
        
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dict = menuItemArray[indexPath.row]
        let text = dict ["Text"]
        
        if text == "Logout"  {
            self.app_logout()
            
        }else if text == "Log In"{
            
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let ViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let navController = UINavigationController(rootViewController: ViewController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = navController
        }else if text == "Feature Image" {
            sideMenuController?.performSegue(withIdentifier: "toFeaturedImages", sender: nil)
        }else if text == "Delete" {
            sideMenuController?.performSegue(withIdentifier: "toDeleteVC", sender: nil)
        }else if text == "Share" {
            
        }else if text == "Insert"{
         sideMenuController?.performSegue(withIdentifier: "toInserVC", sender: nil)
        }else  if text == "Home" {
            sideMenuController?.performSegue(withIdentifier: "toHomeVC", sender: nil)
        }
        
        
    }
    
    
    
    
    
    
    
    //Logout MyDunia
    func app_logout()  {
        
        let alertController = UIAlertController(title: "Logout!", message: "Are you sure", preferredStyle: UIAlertControllerStyle.alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            
            /* FilesMethods.deleteImageDocumentDirectory("ProfilePic")
             
             UserDefaults.standard.removeObject(forKey: MyDuniaUserDetails)*/
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let ViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let navController = UINavigationController(rootViewController: ViewController)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = navController
            
            
        }
        
        let NoAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            
            
            
        }
        alertController.addAction(yesAction)
        alertController.addAction(NoAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
}
