//
//  CommonMethod.swift
//  MAlada
//
//  Created by Maahi on 14/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class CommonMethod: NSObject {

   
    
    
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

