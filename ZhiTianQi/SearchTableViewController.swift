//
//  SearchTableViewController
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/8.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
class SearchTableViewController: UITableViewController {
    let client = WeatherClient.shared
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var searchController : UISearchController! = nil
    var resultController: SearchResultViewController! = nil
    @IBOutlet var ResultTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultController = SearchResultViewController()
        resultController.tableView.delegate = self
        searchController = UISearchController(searchResultsController:resultController)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.view.addSubview(searchController.searchBar)
        let stack = delegate.stack
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fr.sortDescriptors = [NSSortDescriptor(key: "lastViewedAt", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            fetchedResultsController?.delegate = self
            executeSearch()
            tableView.reloadData()
        }
    }
}

// MARK: - CoreDataTableViewController (Fetches)

extension SearchTableViewController {
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}


extension SearchTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let fc = fetchedResultsController {
            return (fc.sections?.count)!
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchController.searchResultsController{
            return 0
        }
        if let fc = fetchedResultsController {
            return fc.sections![section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = fetchedResultsController?.object(at: indexPath) as! City
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")
        cell?.textLabel?.text = city.name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        if tableView == self.tableView {
       let city = fetchedResultsController?.object(at: indexPath) as! City
       city.lastViewedAt = NSDate()
       delegate.stack?.save()
        }else{
            let cit = City(CityData.filtered[indexPath.item],(delegate.stack?.context)!)
            cit.lastViewedAt = NSDate()
            delegate.stack?.save()
        }
          let _ = navigationController?.popToRootViewController(animated: true)
   }
}

extension SearchTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let set = IndexSet(integer: sectionIndex)
        
        switch (type) {
        case .insert:
            tableView.insertSections(set, with: .fade)
        case .delete:
            tableView.deleteSections(set, with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension SearchTableViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("pressed")
//        let geo = CLGeocoder()
//        
//        geo.geocodeAddressString(searchBar.text!){ (result,error) in
//            if  let error = error{
//                if error.localizedDescription.contains("8"){
//                    self.alertWithError("Could not find city \(searchBar.text!)", "ERROR")
//                }else{
//                    self.alertWithError("Network Fail", "ERROR")
//                }
//            }else{
//                let coor = result![0].location?.coordinate
//                let city = City(searchBar.text!,(self.delegate.stack?.context)!)
//                let lat = coor?.latitude
//                let lon = coor?.longitude
//                city.location = "\(lat!),\(lon!)"
//                city.lastViewedAt = NSDate()
//                let _ = self.navigationController?.popToRootViewController(animated: true)
//            }
//         }
//     }

}

extension UIViewController{
    func alertWithError(_ error: String,_ title: String) {
        let alertView = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
}

extension SearchTableViewController: UISearchResultsUpdating,UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        CityData.searchString = searchController.searchBar.text!
        print(CityData.searchString)
        searchController.searchResultsController?.viewWillAppear(true)
    }
    func willPresentSearchController(_ searchController: UISearchController) {
        performUIUpdatesOnMain {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("pressed")
        print(self)
        let geo = CLGeocoder()
        self.searchController.searchResultsController?.dismiss(animated: true, completion: nil)
        geo.geocodeAddressString(searchBar.text!){ (result,error) in
            if  let error = error{
                if error.localizedDescription.contains("8"){
                    self.alertWithError("Could not find city \(searchBar.text!)", "ERROR")
                }else{
                    self.alertWithError("Network Fail", "ERROR")
                }
            }else{
                let coor = result![0].location?.coordinate
                let city = City(searchBar.text!,(self.delegate.stack?.context)!)
                let lat = coor?.latitude
                let lon = coor?.longitude
                city.location = "\(lat!),\(lon!)"
                city.lastViewedAt = NSDate()
                performUIUpdatesOnMain {
                    let _ = self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}

