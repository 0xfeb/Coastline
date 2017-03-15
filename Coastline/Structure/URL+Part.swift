//
//  URL+Part.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/22.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension URL {
	public var params:[String:String?] {
		guard let p = query else { return [:] }
		return p.components(separatedBy: "&").toDict{ $0.head2Parts(gap: "=") }
	}
	
	public var paramStrings:[String]? {
		guard let p = query else { return nil }
		return p.components(separatedBy: "&")
	}
	
	public func isScheme(_ scheme:String) -> URL? {
		return self.scheme == scheme ? self : nil
	}
	
	public func isHost(_ host:String) -> URL? {
		return self.host == host ? self : nil
	}
	
	public func isSchemeAndHost(_ url:String) -> URL? {
		return self.absoluteString.hasPrefix(url) ? self : nil
	}
	
	public func isPath(_ path:String) -> URL? {
		return self.path == path ? self : nil
	}
	
	public func isPrePath(_ text:String) -> URL? {
		return self.path.hasPrefix(text) ? self: nil
	}
	
	public func isPostPath(_ text:String) -> URL? {
		return self.path.hasSuffix(text) ? self: nil
	}
	
	public func isParams(_ lines:[String]) -> URL? {
		return  self.paramStrings?.includeAll(array: lines) == true ? self: nil
	}
}
