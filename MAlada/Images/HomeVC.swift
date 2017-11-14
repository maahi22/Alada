//
//  HomeVC.swift
//  MAlada
//
//  Created by Rajeev kumar singh on 10/13/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import ReachabilitySwift

private let reuseIdentifierAvail =  "HomeCell"





class HomeVC: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let selectionSts :Bool = true
    var imageList : [Photo] = []
    var selectionArray = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.black
        
        self.navigationItem.leftBarButtonItem = nil
        
        self.getImageData()
    }

    
    
    
    
    //called country available
    func getImageData() {
        
        
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
            
            let urlString = BaseUrl + MAlada_ViewImages + "UserID=\(userId)"
        
            self.CallImageApiWithoutParameter(urlString) { (responce, status) in
                
            
                if status {
                    
                    
                    self.imageList = DBHelper.savePhotos(responce)
                    
                    DispatchQueue.main.async(execute: {  () -> Void  in
                        self.activityIndicator.stopAnimating()
                        self.homeCollectionView.reloadData()
                    })
                }
                
                
            
            
            
            
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

    
    
    
    
     func CallImageApiWithoutParameter (_ urlString:String ,completionHandler :@escaping ( _ responceArray: NSArray ,  _ Status :Bool) -> Void ){
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {Data, response, error in
            
            
            guard let _: Data = Data, let _: URLResponse = response, error == nil else {
                
                let dict :[String] = ["alert"]
                completionHandler(dict as NSArray ,false)
                return
            }
            
            let responseStrInISOLatin = String(data: Data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                
                let dict :[String] = ["alert"]
                completionHandler(dict as NSArray ,false)
                return
            }
            do {
                let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                completionHandler(responseJSONDict as! NSArray ,true)
                //print(responseJSONDict)
                
                
            } catch {
                print(error)
            }
            
            
            
            }.resume()
        
        
    }
    
    
    
    
    
    
}


extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell:HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierAvail, for: indexPath) as! HomeCell
        
        
            let img:Photo = self.imageList[indexPath.row]
        
        
        
        
        cell.lblTitle.text = img.PhotoID
        
            cell.contentView.layer.cornerRadius = 4.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell       .contentView.layer.cornerRadius).cgPath
        
        
        cell.imageView.image = UIImage.decodeBase64(toImage: img.Data)
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenRect = UIScreen.main.bounds
            let screenWidth = screenRect.width - 30
            let cellWidth = screenWidth / 2.0
            let size = CGSize(width: cellWidth, height: cellWidth)
            return size
        
    }
    
    
    
    
    //https://stackoverflow.com/questions/1548024/how-do-i-open-google-maps-for-directions-using-coordinates-on-the-iphone
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !self.selectionSts  {
            
            
            let uiAlert = UIAlertController(title: "Action", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            self.present(uiAlert, animated: true, completion: nil)
            
            let btnDelete:UIAlertAction  = (UIAlertAction(title: "Delete", style: .default, handler: { action in
                
            }))
            
            let btnModify:UIAlertAction  = (UIAlertAction(title: "Modify", style: .default, handler: { action in
                
            }))
            let btnDownload:UIAlertAction  = (UIAlertAction(title: "Download", style: .default, handler: { action in
                
            }))
            let btnshare:UIAlertAction  = (UIAlertAction(title: "share", style: .default, handler: { action in
                
            }))
            
            uiAlert.addAction(btnDelete)
            uiAlert.addAction(btnModify)
            uiAlert.addAction(btnDownload)
           // uiAlert.addAction(btnshare)
            
            
            uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                uiAlert .dismiss(animated: true, completion: nil)
            }))
            
            
            
        }else{
            let cell :HomeCell = collectionView.cellForItem(at: indexPath)! as! HomeCell
            
            
            if cell.selectionSts {
                
                cell.selectionSts = false
                cell.imageViewSelection.isHidden = true
            }else{
                
                cell.selectionSts = true
                cell.imageViewSelection.isHidden = false
            }
            
        }
    }

}

