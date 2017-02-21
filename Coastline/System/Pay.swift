//
//  Pay.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/22.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import StoreKit

@objc public class CLPay : NSObject {
	var buyNumber = 1
	var request:SKProductsRequest?
	var buyAction:(String, SKPaymentTransaction)->Void = { _ in }
	
	public func register() {
		SKPaymentQueue.default().add(self)
	}
	
	deinit{
		SKPaymentQueue.default().remove(self)
	}
	
	public func addPayment(product:SKProduct) {
		let payment = SKMutablePayment(product: product)
		payment.quantity = buyNumber
		SKPaymentQueue.default().add(payment)
	}
	
	public func getProduct(pid:String, number:Int = 1) {
		buyNumber = number
		getProducts(pids: [pid])
	}
	
	public func getProducts(pids:Set<String>) {
		request = SKProductsRequest(productIdentifiers: pids)
		request?.delegate = self
		request?.start()
	}
}

extension CLPay: SKPaymentTransactionObserver {
	public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for tran in transactions {
			switch tran.transactionState {
			case .purchasing :
				print("show no deferred progress")
			case .deferred:
				print("show deferred progress")
			case .failed:
				print("transaction failed")
			case .purchased:
				print("purchased")
			case .restored:
				print("restored")
			}
		}
	}
}

extension CLPay: SKProductsRequestDelegate {
	public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		for errorId in response.invalidProductIdentifiers {
			print("invalid Products :", errorId)
		}
		
		for product in response.products {
			addPayment(product: product)
		}
	}
}
