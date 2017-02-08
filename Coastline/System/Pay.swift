//
//  Pay.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/22.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import StoreKit

public class CLPay {
	public static func addPay(aid:String, delegate:SKProductsRequestDelegate, observer:SKPaymentTransactionObserver) -> SKProductsRequest {
		SKPaymentQueue.default().add(observer)
		
		let request = SKProductsRequest(productIdentifiers: NSSet(array:[aid]) as! Set<String>)
		request.delegate = delegate
		request.start()
		
		return request
	}
	
	public static func removePay(observer:SKPaymentTransactionObserver) {
		SKPaymentQueue.default().remove(observer)
	}
}

extension UIViewController {
	public func payGetProduct(_ request: SKProductsRequest, didReceive response: SKProductsResponse) -> Bool {
		if let product = response.products.first {
			let payment = SKPayment(product: product)
			SKPaymentQueue.default().add(payment)
			return true
		}
		return false
	}
	
	public func payDoAction(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) -> Bool {
		if let trans = transactions.first {
			if trans.transactionState == .purchased {
				return true
			} else if trans.transactionState == .failed {
				return false
			}
		}
		
		return false
	}
}
