//
//  ListAuthorSingleViewController.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-08-14.
//

import UIKit

class ListAuthorSingleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var getQuotes : [QuotesData] = []
    
    var getSelectedAuthor : String = ""
    var getSelectedAuthorSlug : String = ""
    var getBio : String = ""
    var getDescription : String = ""
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
                self.getQuotes = try await Get_Quotes.fetchQuoteByAuthor(getAuthor: self.getSelectedAuthorSlug)
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
