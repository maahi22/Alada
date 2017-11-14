//
//  DeleteVC.swift
//  MAlada
//
//  Created by Maahi on 13/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import ReachabilitySwift


private let reuseIdentifierAvail =  "DeleteCell"


class DeleteVC: UIViewController {

    
    @IBOutlet weak var deleteCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var featureImageList : [FeaturedImages] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.black
        
        
        self.getImageData()
        
        
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
        
        let urlString = "http://www.alada.co.in/AladaWebService.asmx/GetFetureImage"
        
        self.CallImageApiWithoutParameter(urlString) { (responce, status) in
            
            if status {
                
                self.featureImageList = DBHelper.saveFeaturePhotos(responce)
                DispatchQueue.main.async(execute: {  () -> Void  in
                    self.activityIndicator.stopAnimating()
                    self.deleteCollectionView.reloadData()
                })
            }
            
        }
        
    }
    
    
    
    func deletePhoto(_ photoId:String)  {
        
        
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
    
    
    
    
    
    @IBAction func deleteClick(_ sender: Any) {
        
        
        
        
    }
    
    
    
}



extension DeleteVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        
        return self.featureImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:DeleteCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierAvail, for: indexPath) as! DeleteCell
        
        
        let img:FeaturedImages = self.featureImageList[indexPath.row]
        
        cell.lblTitle.text = img.FeatureImg_kid
        cell.imageView.image = UIImage.decodeBase64(toImage: img.FeatureImg_fileData)
        
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
