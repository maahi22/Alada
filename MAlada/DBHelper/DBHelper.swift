//
//  DBHelper.swift
//  MAlada
//
//  Created by Rajeev kumar singh on 10/13/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class DBHelper: NSObject {

    class   func savePhotos(_ pArray :NSArray  ) -> [Photo] {
        
        var returnArray = [Photo]()
        
        for i in 0...(pArray.count-1){
            
            let dict1 = pArray.object(at: i) as! NSDictionary
            let img = Photo()
            
            if let UserID = dict1["UserID"], !(UserID is NSNull) {
                img.UserID = (UserID as? String)!
            }
            
            if let PhotoID = dict1["PhotoID"], !(PhotoID is NSNull) {
                img.PhotoID = (PhotoID as? String)!
            }
            
            if let ContentType = dict1["ContentType"], !(ContentType is NSNull) {
                img.ContentType = (ContentType as? String)!
            }
            if let Data = dict1["Data"], !(Data is NSNull) {
                img.Data = (Data as? String)!
            }
            if let Status = dict1["Status"], !(Status is NSNull) {
                img.Status = (Status as? String)!
            }
            
            if let Message = dict1["Message"], !(Message is NSNull) {
                img.Message = (Message as? String)!
            }
            
            returnArray.append(img)
        }
        
        return returnArray
    }
    
   
    
    class   func saveFeaturePhotos(_ pArray :NSArray  ) -> [FeaturedImages] {
        
        var returnArray = [FeaturedImages]()
        
        for i in 0...(pArray.count-1){
            
            let dict1 = pArray.object(at: i) as! NSDictionary
            let img = FeaturedImages()
            
            if let FimagID = dict1["FimagID"], !(FimagID is NSNull) {
                img.FimagID = (FimagID as? String)!
            }
            
            if let FType = dict1["FType"], !(FType is NSNull) {
                img.FType = (FType as? String)!
            }
            
            if let Fname = dict1["Fname"], !(Fname is NSNull) {
                img.Fname = (Fname as? String)!
            }
            if let Fpath = dict1["Fpath"], !(Fpath is NSNull) {
                img.Fpath = (Fpath as? String)!
            }
            if let Status = dict1["Status"], !(Status is NSNull) {
                img.Status = (Status as? String)!
            }
            
            if let Message = dict1["Message"], !(Message is NSNull) {
                img.Message = (Message as? String)!
            }
            
            returnArray.append(img)
        }
        
        return returnArray
    }
}
