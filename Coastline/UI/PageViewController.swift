//
//  PageViewController.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

open class CLPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	public var pages:[UIViewController] = []
	open var cycleMode:Bool = false
	open var onSelectPage:(Int) -> () = { _ in }
	open var animated = true
	
	open var currentPage:Int = 0
	
	open func gotoNext() {
		if currentPage >= pages.count - 1 {
			currentPage = -1
		}
		
		gotoPage(index: currentPage + 1)
		onSelectPage(currentPage)
	}
	
	open func gotoPrev() {
		if currentPage < 0 {
			currentPage = pages.count
		}
		
		gotoPage(index: currentPage - 1)
		onSelectPage(currentPage)
	}
	
	open func setPages(pages:[UIViewController]) {
		self.dataSource = self
		self.delegate = self
		self.pages = pages
		self.setViewControllers([pages[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
		currentPage = 0
	}
	
	open func gotoPage(index:Int) {
		if pages.count < 2 { return }
		
		let direction = index > currentPage ? UIPageViewControllerNavigationDirection.forward : UIPageViewControllerNavigationDirection.reverse
		
		if index < pages.count {
			let page = pages[index]
			OperationQueue.main.addOperation { [weak self] in
				guard let vc = self else { return }
				vc.setViewControllers([page], direction: direction, animated: vc.animated, completion: nil)
			}
			currentPage = index
		}
	}
	
	open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if pages.count < 2 { return nil }
		
		if let index = pages.index(of: viewController) {
			if index == pages.count - 1 {
				if cycleMode {
					currentPage = 0
				}
				return self.cycleMode ? pages.first : nil
			}
			currentPage = index + 1
			return pages[index+1]
		}
		return nil
	}
	
	open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if pages.count < 2 { return nil }
		
		if let index = pages.index(of: viewController) {
			if index == 0 {
				if cycleMode {
					currentPage = pages.count - 1
				}
				return self.cycleMode ? pages.last : nil
			}
			currentPage = index - 1
			return pages[index-1]
		}
		return nil
	}
	
	//	open func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
	//		if let curPage = pendingViewControllers.first {
	//			if let index = pages.index(of: curPage) {
	//				onSelectPage(index)
	//			}
	//		}
	//	}
	
	public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if let curPage = viewControllers?.first {
			if let index = pages.index(of: curPage) {
				onSelectPage(index)
			}
		}
	}
}

