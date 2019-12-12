//
//  ArticleCell.swift
//  News
//
//  Created by John Grooms on 4/25/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import UIKit




class ArticleCell: UITableViewCell {

  
  
  @IBOutlet weak var headlineLabel: UILabel!
  @IBOutlet weak var articleImageView: UIImageView!
  @IBOutlet weak var addArticleButton: UIButton!
  @IBAction func addArticleButton(_ sender: UIButton) {
   
  }
  
  var articleToDisplay:Article?
  
  
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 /*   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
*/

  
  func displayArticle(_ article:Article) {
    
    // set label and image to alpha zero (invisbie)
    headlineLabel.alpha = 0
    articleImageView.alpha = 0
    
    
    
    // Clear the image view in case cell is reused
    articleImageView.image = nil
    
    // Hold a reference to the article
    articleToDisplay = article
    
    // Display the headline
  
    
    let dateString = articleToDisplay?.publishedAt?.prefix(10)
   
    // check if the article has image
    guard articleToDisplay?.title != nil else {
        return
      }
      
    headlineLabel.text = dateString! + " " + articleToDisplay!.title!
    
    // Animate from invisible to visible
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.headlineLabel.alpha = 1
      }, completion: nil)
    
    
    // Download the article image
    
    // creat URL object
    let urlString = articleToDisplay!.urlToImage
    
    // check if the article has image
    guard urlString != nil else {
      return
    }

    // Before we download image, check cache
    
    let cachedData = CacheManager.retrieveImageData(urlString!)
    
    if cachedData != nil {
      
      // if cached data exists, use that instead of downloading
      articleImageView.image = UIImage(data: cachedData!)
      
      // after we load cache image, animate
      // Animate from invisible to visible
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
        self.articleImageView.alpha = 1
      }, completion: nil)
      
      
      return
    }
    
    //create uRL object
    let url = URL(string: urlString!)
    
    guard url != nil else {
      print("no create url object")
      return
    }
    

    
    
    // get session
    let session = URLSession.shared
    
    // create datatask
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
      
      // check that there is no error and data exists
      if error == nil && data != nil {
        
        // Save the image data to cache
        CacheManager.saveImageData(urlString!, data!)
        
        
        // Before we set the image, ensure that this image data is still relevent to article
        if self.articleToDisplay!.urlToImage == urlString! {
      
          // set image view with data
          DispatchQueue.main.async {
            self.articleImageView.image = UIImage(data: data!)
            
            // after we download data, animate
            // Animate from invisible to visible
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
              self.articleImageView.alpha = 1
            }, completion: nil)
            
          }
          
        } // end if
        
        
      
      } // end if
      
    } // end datatask
    
    
    //fire datatask
    dataTask.resume()
    
    
    
    
  }
  
  
  
  
}
