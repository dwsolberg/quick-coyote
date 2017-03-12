//
//  SampleTableViewController.swift
//  Convenience
//
//  Created by David Solberg on 3/6/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import UIKit

class SampleTableViewController: UITableViewController {

    let cellNames = ["Alerts", "Item 2", "Item 3"]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SampleTableViewCell
        cell.label.text = cellNames[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = storyboard!.instantiateViewController(withIdentifier: "AlertTestVC")
            vc.title = cellNames[indexPath.row]
            navigationController!.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
