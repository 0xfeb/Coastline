//
//  ViewController.swift
//  testCoastline
//
//  Created by 王渊鸥 on 2016/11/12.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit
import Coastline
import CoreLocation
import Photos

class ViewController: UIViewController {
	let nBag = CLNotificationBag()
	let scaner = CLBarCodeScanner()

	@IBOutlet weak var logLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		scaner.getCode { (codeObj) in
			print(codeObj)
		}
	}

	@IBAction func onClickTest(_ sender: Any) {
		scaner.start()
	}

}

