//
//  DatabaseUpdateModel.swift
//  News
//
//  Created by John Grooms on 5/24/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import Foundation
import Firebase


class DatabaseUpdateModel  {
  
  func writeUniqueArticles( articles:[Article],  titleArray : [String], titleArrayDates : [String] ) {
    
    var dbRef:DatabaseReference?
    
    var updatedTitleArray = titleArray
    
    
    // get database reference
    dbRef = Database.database().reference()
    
    for newsArtCount in articles {
      print("article - \(newsArtCount.title!)")
      
      
      var uniqueTitle = false
      
      if !updatedTitleArray.contains(newsArtCount.title!) {
        uniqueTitle = true
      }
        
      
      
      
      
      
      
      
      
      if uniqueTitle {
        print ("unique title")
        updatedTitleArray.append(newsArtCount.title!)
        
        var sourceID = " "
        if newsArtCount.source!.id != nil {
          sourceID = newsArtCount.source!.id!
        }
        
        var sourceName = " "
        if newsArtCount.source!.name != nil {
          sourceName = newsArtCount.source!.name!
        }
        
        var calculatedAnimal = "other"
        
        // Calculate animal type
        
        var upperCaseTitle = " "
        if newsArtCount.title != nil {
          upperCaseTitle = newsArtCount.title!.uppercased()
        }
        
        switch upperCaseTitle {
        case _ where upperCaseTitle.contains("SHARK"):
          calculatedAnimal = "shark"
        case _ where upperCaseTitle.contains("GREAT WHITE"):
          calculatedAnimal = "shark"
        case _ where upperCaseTitle.contains("CROCODILE"):
          calculatedAnimal = "crocodile"
        case _ where upperCaseTitle.contains("CROC"):
          calculatedAnimal = "crocodile"
        case _ where upperCaseTitle.contains("ELEPHANT"):
          calculatedAnimal = "elephant"
        case _ where upperCaseTitle.contains("SEA LION"):
          calculatedAnimal = "sea lion"
        case _ where upperCaseTitle.contains("MOUNTAIN LION"):
          calculatedAnimal = "mountain lion"
        case _ where upperCaseTitle.contains("LION"):
          calculatedAnimal = "lion"
        case _ where upperCaseTitle.contains("TIGER"):
          calculatedAnimal = "tiger"
        case _ where upperCaseTitle.contains("ALLIGATOR"):
          calculatedAnimal = "alligator"
        case _ where upperCaseTitle.contains("GATOR"):
          calculatedAnimal = "alligator"
        case _ where upperCaseTitle.contains("WOLF"):
          calculatedAnimal = "wolves"
        case _ where upperCaseTitle.contains("WOLVES"):
          calculatedAnimal = "wolves"
        case _ where upperCaseTitle.contains("DINGO"):
          calculatedAnimal = "dingoes"
        case _ where upperCaseTitle.contains("LEOPARD"):
          calculatedAnimal = "leopard"
        case _ where upperCaseTitle.contains("COUGAR"):
          calculatedAnimal = "mountain lion"
        case _ where upperCaseTitle.contains("PUMA"):
          calculatedAnimal = "mountain lion"
        case _ where upperCaseTitle.contains("PANTHER"):
          calculatedAnimal = "mountain lion"

        case _ where upperCaseTitle.contains("JAGUAR"):
          calculatedAnimal = "jaguar"
        case _ where upperCaseTitle.contains("HIPPO"):
          calculatedAnimal = "hippo"
        case _ where upperCaseTitle.contains("DOG"):
          calculatedAnimal = "canine"
        case _ where upperCaseTitle.contains("PIT BULL"):
          calculatedAnimal = "canine"
        case _ where upperCaseTitle.contains("BULL TERRIER"):
          calculatedAnimal = "moose"
        case _ where upperCaseTitle.contains("BEAR"):
          calculatedAnimal = "bear"
        case _ where upperCaseTitle.contains("GRIZZLY"):
          calculatedAnimal = "bear"
        case _ where upperCaseTitle.contains("SNAKE"):
          calculatedAnimal = "snake"
        case _ where upperCaseTitle.contains("COBRA"):
          calculatedAnimal = "snake"
        case _ where upperCaseTitle.contains("SPIDER"):
          calculatedAnimal = "snake"
        case _ where upperCaseTitle.contains("RHINO"):
          calculatedAnimal = "rhino"
        case _ where upperCaseTitle.contains("DEER"):
          calculatedAnimal = "deer"
        case _ where upperCaseTitle.contains("MOOSE"):
          calculatedAnimal = "moose"
        case _ where upperCaseTitle.contains("STINGRAY"):
          calculatedAnimal = "stingray"
        case _ where upperCaseTitle.contains("BEE") && !upperCaseTitle.contains("BEEN"):
          calculatedAnimal = "bees"
        default:
          calculatedAnimal = "other"
        }
        
        
        let date = Date()        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let defaultTimeZoneStr = formatter2.string(from: date)
        
        
        
        
        
/*        let employeeData:[String : Any] = ["animal" : calculatedAnimal, "author":newsArtCount.author ?? " ", "content" : newsArtCount.content ?? " ", "description": newsArtCount.description ?? " ", "publishedAt" : newsArtCount.publishedAt ?? " ", "title": newsArtCount.title ?? " ", "url" : newsArtCount.url ?? " ", "urlToImage" : newsArtCount.urlToImage ?? " ", "dateAndAnimal" : ((newsArtCount.publishedAt ?? " ") + "unknown"), "sourceName" : sourceName, "sourceID" : sourceID] */
   
//        let employeeData:[String : Any] = ["animal" : calculatedAnimal, "publishedAt" : newsArtCount.publishedAt ?? " ", "title": newsArtCount.title ?? " ", "url" : newsArtCount.url ?? " ", "urlToImage" : newsArtCount.urlToImage ?? " "]
        
        let employeeData:[String : Any] = ["animal" : calculatedAnimal, "publishedAt" : defaultTimeZoneStr , "title": newsArtCount.title ?? " ", "url" : newsArtCount.url ?? " ", "urlToImage" : newsArtCount.urlToImage ?? " "]

  
        
        dbRef?.child("articles").childByAutoId().setValue(employeeData, withCompletionBlock: { (error, ref) in
          
          if error == nil {
            //successful
          } else {
            //unsuccessful
          }
        })        } else {
        
        // Array contains title, check for date range
        
      }
      
    }
    
    
    
    
  } 
}
