//
//  Article.swift
//  News
//
//  Created by John Grooms on 4/25/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import Foundation

struct Article : Decodable {
  
  var author:String?
  var title:String?
  var description:String?
  var url:String?
  var urlToImage:String?
  var publishedAt:String?
  var content:String?
  var source: Source?
  var added: Bool? = false
  var categoryPlusPublishedAt: String? = " "
  
}

struct Source: Decodable {
  var id: String?
  var name: String?
}


