//
//  Article.swift
//  iCatchUp
//
//  Created by Developer User on 5/22/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article {
    var source: Source
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    init(source: Source, author: String, title: String,
         description: String, url: String, urlToImage: String,
         publishedAt: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    convenience init(from jsonArticle: JSON) {
        self.init(source: Source(from: JSON(jsonArticle["source"])),
                  author: jsonArticle["author"].stringValue,
                  title: jsonArticle["title"].stringValue,
                  description: jsonArticle["description"].stringValue,
                  url: jsonArticle["url"].stringValue,
                  urlToImage: jsonArticle["urlToImage"].stringValue,
                  publishedAt: jsonArticle["publishedAt"].stringValue)
    }
    
    public static func buildAll(from jsonArticles: [JSON]) -> [Article] {
        let count = jsonArticles.count
        var articles: [Article] = []
        for i in 0 ..< count {
            articles.append(Article(from: JSON(jsonArticles[i])))
        }
        return articles
    }
}






