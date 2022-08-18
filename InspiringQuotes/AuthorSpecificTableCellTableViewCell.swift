//
//  AuthorSpecificTableCellTableViewCell.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-08-14.
//

import UIKit
import CoreData

class AuthorSpecificTableCellTableViewCell: UITableViewCell {
    var container: NSPersistentContainer!
    var quoteObject : NSManagedObject = NSManagedObject()
    var getId : String = ""
    var getAuthor : String = ""
    var getContent : String = ""
    @IBOutlet weak var quotes: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(tapGesture)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func gestureAction() {
        if favImage.tintColor == .systemBlue {
            favImage.tintColor.setFill()
            favImage.tintColor = .red
            print("gesture action")
            let moc = container.viewContext
            moc.perform {
                let favQuotes = FavQuotes(context: moc)
                favQuotes.id = self.getId
                favQuotes.content = self.getContent
                favQuotes.author = self.getAuthor
                do {
                    try moc.save()
                } catch {
                    moc.rollback()
                }
            }
        } else {
            favImage.tintColor.setFill()
            favImage.tintColor = .systemBlue
            let moc = container.viewContext
            moc.perform {
                do {
                    moc.delete(self.quoteObject)
                    try moc.save()
                } catch {
                    moc.rollback()
                }
            }
        }
    }

}
