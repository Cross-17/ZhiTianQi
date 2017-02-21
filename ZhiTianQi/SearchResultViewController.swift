//
//  TestViewController.swift
//  ZhiTianQi
//
//  Created by 政达 何 on 2017/2/21.
//  Copyright © 2017年 政达 何. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        city.filtered = filter()
        performUIUpdatesOnMain {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.filtered.count

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        cell.textLabel?.text = city.filtered[indexPath.item]
        return cell
    }
    func filter() -> [String]{
       return city.data.filter(){$0.contains(city.searchString)}
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 

}
