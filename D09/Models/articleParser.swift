//
//  Parser.swift
//  D09
//
//  Created by Alina FESYK on 2/25/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import Foundation
import afesyk2019

struct articleParser {
    var title: String?
    var content: String?
    var image: UIImage?
    var creationDate: String?
    var modificationDate: String?

    init(article: Article) {
        title = article.title
        content = article.content
        if let data = article.image as Data? {
            image = UIImage(data: data)
        }
        creationDate = dateToString(article.creationDate)
        modificationDate = dateToString(article.modificationDate)
    }
    
    func dateToString(_ date: NSDate?) -> String? {
        guard date != nil else {return nil}
        
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy 'at' hh:mm:ss a"
        return "Created: " + dateFormatter.string(from: date! as Date)
    }
}
