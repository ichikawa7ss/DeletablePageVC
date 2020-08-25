//
//  ChileTableViewController.swift
//  DeletablePageVC
//
//  Created by ichikawa on 2020/08/22.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class ChildTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.handleTableViewDeletableGesture()
        }
    }
    
    private var deletableGestureRecognizer: UIPanGestureRecognizer?

    private var data = [Int](1...20)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension ChildTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChildTableViewCell
        cell.setData("No. \(String(self.data[indexPath.row]))")
        return cell
    }
}

// MARK: - Setup DeletableGesture
extension ChildTableViewController {
    
    /// TableViewに優先的に判定されるPanGestureを設定する
    private func handleTableViewDeletableGesture() {
        // 初期化
        self.initializeGesture()
        
        let pageController = self.parent as! PageViewController
        
        // ①tableViewを内包するVCにUIPanGestureRecognizerを加える
        self.deletableGestureRecognizer = UIPanGestureRecognizer(target: self, action: nil)
        self.deletableGestureRecognizer?.delaysTouchesBegan = true
        self.deletableGestureRecognizer?.cancelsTouchesInView = false
        self.deletableGestureRecognizer?.delegate = self
        self.tableView.addGestureRecognizer(self.deletableGestureRecognizer!)
        
        pageController.scrollView?.canCancelContentTouches = false
        // ②tableViewのGestureが認識されたときにpageViewControllerのGestureより優先的に評価するように設定
        pageController.scrollView?.panGestureRecognizer.require(toFail: self.deletableGestureRecognizer!)
    }
    
    /// セル削除用のTapGestureの初期化
    private func initializeGesture() {
        guard let gesture = self.deletableGestureRecognizer,
            let pageController = self.parent as? PageViewController else {
                return
        }
        self.tableView.removeGestureRecognizer(gesture)
        self.deletableGestureRecognizer = nil
        pageController.scrollView?.canCancelContentTouches = true
    }
}

// MARK: - UITableViewDelegate
extension ChildTableViewController: UITableViewDelegate {
    
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

// MARK: - UIGestureRecognizerDelegate
extension ChildTableViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard
            let panGesture = gestureRecognizer as? UIPanGestureRecognizer,
            let indexPath = self.tableView.indexPathForRow(at: panGesture.location(in: self.tableView)),
            let cell = self.tableView.cellForRow(at: indexPath) else {
                return false
        }
        
        // panGestureの移動量
        let translation = panGesture.translation(in: self.tableView)

        // スワイプを始めたセルの編集モードで分岐
        switch cell.editingStyle {
        case .delete:
            return true // 削除表示されているセルは常にtableViewの制御を優先
        case .none, .insert:
            return translation.x < 0 // その他のセルは【左 <- 右】の時のみtableViewの制御（削除）を優先
        @unknown default:
            return false
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view == self.tableView
    }
}
