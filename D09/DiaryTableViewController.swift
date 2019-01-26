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

    let manager = ArticleManager()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here")
        tableView.estimatedRowHeight = 448
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        articles = manager.getAllArticles()
        let a = manager.newArticle()
        a.title = "sdh"
        a.content = "dsfhrhktkshfdna"
        articles.append(a)
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if articles.isEmpty {
            return 1
        } else {
            return articles.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            if articles.isEmpty {
                cell.titleLabel.text = "Diary is empty :("
                
            } else {
                cell.titleLabel.text = articles[indexPath.row].title
                if let imgData = articles[indexPath.row].image as Data? {
                    if let img = UIImage(data: imgData) {
                        cell.imgView = UIImageView(image: img)
                    }
                }
                cell.content.text = articles[indexPath.row].content
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
                var dateString: String = dateFormatter.string(from: articles[indexPath.row].creationDate! as Date)
                cell.creationLabel.text = "Created: " + dateString
                dateString = dateFormatter.string(from: articles[indexPath.row].modificationDate! as Date)
                cell.modificationLabel.text = "Modified: " + dateString
            }
            return cell
        }
        
        return TableViewCell()
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
