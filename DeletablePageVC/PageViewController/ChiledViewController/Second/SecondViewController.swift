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

// MARK: - DataSource
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
