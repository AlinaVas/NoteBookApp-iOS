//
//  DiaryTableViewController.swift
//  D09
//
//  Created by Alina FESYK on 1/26/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit
import afesyk2019

class DiaryTableViewController: UITableViewController {

    let articleManager = ArticleManager()
    var articles: [Article] = []
    let articleVCIdentifier = "ArticleVC"
    
    var emptyDiaryLabel: UILabel!
    
    @IBAction func plusBtn(_ sender: Any) {
        let articleVC = storyboard?.instantiateViewController(withIdentifier: articleVCIdentifier) as! ArticleVC
        articleVC.articleManager = articleManager
        articleVC.articles = articles
        show(articleVC, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        emptyDiaryView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        articles = articleManager.getAllArticles().reversed()
        print("viewWillAppear")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func emptyDiaryView() {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyDiaryLabel = UILabel(frame: rect)
        emptyDiaryLabel.text = "Diary is empty so far"
        emptyDiaryLabel.numberOfLines = 0;
        emptyDiaryLabel.textAlignment = .center;
        emptyDiaryLabel.font = UIFont(name: "TrebuchetMS", size: 17)
        emptyDiaryLabel.sizeToFit()
        
        self.tableView.backgroundView = emptyDiaryLabel;
        self.tableView.separatorStyle = .none;
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("SECTIONS---------------------------------------------------------------")
        if articles.isEmpty {
            print("emptyyy")
//            emptyDiaryLabel.isHidden = false
            return 0
        } else {
            print("not emptyyyy")
//            emptyDiaryLabel.isHidden = true
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ROWS+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("display cell...")
        if articles[indexPath.row].image != nil {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as? CellWithImage {
                cell.article = articles[indexPath.row]
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell {
                cell.article = articles[indexPath.row]
                return cell
            }
        }
        return CellWithImage()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard articles.count != 0 else {return}
        
        let editVC = storyboard?.instantiateViewController(withIdentifier: articleVCIdentifier) as! ArticleVC
        editVC.article = articles[indexPath.row]
        editVC.articleManager = articleManager
        show(editVC, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleting...")
            articleManager.removeArticle(article: articles.remove(at: indexPath.row))
            articleManager.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
