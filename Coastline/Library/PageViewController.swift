//
//  PageViewController.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

class CLPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	var pages:[UIViewController] = []
	var cycleMode:Bool = false
	var onSelectPage:(Int) -> () = { _ in }
	
	func setPages(pages:[UIViewController]) {
		self.dataSource = self
		self.delegate = self
		self.pages = pages
		self.setViewControllers([pages[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
	}
	
	func gotoPage(index:Int) {
		if index < pages.count {
			let page = pages[index]
			self.setViewControllers([page], direction: .forward, animated: true, completion: nil)
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let index = pages.index(of: viewController) {
			if index == pages.count - 1 {
				return self.cycleMode ? pages.first : nil
			}
			return pages[index+1]
		}
		return nil
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if let index = pages.index(of: viewController) {
			if index == 0 {
				return self.cycleMode ? pages.last : nil
			}
			return pages[index-1]
		}
		return nil
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
		if let curPage = pendingViewControllers.first {
			if let index = pages.index(of: curPage) {
				onSelectPage(index)
			}
		}
	}
}

