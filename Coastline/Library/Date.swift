//
//  Date.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension Date {
	enum DateType {
		case date
		case time
		case dateTime
	}
	
	static func parser(dateString:String) -> Date? {
		let format = DateFormatter()
		let length = dateString.characters.count
		switch length {
		case 8:
			format.dateFormat = "HH:mm:ss"
		case 10:
			format.dateFormat = "yyyy-MM-dd"
		default:
			format.dateFormat = "yyyy-MM-dd HH:mm:ss"
		}
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.date(from: dateString)
	}
	
	func year() -> Int {
		let format = DateFormatter()
		format.dateFormat = "yyyy"
		format.timeZone = TimeZone.autoupdatingCurrent
		let year = format.string(from: self)
		return Int(year)!
	}
	
	func formatDate() -> String {
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd"
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.string(from: self)
	}
	
	func formatTime() -> String {
		let format = DateFormatter()
		format.dateFormat = "hh:mm:ss"
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.string(from: self)
	}
	
	func formatDateTime() -> String {
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd hh:mm:ss"
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.string(from: self)
	}
	
	func toString(_ dateType:DateType = .dateTime) -> String {
		switch dateType {
		case .date:
			return formatDate()
		case .time:
			return formatTime()
		case .dateTime:
			return formatDateTime()
		}
	}
	
	func age() -> Int {
		let curYear = Date().year()
		let year = self.year()
		return curYear - year + 1
	}
}

func > (l:Date, r:Date) -> Bool {
	return l.compare(r) == ComparisonResult.orderedDescending
}

func < (l:Date, r:Date) -> Bool {
	return l.compare(r) == ComparisonResult.orderedAscending
}

func == (l:Date, r:Date) -> Bool {
	return l.compare(r) == ComparisonResult.orderedSame
}

func >= (l:Date, r:Date) -> Bool {
	return l.compare(r) == ComparisonResult.orderedDescending || l.compare(r) == ComparisonResult.orderedSame
}

func <= (l:Date, r:Date) -> Bool {
	return l.compare(r) == ComparisonResult.orderedAscending || l.compare(r) == ComparisonResult.orderedSame
}
