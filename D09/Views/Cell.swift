//
//  TableViewCellWithImage.swift
//  D09
//
//  Created by Alina Fesyk on 3/5/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit
import afesyk2019

class Cell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var creationLabel: UILabel!
    @IBOutlet weak var modificationLabel: UILabel!
    
    var article: Article? {
        didSet {
            let parser = articleParser(article: article!)
            title.text = parser.title
            content.text = parser.content
            creationLabel.text = parser.creationDate
            modificationLabel.text = parser.modificationDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
