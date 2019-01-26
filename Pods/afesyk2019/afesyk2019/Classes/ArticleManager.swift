//
//  ArticleManager.swift
//  Pods
//
//  Created by Alina FESYK on 1/25/19.
//

import Foundation
import CoreData

public class ArticleManager: NSObject {
    
    public var managedObjectContext: NSManagedObjectContext

    public override init() {
        let modelName = "Article"

        let myBundle = Bundle(identifier: "org.cocoapods.afesyk2019")
        guard let modelURL = myBundle?.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "\(modelName).sqlite"

        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last
        let persistentStoreURL = docURL?.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store: \(error)")
        }

        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
    
    public func newArticle() -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
    }
    
    public func getAllArticles() -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        
        do {
            let result = try managedObjectContext.fetch(request) as! [Article]
            return result
        }
        catch {
            //fatalError("Failed to fetch article")
            print("Failed to fetch article")
            return []
        }
    }
    
    public func getArticles(withLang lang: String) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "language == %@", lang)
        
        do {
            let result = try managedObjectContext.fetch(request) as! [Article]
            return result
        }
        catch {
            print("Failed to fetch articles by language: \(lang)")
            return []
        }
    }
    
    public func getArticles(containString str: String) -> [Article] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.predicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str, str)
        
        do {
            let result = try managedObjectContext.fetch(request) as! [Article]
            return result
        }
        catch {
            print("Failed to fetch articles by following keyword: \(str)")
            return []
        }
    }
    
    public func removeArticle(article: Article)
    {
        managedObjectContext.delete(article)
    }
    
    public func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            }
            catch {
                fatalError("Failed to save context: \(error)")
            }
        }
    }
}
