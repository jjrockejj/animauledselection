//
//  ManualArticle.swift
//  News
//
//  Created by John Grooms on 10/9/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import Foundation
import Firebase



class ManualArticle {
  var title : String = " "
  var url : String = " "
  var urlImage : String = " "
  var animal : String = " "
  
  var dbRef:DatabaseReference?
  var databaseUpdateModel = DatabaseUpdateModel()

  
  
  func ProcessAdds( manualArticles : [ManualArticle]) {
      print("here")
    
 dbRef = Database.database().reference()
    
 /*   Auth.auth().signInAnonymously { (authResult, error) in
      if let error = error {
        print("Sign in failed:", error.localizedDescription)
        
        
        
      } else {
        
        let user = authResult!.user
        let isAnonymous = user.isAnonymous  // true
        let uid = user.uid
        
        
        print ("Signed in with uid:", user, uid)
        
      }
    }
   */
    
    for manualArticle in manualArticles {
    
      if manualArticle.title == "" || manualArticle.url == "" || manualArticle.animal == "" || manualArticle.title == " " || manualArticle.url == " " || manualArticle.animal == " " {
        return
      }
      
    let calculatedAnimal = manualArticle.animal
    
  
      
          let date = Date()
          let formatter2 = DateFormatter()
          formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
          let defaultTimeZoneStr = formatter2.string(from: date)
          
          
          
          
          
    let articleData:[String : Any] = ["animal" : calculatedAnimal, "publishedAt" : defaultTimeZoneStr , "title": manualArticle.title ?? " ", "url" : manualArticle.url ?? " ", "urlToImage" : manualArticle.urlImage ?? " "]

    
          
          dbRef?.child("articles").childByAutoId().setValue(articleData, withCompletionBlock: { (error, ref) in
            
            if error == nil {
              //successful
            } else {
              print("unsuccessful: ", error!)
              //unsuccessful
            }
          })

    
  }
  }
  
}
