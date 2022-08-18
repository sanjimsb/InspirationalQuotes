//
//  ViewController.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-07-24.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var randomQuotes : [QuotesData] = []
    var container: NSPersistentContainer!
    var getRandomQuote : QuotesData = QuotesData(_id: "", content: "", author: "")
    var getResults : [FavQuotes] = []
    
    @IBOutlet weak var featuredAuthor: UILabel!
    @IBOutlet weak var featuredQuote: UITextView!
    
    @IBOutlet weak var randomQuotesTable: UITableView!
    
    @IBOutlet weak var favImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Inspirational Quotes"
        randomQuotesTable.delegate = self
        randomQuotesTable.dataSource = self
        
        
        Task{
            do {
                self.randomQuotes = try await Get_Quotes.fetchQuoteList()
                self.getRandomQuote = self.randomQuotes.randomElement()!
                
                //fetch from fav list
                let request : NSFetchRequest<FavQuotes> = FavQuotes.fetchRequest()
                let moc = container.viewContext
                
                guard let results = try? moc.fetch(request) else { return }
                self.getResults = results
               
                
                featuredAuthor.text = getRandomQuote.author
                featuredQuote.text = getRandomQuote.content
                self.randomQuotesTable.reloadData()
            } catch let error{
                print(error)
            }
        }
        
       
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetch from fav list
        let request : NSFetchRequest<FavQuotes> = FavQuotes.fetchRequest()
        let moc = container.viewContext
        
        
        guard let results = try? moc.fetch(request) else { return }
        self.getResults = results
        randomQuotesTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        randomQuotesTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (randomQuotes as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomQuotes", for: indexPath) as! QuotesTableViewCell
        cell.quoteContent.text = randomQuotes[indexPath.row].content
        cell.getAuthor = randomQuotes[indexPath.row].author
        cell.getId = randomQuotes[indexPath.row]._id
        cell.getContent = randomQuotes[indexPath.row].content

        cell.container = container
        
        if getResults.contains(where: {fav in fav.id == randomQuotes[indexPath.row]._id}) {
            cell.favImage.tintColor = .red
            for result in getResults {
                if result.id == randomQuotes[indexPath.row]._id {
                    cell.quoteObject = result
                    
                }
            }
        } else {
            cell.favImage.tintColor = .systemBlue
        }
        
        return cell
    }
    
    func setFav(_ isFav: Bool) {
       
    }
   

}

