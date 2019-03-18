//
//  DiaryTableViewController.swift
//  D09
//
//  Created by Alina FESYK on 1/26/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit
import afesyk2019

class ArticleListVC: UITableViewController {

    var emptyDiaryLabel: UILabel!
    
    let articleVCIdentifier = "ArticleVC"
    let articleManager = ArticleManager()
    var allArticles: [Article] = []
    
    override func loadView() {
        super.loadView()
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyDiaryLabel = UILabel(frame: rect)
        emptyDiaryLabel.text = "Diary is empty so far"
        emptyDiaryLabel.numberOfLines = 0;
        emptyDiaryLabel.textAlignment = .center;
        emptyDiaryLabel.font = UIFont(name: "TrebuchetMS", size: 17)
        emptyDiaryLabel.backgroundColor = #colorLiteral(red: 0.9293201566, green: 0.9294758439, blue: 0.9292996526, alpha: 1)
        emptyDiaryLabel.sizeToFit()
        
        self.tableView.backgroundView = emptyDiaryLabel;
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = .zero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allArticles = articleManager.getAllArticles().reversed()
        self.tableView.reloadData()
    }
    
    fileprivate func openArticleVC(with article: Article? = nil) {
        let articleVC = storyboard?.instantiateViewController(withIdentifier: articleVCIdentifier) as! ArticleVC
        articleVC.article = article
        articleVC.articleManager = articleManager
        articleVC.allArticles = allArticles
        show(articleVC, sender: self)
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        openArticleVC()
    }
}

// MARK: - UITableViewDelegate
extension ArticleListVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard allArticles.count != 0 else {return}
        openArticleVC(with: allArticles[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension ArticleListVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if allArticles.isEmpty {
            emptyDiaryLabel.isHidden = false
            self.tableView.separatorStyle = .none;
            return 0
        } else {
            emptyDiaryLabel.isHidden = true
            self.tableView.separatorStyle = .singleLine;
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if allArticles[indexPath.row].image != nil {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as? CellWithImage {
                cell.article = allArticles[indexPath.row]
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell {
                cell.article = allArticles[indexPath.row]
                return cell
            }
        }
        return CellWithImage()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleManager.removeArticle(article: allArticles.remove(at: indexPath.row))
            articleManager.save()
            
            if tableView.numberOfRows(inSection: indexPath.section) > 1 {
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                tableView.deleteSections([indexPath.section], with: .fade)
            }
            
        }
    }
}
