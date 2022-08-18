//
//  ListAuthorsViewController.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-08-14.
//

import UIKit

class ListAuthorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var getAuthors : [Authors] = []
    @IBOutlet weak var AuthorsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthorsTable.delegate = self
        AuthorsTable.dataSource = self
        self.title = "Authors"
        Task{
            do {
                self.getAuthors = try await Get_Quotes.fetchAuthors()
                self.AuthorsTable.reloadData()
            } catch let error{
                print(error)
            }
        }
        print("%%%%%")
        print(getAuthors)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AuthorsTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AuthorsTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (getAuthors as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell", for: indexPath) as! AuthorsTableViewCell
        cell.AuthorName.text = getAuthors[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "singleAuthor" {
            let indexPath = self.AuthorsTable.indexPathForSelectedRow!
            let singleAuthor = segue.destination as! ListAuthorSingleViewController
            singleAuthor.getSelectedAuthor = getAuthors[indexPath.row].name
            singleAuthor.getSelectedAuthorSlug = getAuthors[indexPath.row].slug
            singleAuthor.getBio = getAuthors[indexPath.row].bio
            singleAuthor.getDescription = getAuthors[indexPath.row].description
        }
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
