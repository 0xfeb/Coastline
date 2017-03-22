//
//  Pay.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/22.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import StoreKit

@objc public class CLPay : NSObject {
	public enum PayResult {
		case faild(String)
		case success(productId:String, transaction:SKPaymentTransaction)
	}
	
	var buyNumber = 1
	var request:SKProductsRequest?
	var buyAction:(PayResult)->Void = { _ in }
	
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
	
	public func buyProduct(pid:String, response:@escaping (PayResult)->()) {
		buyAction = response
		getProduct(pid: pid)
	}
}

extension CLPay: SKPaymentTransactionObserver {
	public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		print("trans count", transactions.count)
		for tran in transactions {
			switch tran.transactionState {
			case .purchasing :
				print("show no deferred progress", tran.payment.productIdentifier)
			case .deferred:
				print("show deferred progress", tran.payment.productIdentifier)
			case .failed:
				print("transaction failed", tran.payment.productIdentifier)
				buyAction(PayResult.faild("Pay error"))
			case .purchased:
				print("purchased", tran.payment.productIdentifier)
				let productId = tran.payment.productIdentifier
				buyAction(PayResult.success(productId: productId, transaction: tran))
			case .restored:
				print("restored", tran.payment.productIdentifier)
			}
		}
	}
}

extension CLPay: SKProductsRequestDelegate {
	public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		for errorId in response.invalidProductIdentifiers {
			print("invalid Products :", errorId)
		}
		
		if response.products.isEmpty {
			buyAction(PayResult.faild("Can not find product"))
			return
		}
		
		for product in response.products {
			addPayment(product: product)
		}
	}
}
