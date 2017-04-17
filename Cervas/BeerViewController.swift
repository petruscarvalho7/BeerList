//
//  ViewController.swift
//  Cervas
//
//  Created by Petrus Carvalho on 12/04/17.
//  Copyright © 2017 Petrus Carvalho. All rights reserved.
//

import UIKit
import Alamofire

class BeerViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var beerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var cervasSearch:[BeerModel]! = [BeerModel]()
    var listBeers: [BeerModel]! = [BeerModel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let URL_BEERS = "https://api.punkapi.com/v2/beers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Decorate searchBar
        decorateSearchBar()
        
        //Populate TableView
        showActivityIndicator()
        self.callBeers()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isConnectedInternet()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return cervasSearch.count
        }else{
            return listBeers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeerTableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.cervaName.text = cervasSearch[indexPath.row].cervaName
            cell.cervaImage.image = cervasSearch[indexPath.row].cervaImage
            cell.cervaDesc.text = cervasSearch[indexPath.row].cervaDesc
        }else{
            cell.cervaName.text = listBeers[indexPath.row].cervaName
            cell.cervaImage.image = listBeers[indexPath.row].cervaImage
            cell.cervaDesc.text = listBeers[indexPath.row].cervaDesc
        }
    
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueBeerIndividual") {
            let toViewController = segue.destination as? BeerDetailsViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let beer = listBeers[indexPath.row]
                toViewController?.beer = beer
            }
        }
    }
    
    //SearchController
    func filterForSeach(searchString: String){
        cervasSearch = listBeers.filter { $0.cervaName.contains(searchString) }
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterForSeach(searchString: searchController.searchBar.text!)
    }
    
    //CAll rest api
    func callBeers(){
        Alamofire.request(URL_BEERS).responseJSON { response in
            if let array = response.result.value as? [[String: Any]] {
                //If you want array of task id you can try like
                let nameArray = array.flatMap { $0["name"] as? String }
                let descArray = array.flatMap { $0["description"] as? String }
                let imageArray = array.flatMap { $0["image_url"] as? String }
                let tagArray = array.flatMap { $0["tagline"] as? String }
                
                var count = 0
                var beer: BeerModel! = BeerModel()
                for nome in nameArray{
                    beer.cervaName = nome
                    beer.cervaDesc = descArray[count]
                    beer.cervaImage = self.loadImage(urlString:imageArray[count])
                    beer.cervaTagDesc = tagArray[count]
                    count += 1
                    self.listBeers.append(beer)
                }
                self.tableView.reloadData()
                self.hideActivityIndicator()
                
            }
            
        }
    }
    
    func decorateSearchBar(){
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchbg"), for: UIControlState.normal)
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        self.searchController.searchBar.textColor = UIColor.white
        definesPresentationContext = true
        self.tableView.tableHeaderView?.backgroundColor = UIColor.init(red: 74, green: 144, blue: 226, alpha: 1)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.tableView.backgroundView?.backgroundColor = UIColor.white
        self.tableView.backgroundColor = UIColor.white
    }
    
}

extension UISearchBar {
    
    var textColor:UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as? UITextField  {
                return textField.textColor
            } else {
                return nil
            }

        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as? UITextField  {
                textField.textColor = newValue
                let textPlaceholder = textField.value(forKey: "placeholderLabel") as? UILabel
                textPlaceholder?.textColor = UIColor.white
            }
        }
    }
}
