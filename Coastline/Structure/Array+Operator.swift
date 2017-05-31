//
//  Array+Operator.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension Array {
	public func value(at:Int) -> Element? {
		if at < 0 || at >= self.count {
			return nil
		}
		
		return self[at]
	}
	
	// 获取数组中的任一元素
	public var any:Element? {
		get {
			let itemCount = count
			if itemCount == 0 {
				return nil
			}
			
			if itemCount == 1 {
				return first
			}
			
			let num = Int(arc4random()) % itemCount
			return self[num]
		}
	}
	
	// 根据查询条件, 获取数组中的某一元素
	public func one(_ finder:(Element)->Bool) -> Element? {
		for n in self {
			if finder(n) { return n }
		}
		return nil
	}
	
	// 根据查询条件, 获取数组中的某一元素(反向查询)
	public func oneRev(_ finder:(Element)->Bool) -> Element? {
		for i in indices.reversed() {	//使用indices的reversed, 而不是self的reversed, 可以减少内存占用
			let n = self[i]
			if finder(n) { return n }
		}
		return nil
	}
	
	// 根据查询条件, 获取数组中的Index值
	public func oneIndex(_ finder:(Element)->Bool) -> Index? {
		for i in indices {
			let n = self[i]
			if finder(n) { return i }
		}
		return nil
	}
	
	// 根据查询条件, 获取数组中的Index值(反向查询)
	public func oneIndexRev(_ finder:(Element)->Bool) -> Index? {
		let count = self.count
		if count == 0 { return nil }
		
		for i in indices.reversed() {
			let n = self[i]
			if finder(n) { return count - i - 1 }
		}
		return nil
	}
	
	// 交换某两个元素的位置
	public mutating func exchange(_ one:Index, _ another:Index) {
		let swap = self[one]
		self[one] = self[another]
		self[another] = swap
	}
	
	
	// Map函数的带Index版本
	public func mapIndex<T>(_ event:@escaping (_ value:Element, _ index:Int)->T) -> [T] {
		return indices.map{ event(self[$0], $0) }
	}
	
	// ForEach函数的带Index版本
	public func forEachIndex(_ event:@escaping (_ value:Element, _ index:Int)->()) {
		indices.forEach{ event(self[$0], $0) }
	}
	
	// FlatMap函数的带Index版本
	public func flatMapIndex<T>(_ event:@escaping (_ value:Element, _ index:Int)->T?) -> [T] {
		return indices.flatMap{ event(self[$0], $0) }
	}
	
	// Reduce函数的带Index版本
	public func reduceIndex<T>(_ inital:T, combine:(T, (value:Element, index:Int))->T) -> T {
		return indices.reduce(inital, { combine($0, (value:self[$1], index:$1)) })
	}
	
	// Filter函数的带Index版本
	public func filterIndex(_ event:@escaping (_ value:Element, _ index:Int)->Bool) -> [Element] {
		return indices.filter{ event(self[$0], $0) }.map{ self[$0] }
	}
	
	// 判断每个元素都符合验证
	public func isAll(_ checker:(_ value:Element)->Bool) -> Bool {
		for n in self {
			if checker(n) == false { return false }
		}
		return true
	}
	
	// 判断任一一个元素符合验证
	public func isAny(_ checker:(_ value:Element)->Bool) -> Bool {
		for n in self {
			if checker(n) == true { return true }
		}
		return false
	}
	
	// 字符串类型的数组合并, 这是一个危险的函数, 只适用于[String], 如果是其它类型, 则会有问题.
	public func combine(_ sep:String) -> String {
		let count = self.count
		return reduceIndex("") { (prev:String, next:(value: Element, index: Int)) -> String in
			let str = next.value as? String ?? ""
			if next.index == count - 1 {
				return prev + str
			} else {
				return prev + str + sep
			}
		}
	}
	
	public func toDict<Key, Value>(_ combiner:(Element)->(Key, Value)) -> [Key:Value] {
		var result:[Key:Value] = [:]
		
		for n in self {
			let kv = combiner(n)
			result[kv.0] = kv.1
		}
		
		return result
	}
	
	public var randomItem:Element? {
		if self.isEmpty { return nil }
		
		let rand = Int(arc4random()) % self.count
		return self[rand]
	}
	
	public mutating func shuffle(){
		for i in 0..<(count-1){
			let j = Int(arc4random_uniform(UInt32(count-i)))+i
			
			if i != j {
				swap(&self[i], &self[j])
			}
		}
	}
	
	public func randomList(num:Int) -> [Element] {
		if self.count <= num { return self }
		
		var source = self
		source.shuffle()
		return Array(source[0..<num])
	}
}

