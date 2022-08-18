//
//  AuthorsTableViewCell.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-08-14.
//

import UIKit

class AuthorsTableViewCell: UITableViewCell {

    @IBOutlet weak var AuthorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
