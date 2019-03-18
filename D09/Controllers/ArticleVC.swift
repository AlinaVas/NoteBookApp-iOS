//
//  ArticleVC.swift
//  D09
//
//  Created by Alina FESYK on 2/26/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit
import Photos
import afesyk2019


class ArticleVC: UIViewController {

    @IBOutlet weak var articleTitle: UITextField!
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var articleImage: UIImageView!
        
    weak var articleManager: ArticleManager!
    var article: Article?
    var allArticles: [Article]!
    var imageUploader: ImageUploader!
    
    override func loadView() {
        super.loadView()
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUploader = ImageUploader(to: self)
    }
    
    fileprivate func saveArticle() {
        if article == nil {
            article = articleManager!.newArticle()
            allArticles!.insert(article!, at: 0)
        }
        article!.title = articleTitle.text
        article!.content = articleContent.text
        if let img = articleImage.image {
            article!.image = img.pngData() as NSData?
        }
        article!.language = NSLinguisticTagger.dominantLanguage(for: articleContent.text)
        if article!.creationDate == nil {
            article!.creationDate = NSDate()
        }
        article!.modificationDate = NSDate()
        articleManager!.save()
    }
    
    fileprivate func setView() {
        articleContent.layer.borderWidth = 0.8
        articleContent.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        articleContent.layer.cornerRadius = 5
        articleContent.clipsToBounds = true
        articleContent.text = article?.content ?? ""
        
        articleTitle.text = article?.title ?? ""
        
        if let imgData = article?.image as Data? {
            if let img = UIImage(data: imgData) {
                articleImage.image = img
            }
        }
        else {
            articleImage.image = nil
        }
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard articleTitle.text != "" || articleContent.text != "" || articleImage.image != nil else {
            self.alert(title: "Emty note", message: "There's nothing to save", actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        }
        saveArticle()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takePicturePressed(_ sender: UIButton) {
        imageUploader?.accessCamera()
    }
    
    @IBAction func choosePicture(_ sender: UIButton) {
        imageUploader?.accessGallery()
    }
}


