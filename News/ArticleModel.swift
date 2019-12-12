//
//  ArticleModel.swift
//  News
//
//  Created by John Grooms on 4/25/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
  func articlesRetrieved(_ articles:[Article], _ firstString: String)
}

class ArticleModel {
  
  var delegate:ArticleModelProtocol?
  
  func getArticles(_ stringURL:String) {
  
   
    
    // Create a string URL
 
  /*  let stringURL = "https://newsapi.org/v2/everything?q=(%22shark%20attack%22%20OR%20%22crocodile%20attack%22%20OR%20%22bear%20attack%22%20OR%20%22tiger%20attack%22%20OR%20%22lion%20attack%22%20OR%20%22hippo%20attack%22%20OR%20%22dog%20attack%22%20OR%20%22wolf%20attack%22%20OR%20%22deer%20attack%22%20OR%20%22buffalo%20attack%22%20OR%20%22elephant%20attack%22%20OR%20%22leopard%20attack%22%20OR%20%22cougar%20attack%22%20OR%20%22dingoes%20attack%22%20OR%20%22snake%20attack%22%20OR%20%22shark%20bite%22%20OR%20%22shark%20spotted%22%20OR%20%22crocodile%20spotted%22%20OR%20%22croc%20attack%22%20OR%20%22crocodile%20kills%22%20OR%20%22shark%20kills%22%20OR%20%22bear%20kills%22%20OR%20%22lions%20kill%22%20OR%20%22tiger%20kills%22%20OR%20%22mauled%20by%20a%22%20OR%20%22mauled%20by%20an%22%20OR%20%22bitten%20by%20a%20shark%22%20OR%20%22angry%20elephant%22%20OR%20%22angry%20hippo%22%20OR%20%22angry%20rhino%22%20OR%20%22elephants%20charge%22%20OR%20%22attacked%20by%20bees%22%20OR%20%22stung%20to%20death%22%20OR%20%22shark%20killed%22%20OR%20%22killed%20by%20lions%22)%20-vacuum%20-baby%20-jose%20-game%20-loan%20-terrorist%20-tears%20-jihadi%20-manufacturer%20-heart%20-phone%20-rape%20-murder%20-aircraft%20-military%20-jet%20-boeing%20-criminal-%20-airport%20-isis%20-movie%20-trump%20-election%20-player%20-nra%20-market%20-theatre%20-music%20-islamic%20-nutrients%20-nutricion%20-sexually%20-bomb%20-spam%20-website%20-gameplay%20-hardware%20-financial%20-feminist%20-stadium%20-championship%20-endgame%20-missiles%20-destroyer%20-cabinet%20-contest%20-gasoline%20-oil%20-electricity%20-netflix%20-episode%20-bank%20-war%20-email%20-cancer%20-overdose%20-debt%20-facebook%20-bible%20-internet%20-mastermind%20-contest%20-blast%20-philosopher%20-philosophy%20-robotic%20-football%20-league%20-album%20-songs%20-diablo%20-blizzard%20-sex%20-pregnancy%20-muslim%20-islam%20-jewish%20-israel%20-rugby%20-cup%20-rugby%20-prizewinning%20-rugby%20-design%20-gaming%20-bitcoin%20-theives%20-artwork%20-hijab%20-genre%20-song&sortBy=publishedAt&language=en&apiKey=7d2881a5533e4233962fb032a78019fd"
 */
 
    // Create a URL object
    let url = URL(string: stringURL)
    
    var firstString = " "
    if stringURL.prefix(1) == "H" { //first string always will sort first
        firstString = "X"
    }
    
    
    
    // Check that isn't nill
    guard url != nil else {
      print("bad url")
      return
    }
    
    // get URL session
    let session = URLSession.shared
    
    // create datatask object
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
      if error == nil && data != nil {
       
        do {
        // decode json file into struct
        let decoder = JSONDecoder()
          let result = try decoder.decode(ArticleService.self, from: data!)
        
          // pass articles back to view controller
         let articles = result.articles!
        
      
          DispatchQueue.main.async {
             self.delegate?.articlesRetrieved(articles, firstString)
          }
         
          
        
        }
        catch {
          print("couldnt decode")
          return
        } // end do catch
        
        
      } // end if
    } // end datatask
    
    
    // Fire off request to API
    
    dataTask.resume()
    
    
    
    
  } // end articles
  
  
  
} // end articlesmodel
