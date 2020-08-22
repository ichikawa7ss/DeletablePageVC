//
//  SecondViewController.swift
//  DeletablePageVC
//
//  Created by ichikawa on 2020/08/22.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
//    private var data = Array(repeating: "test", count: 20)
    private var data = [Int](1...20)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension SecondViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SecondTableViewCell
        cell.setData("No. \(String(self.data[indexPath.row]))")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

