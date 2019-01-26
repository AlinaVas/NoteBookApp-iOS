//
//  TableViewCell.swift
//  D09
//
//  Created by Alina FESYK on 1/26/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var creationLabel: UILabel!
    @IBOutlet weak var modificationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
