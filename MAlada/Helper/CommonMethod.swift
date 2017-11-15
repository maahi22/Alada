//
//  CommonMethod.swift
//  MAlada
//
//  Created by Maahi on 14/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class CommonMethod: NSObject {

   
    class  func convertImageToBase64(_ image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData?.base64EncodedString()//base64EncodedStringWithOptions(.allZeros)
        return base64String!
        
    }// end convertImageToBase64
    
    
    // prgm mark ----
    
    // convert images into base64 and keep them into string
    
    class  func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        let decodedimage = UIImage(data: decodedData! as Data)
        return decodedimage!
        
    }// end convertBase64ToImage
    
}

extension UIImage {
    
    /*
     @brief decode image base64
     */
    static func decodeBase64(toImage strEncodeData: String!) -> UIImage {
        
        if let decData = Data(base64Encoded: strEncodeData, options: .ignoreUnknownCharacters), strEncodeData.characters.count > 0 {
            return UIImage(data: decData)!
        }
        return UIImage()
    }
}

