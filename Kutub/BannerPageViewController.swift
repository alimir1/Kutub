//
//  BannerPageViewController.swift
//  Kutub
//
//  Created by Ali Mir on 12/8/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BannerPageViewController: UIPageViewController {

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.getBannerItemVC(image: #imageLiteral(resourceName: "ayatollahMutahhari")),
                self.getBannerItemVC(image: #imageLiteral(resourceName: "Ayatollah_tabatabai")),
                self.getBannerItemVC(image: #imageLiteral(resourceName: "sunrisePraying"))]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        let klsd = orderedViewControllers.first
        
    }
    
    private func getBannerItemVC(image: UIImage) -> UIViewController {
        let bannerItemVC = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "bannerItem") as! BannerItemController
        bannerItemVC.image = image
        return bannerItemVC
    }
}

extension BannerPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