public extension Array where Element:Equatable {
	
	// 搜索并且删除元素
	public mutating func removeItem(_ item:Element) {
		for i in self.indices {
			if self[i] == item {
				self.remove(at: i)
			}
		}
	}
	
	// 搜索并且删除元素(只删除第一个搜索到的)
	public mutating func removeOneItem(_ item:Element) {
		for i in self.indices {
			if self[i] == item {
				self.remove(at: i)
				return
			}
		}
	}
	
	// 搜索并且删除元素(只删除最后一个搜索到的)
	public mutating func removeOneItemRev(_ item:Element) {
		for i in self.indices.reversed() {
			if self[i] == item {
				self.remove(at: i)
				return
			}
		}
	}
	
	// 获取一个元素的Index
	public func indexOf(_ item:Element) -> Index? {
		return oneIndex{
			return item == $0
		}
	}
	
	
	
	public func include(element:Element) -> Bool {
		return isAny{ $0 == element }
	}
	
	public func includeAny(array:[Element]) -> Bool {
		return isAny{
			let n = $0
			return array.isAny{ [n] in $0 == n }
		}
	}
	
	public func includeAll(array:[Element]) -> Bool {
		return array.isAll{
			let n = $0
			return self.isAny{ [n] in $0 == n }
		}
	}
}

public extension Array where Element:UnsignedInteger {
	public init(from:Element, to:Element, step:Int) {
		var items = Array<Element>()
		var curItem = from
		while curItem < to {
			items.append(curItem)
			curItem = curItem.advanced(by: step)
		}
		self.init(items)
	}
	
	public init(from:Element, to:Element, count:Int) {
		let step = from.distance(to: to) / count
		if step == 0 {
			self.init([from, to])
		} else {
			self.init(from:from, to:to, step:step)
		}
	}
}

public extension Array where Element:SignedInteger {
	
	public init(from:Element, to:Element, step:Int) {
		var items = Array<Element>()
		var curItem = from
		while curItem < to {
			items.append(curItem)
			curItem = curItem.advanced(by: step)
		}
		self.init(items)
	}
	
	public init(from:Element, to:Element, count:Int) {
		let step = from.distance(to: to) / count
		if step == 0 {
			self.init([from, to])
		} else {
			self.init(from:from, to:to, step:step)
		}
	}
}

public extension Array where Element == Float {
	public init(from:Element, to:Element, step:Element) {
		var items = Array<Element>()
		var curItem = from
		while curItem < to {
			items.append(curItem)
			curItem = curItem.advanced(by: step)
		}
		self.init(items)
	}
	
	public init(from:Element, to:Element, count:Element) {
		let step = from.distance(to: to) / count
		self.init(from:from, to:to, step:step)
	}
}

public extension Array where Element == CGFloat {
	public init(from:Element, to:Element, step:Element) {
		var items = Array<Element>()
		var curItem = from
		while curItem < to {
			items.append(curItem)
			curItem = curItem.advanced(by: step)
		}
		self.init(items)
	}
	
	public init(from:Element, to:Element, count:Element) {
		let step = from.distance(to: to) / count
		self.init(from:from, to:to, step:step)
	}
}

public extension Array where Element == Double {
	public init(from:Element, to:Element, step:Element) {
		var items = Array<Element>()
		var curItem = from
		while curItem < to {
			items.append(curItem)
			curItem = curItem.advanced(by: step)
		}
		self.init(items)
	}
	
	public init(from:Element, to:Element, count:Element) {
		let step = from.distance(to: to) / count
		self.init(from:from, to:to, step:step)
	}
}

