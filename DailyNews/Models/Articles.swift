//
//  Articles.swift
//  DailyNews
//
// Created by Fawaz Faiz on 29/07/2021.
//

import Foundation
// All Articles
struct Articles: Decodable {
  let count: Int
  let all: [Article]
  
  enum CodingKeys: String, CodingKey {
    case count = "num_results"
    case all = "results"
  }
}

struct Article: Decodable {
    var id: Int
    var title: String
    var subTitle: String
    var byLine: String
    var publishedDate: String
    let url: String
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
      case id
      case title
      case subTitle = "abstract"
      case byLine = "byline"
      case publishedDate = "published_date"
      case url
      case media
    }
}

struct Media: Decodable {
    var type: String
    var subtype: String
    var all: [MediaMetaData]
    
    enum CodingKeys: String, CodingKey {
      case type
      case subtype
      case all = "media-metadata"
    }
}

struct MediaMetaData: Decodable {
    var url: String
    var format: String
    var height: Int
    var width: Int
    
    enum CodingKeys: String, CodingKey {
      case url
      case format
      case height
      case width
    }
}

