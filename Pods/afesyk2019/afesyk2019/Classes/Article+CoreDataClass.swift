//
//  Article+CoreDataClass.swift
//  Pods
//
//  Created by Alina FESYK on 1/25/19.
//
//

import Foundation
import CoreData


public class Article: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var modificationDate: NSDate?
    @NSManaged public var image: NSData?
    
    public override var description: String {
        var description: String = ""
        
        if let title = title {
            description += "\(title)\n"
        }
        if let creation = creationDate {
            description += "\(creation)\n"
        }
        if let modification = modificationDate {
            description += "\(modification)\n"
        }
        if let content = content {
            description += "\(content)\n"
        }
        if let lang = language {
            description += "\(lang)\n"
        }
        return description
    }
}
