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
	
	public init?(string:String) {
		let format = DateFormatter()
		let length = string.characters.count
		switch length {
		case 8:
			format.dateFormat = "HH:mm:ss"
		case 10:
			format.dateFormat = "yyyy-MM-dd"
		default:
			format.dateFormat = "yyyy-MM-dd HH:mm:ss"
		}
		format.timeZone = TimeZone.autoupdatingCurrent
		if let dt = format.date(from: string) {
			self = dt
		} else {
			return nil
		}
	}
	
	var year: Int {
		return Calendar.current.component(.year, from: self)
	}
	
	var month: Int {
		return Calendar.current.component(.month, from: self)
	}
	
	var day: Int {
		return Calendar.current.component(.day, from: self)
	}
	
	var hour: Int {
		return Calendar.current.component(.hour, from: self)
	}
	
	var minute: Int {
		return Calendar.current.component(.minute, from: self)
	}
	
	var second: Int {
		return Calendar.current.component(.second, from: self)
	}
	
	var weekday: Int {
		return Calendar.current.component(.weekday, from: self)
	}

	
	var dateString: String {
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd"
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.string(from: self)
	}
	
	var timeString: String {
		let format = DateFormatter()
		format.dateFormat = "hh:mm:ss"
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.string(from: self)
	}
	
	var dateTimeString: String {
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd hh:mm:ss"
		format.timeZone = TimeZone.autoupdatingCurrent
		return format.string(from: self)
	}
	
	func string(_ dateType:DateType = .dateTime) -> String {
		switch dateType {
		case .date:
			return dateString
		case .time:
			return timeString
		case .dateTime:
			return dateTimeString
		}
	}
	
	var age : Int {
		let curYear = Date().year
		let year = self.year
		return curYear - year + 1
	}
	
	var todayFirstTime : Date {
		let str = self.dateString + " 00:00:00"
		return Date(string: str) ?? self
	}
	
	var todayLastTime : Date {
		let str = self.dateString + " 23:59:59"
		return Date(string: str) ?? self
	}
	
	var shortString:String {
		let curDate = Date()
		let t = curDate.timeIntervalSince(self)
		if t < 60 {
			return "刚刚"
		} else if t < 3600 {
			let t = max(Int(t / 60), 1)
			return "\(t)分钟前"
		} else if t < 3600 * 24 {
			let t = max(Int(t / 3600), 1)
			return "\(t)小时前"
		} else {
			let s = curDate.todayFirstTime.timeIntervalSince(self)
			if s < 3600 * 24 {
				return "昨天"
			} else if s < 3600 * 48 {
				return "前天"
			}
		}
		
		return dateString
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
