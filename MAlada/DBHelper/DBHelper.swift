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
            
            if let FeatureImg_kid = dict1["FeatureImg_kid"], !(FeatureImg_kid is NSNull) {
                img.FeatureImg_kid = (FeatureImg_kid as? String)!
            }
            
            if let FeatureImg_fileType = dict1["FeatureImg_fileType"], !(FeatureImg_fileType is NSNull) {
                img.FeatureImg_fileType = (FeatureImg_fileType as? String)!
            }
            
            if let FeatureImg_fileName = dict1["FeatureImg_fileName"], !(FeatureImg_fileName is NSNull) {
                img.FeatureImg_fileName = (FeatureImg_fileName as? String)!
            }
            if let FeatureImg_fileData = dict1["FeatureImg_fileData"], !(FeatureImg_fileData is NSNull) {
                img.FeatureImg_fileData = (FeatureImg_fileData as? String)!
            }
            if let FeatureImg_filePath = dict1["FeatureImg_filePath"], !(FeatureImg_filePath is NSNull) {
                img.FeatureImg_filePath = (FeatureImg_filePath as? String)!
            }
            
            if let FeatureImg_CreationDate = dict1["FeatureImg_CreationDate"], !(FeatureImg_CreationDate is NSNull) {
                img.FeatureImg_CreationDate = (FeatureImg_CreationDate as? String)!
            }
            
            returnArray.append(img)
        }
        
        return returnArray
    }
}
