//
//  TableViewCell.swift
//  D09
//
//  Created by Alina FESYK on 1/26/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit
import afesyk2019

class CellWithImage: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var creationLabel: UILabel!
    @IBOutlet weak var modificationLabel: UILabel!
    
    var article: Article? {
        didSet {
            let parser = articleParser(article: article!)
            title.text = parser.title
            content.text = parser.content
            imgView.image = parser.image ?? UIImage(named: "error")
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
