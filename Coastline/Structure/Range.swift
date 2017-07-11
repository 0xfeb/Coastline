//
//  Range.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/2/8.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension Range where Bound : SignedInteger {
	public init(inc start:Bound, inc end:Bound) {
		self.init(uncheckedBounds:(start, end))
	}
	
	public init(inc start:Bound, exc end:Bound) {
		self.init(uncheckedBounds:(start, end-1))
	}
	
	public init(exc start:Bound, inc end:Bound) {
		self.init(uncheckedBounds:(start+1, end))
	}
	
	public init(exc start:Bound, exc end:Bound) {
		self.init(uncheckedBounds:(start+1, end-1))
	}
}


public extension Range where Bound == String.Index {
    public func uiRange(_ input:UITextField) -> UITextRange? {
        guard let text = input.text else { return nil }
        let s = text.distance(from: text.startIndex, to: lowerBound)
        let e = text.distance(from: text.startIndex, to: upperBound)
        
        guard let start = input.position(from: input.beginningOfDocument, offset: s) , let end = input.position(from: input.beginningOfDocument, offset: e) else { return nil }
        
        return input.textRange(from: start, to: end)
    }
    
    public func uiRange(_ input:UITextView) -> UITextRange? {
        guard let text = input.text else { return nil }
        let s = text.distance(from: text.startIndex, to: lowerBound)
        let e = text.distance(from: text.startIndex, to: upperBound)
        
        guard let start = input.position(from: input.beginningOfDocument, offset: s) , let end = input.position(from: input.beginningOfDocument, offset: e) else { return nil }
        
        return input.textRange(from: start, to: end)
    }
    
    public func nsRange(_ text:String) -> NSRange {
        let s = text.distance(from: text.startIndex, to: lowerBound)
        let e = text.distance(from: text.startIndex, to: upperBound)
        
        return NSRange(location: s, length: e - s)
    }
    
    public func intRange(_ text:String) -> Range<Int> {
        let s = text.distance(from: text.startIndex, to: lowerBound)
        let e = text.distance(from: text.startIndex, to: upperBound)
        
        return Range<Int>(s..<e)
    }
}

public extension NSRange {
    public func range(_ text:String) -> Range<String.Index>?  {
        return Range<String.Index>(self, in: text)
    }
    
    public func uiRange(_ input:UITextField) -> UITextRange? {
        let s = self.lowerBound
        let e = self.upperBound - self.lowerBound
        
        guard let start = input.position(from: input.beginningOfDocument, offset: s) , let end = input.position(from: input.beginningOfDocument, offset: e) else { return nil }
        
        return input.textRange(from: start, to: end)
    }
    
    public func uiRange(_ input:UITextView) -> UITextRange? {
        let s = self.lowerBound
        let e = self.upperBound - self.lowerBound
        
        guard let start = input.position(from: input.beginningOfDocument, offset: s) , let end = input.position(from: input.beginningOfDocument, offset: e) else { return nil }
        
        return input.textRange(from: start, to: end)
    }
    
    public var intRange: Range<Int> {
        let s = location
        let e = length + location
        
        return Range<Int>(s..<e)
    }
}

public extension UITextRange {
    public func range(_ input:UITextField) -> Range<String.Index>? {
        guard let text = input.text else { return nil }
        
        let nr = nsrange(field: input)
        
        return Range<String.Index>(nr, in: text)
    }
    
    public func range(_ input:UITextView) -> Range<String.Index>? {
        guard let text = input.text else { return nil }
        
        let nr = nsrange(view: input)
        
        return Range<String.Index>(nr, in: text)
    }
    
    public func nsrange(field:UITextField) -> NSRange {
        let start = field.offset(from: field.beginningOfDocument, to: self.start)
        let end = field.offset(from: field.beginningOfDocument, to: self.end)
        
        return NSRange(location: start, length: end - start)
    }
    
    public func nsrange(view:UITextView) -> NSRange {
        let start = view.offset(from: view.beginningOfDocument, to: self.start)
        let end = view.offset(from: view.beginningOfDocument, to: self.end)
        
        return NSRange(location: start, length: end - start)
    }
}
