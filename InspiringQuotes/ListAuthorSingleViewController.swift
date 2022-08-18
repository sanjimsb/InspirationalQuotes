//
//  ListAuthorSingleViewController.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-08-14.
//

import UIKit
import CoreData

class ListAuthorSingleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var getQuotes : [QuotesData] = []
    
    var getSelectedAuthor : String = ""
    var getSelectedAuthorSlug : String = ""
    var getBio : String = ""
    var getDescription : String = ""
    var container: NSPersistentContainer! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var getResults : [FavQuotes] = []
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorBio: UITextView!
    @IBOutlet weak var authorBioHC: NSLayoutConstraint!
    @IBOutlet weak var authorDescription: UITextView!
    @IBOutlet weak var authorDescriptionHC: NSLayoutConstraint!
    @IBOutlet weak var moreQuotesTitle: UILabel!
    @IBOutlet weak var AuthorSpecificQuotesTable: UITableView!
    
    @IBOutlet weak var authorContentHC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authors"
        AuthorSpecificQuotesTable.delegate = self
        AuthorSpecificQuotesTable.dataSource = self
        Task{
            do {
                print(self.getSelectedAuthorSlug)
                self.getQuotes = try await Get_Quotes.fetchQuoteByAuthor(getAuthor: self.getSelectedAuthorSlug)
                print(getQuotes)
                //fetch from fav list
                let request : NSFetchRequest<FavQuotes> = FavQuotes.fetchRequest()
                let moc = container.viewContext

                guard let results = try? moc.fetch(request) else { return }
                self.getResults = results
                AuthorSpecificQuotesTable.reloadData()
            } catch let error{
                print(error)
            }
        }
        
        
        authorName.text = getSelectedAuthor
        authorBio.text = getBio
        authorBioHC.constant = self.authorBio.contentSize.height
        authorDescription.text = getDescription
        authorDescriptionHC.constant = self.authorDescription.contentSize.height
        moreQuotesTitle.text = "More Quotes By " + getSelectedAuthor

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetch from fav list
        let request : NSFetchRequest<FavQuotes> = FavQuotes.fetchRequest()
        let moc = container.viewContext
        
        
        guard let results = try? moc.fetch(request) else { return }
        self.getResults = results
        AuthorSpecificQuotesTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AuthorSpecificQuotesTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (getQuotes as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quotesCell", for: indexPath) as! AuthorSpecificTableCellTableViewCell
        cell.quotes.numberOfLines = 0
        cell.quotes.text = getQuotes[indexPath.row].content
        cell.getAuthor = getQuotes[indexPath.row].author
        cell.getId = getQuotes[indexPath.row]._id
        cell.getContent = getQuotes[indexPath.row].content
        cell.container = container
        
        if getResults.contains(where: {fav in fav.id == getQuotes[indexPath.row]._id}) {
            cell.favImage.tintColor = .red
            for result in getResults {
                if result.id == getQuotes[indexPath.row]._id {
                    cell.quoteObject = result
                }
            }
        } else {
            cell.favImage.tintColor = .systemBlue
        }
        
        return cell
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
