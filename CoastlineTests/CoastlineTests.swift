//
//  CoastlineTests.swift
//  CoastlineTests
//
//  Created by 王渊鸥 on 2016/11/12.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import XCTest

class CoastlineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testNewVersion() {
		let app = UIApplication.shared
		XCTAssert(app.isNewVersion)
	}
    
}
