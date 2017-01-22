//
//  Pay.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/22.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import StoreKit

@objc public class CLPay : NSObject {
	var payResult:(Bool)->Void = { _ in }
	static var shareInstance:CLPay = { CLPay() }()
	
	public override init() {
		super.init()
		
		SKPaymentQueue.default().add(self)
	}
	
	deinit {
		SKPaymentQueue.default().remove(self)
	}
	
	public func fetchProduct(aid:String) {
		let request = SKProductsRequest(productIdentifiers: Set(arrayLiteral: aid))
		request.delegate = self
		request.start()
	}
}

extension CLPay : SKProductsRequestDelegate {
	public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		if let product = response.products.first {
			let payment = SKPayment(product: product)
			SKPaymentQueue.default().add(payment)
		} else {
			print("找不到对应的商品信息")
		}
	}
}

extension CLPay : SKPaymentTransactionObserver {
	public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		if let trans = transactions.first {
			if trans.transactionState == .purchased {
				payResult(true)
			} else if trans.transactionState == .failed {
				payResult(false)
			}
		}
	}
}
