//
//  ViewController.swift
//  TestCoastline
//
//  Created by 王渊鸥 on 2017/8/20.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit
import Coastline
import Photos

class ViewController: UIViewController {
    var scanner:CLBarCodeScanner?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testDeviceId()
        testAlbums()
    }

    func testDeviceId() {
        let s = UIApplication.shared.udid
        print(s)
        
        if s == "0C4C5D6C-B3BD-4E2B-B888-EA3446A5AEAE" {
            print("success")
        }
    }
    
    func testAlbums() {
        let albums = PHAssetCollection.albums()
        let assets = albums.map({ $0.assets() }).flat().flatMap({ $0.image })
        print(assets)
    }
    
    func testBarCode() {
        scanner = CLBarCodeScanner(view: self.view, response: { (obj) in
            print(obj)
        })
    }
}

