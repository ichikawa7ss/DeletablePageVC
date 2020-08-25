//
//  PageViewController.swift
//  DeletablePageVC
//
//  Created by ichikawa on 2020/08/19.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    var scrollView: UIScrollView? {
        if let v = self.view as? UIScrollView {
            return v
        }
        for v in view.subviews where v is UIScrollView {
            return v as? UIScrollView
        }
        return nil
    }
    
    func getFirst() -> ChileNormalViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! ChileNormalViewController
    }
    
    func getSecond() -> ChildTableViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! ChildTableViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ChildTableViewController.self) {
            // 2 -> 1
            return getFirst()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ChileNormalViewController.self) {
            // 1 -> 2
            return getSecond()
        } else {
            // 2 -> end of the road
            return nil
        }
    }
}
