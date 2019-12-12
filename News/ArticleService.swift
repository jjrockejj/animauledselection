//
//  ArticleService.swift
//  News
//
//  Created by John Grooms on 4/25/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import Foundation

struct ArticleService : Decodable {
  
  var totalResults:Int?
  var articles:[Article]?
  
}
