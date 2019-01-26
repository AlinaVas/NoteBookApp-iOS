//
//  ViewController.swift
//  afesyk2019
//
//  Created by alinavas on 01/25/2019.
//  Copyright (c) 2019 alinavas. All rights reserved.
//

import UIKit
import afesyk2019

class ViewController: UIViewController {
    
    let articleManager = ArticleManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let article1 : Article = articleManager.newArticle()
        
        article1.title = "First article"
        article1.content = "This is content for my first article"
        article1.creationDate = NSDate()
        article1.modificationDate = NSDate()
        article1.language = "en"
        articleManager.save()
        
        let article2 : Article = articleManager.newArticle()
        
        article2.title = "Друга стаття"
        article2.content = "Зміст другої статті полягає у беззмістовності"
        article2.creationDate = NSDate()
        article2.modificationDate = NSDate()
        article2.language = "ua"
        articleManager.save()
        
        
        print(articleManager.getAllArticles())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

