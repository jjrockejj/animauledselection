//
//  CacheManager.swift
//  News
//
//  Created by John Grooms on 4/26/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import Foundation

class CacheManager {
  
  static var imageDictionary = [String : Data]()
  
  
  
  static func saveImageData (_ url:String, _ data:Data) {

    // Save URL/Data combo to image dictionary
    
    imageDictionary[url] = data
    
    
  }

  
  static func retrieveImageData (_ url:String) -> Data? {
    
    // Save URL/Data combo to image dictionary
    
    return imageDictionary[url] 
    
    
  }





}
