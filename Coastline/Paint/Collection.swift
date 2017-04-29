//
//  Collection.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public struct CLCollection {
	var insets:UIEdgeInsets
	var gaps:CGSize
	var itemsInRow:Int
	var number:Int
	var totalWidth:CGFloat
	var heightWidthRate:CGFloat
	
	public func rowsCount() -> Int {
		return number / itemsInRow + (number % itemsInRow) > 0 ? 1 : 0
	}
	
	public func vectorIndexOfIndex(_ index:Int) -> (Int, Int) {
		return (index / itemsInRow, index % itemsInRow)
	}
	
	public func itemSize() -> CGSize {
		let contentWidth = totalWidth - insets.left - insets.right
		let width = (contentWidth - CGFloat(itemsInRow - 1) * gaps.width) / CGFloat(itemsInRow)
		let height = width * heightWidthRate
		return CGSize(width: width, height: height)
	}
	
	public func rectForItem(_ index:Int) -> CGRect {
		let vIndex = vectorIndexOfIndex(index)
		let nSize = itemSize()
		return CGRect(x: insets.left + CGFloat(vIndex.1) * nSize.width + CGFloat(vIndex.1) * gaps.width,
		              y: insets.top + CGFloat(vIndex.0) * nSize.height + CGFloat(vIndex.0) * gaps.height,
		              width: nSize.width, height: nSize.height)
	}
	
	public func totalHeight() -> CGFloat {
		let lastRow = (number - 1)  / itemsInRow
		let nSize = itemSize()
		return insets.top + insets.bottom + CGFloat(lastRow) * nSize.height + CGFloat(lastRow + 1) * gaps.height
	}
	
	public static func setCellSizeForCollectionView(_ collectionView:UICollectionView, itemsInRow:Int, itemWidthHeightRate:CGFloat, totalWidth:CGFloat) -> CGSize {
		guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
		let gaps = CGSize(width: layout.minimumInteritemSpacing+0.2, height: layout.minimumLineSpacing+0.2)
		let sizeCollection = CLCollection(insets: layout.sectionInset, gaps: gaps, itemsInRow: itemsInRow, number: 100, totalWidth: totalWidth, heightWidthRate: itemWidthHeightRate)
		layout.itemSize = sizeCollection.itemSize()
		return sizeCollection.itemSize()
	}
	
	public static func buildTabList(edge:CGFloat, gap:CGFloat, itemsInRow:Int, itemWidthHeightRate:CGFloat, totalWidth:CGFloat) -> [CGRect] {
		let sizeCollection = CLCollection(insets: UIEdgeInsets(top: 0, left: edge, bottom: 0, right: edge), gaps: CGSize(width: gap, height: 0), itemsInRow: itemsInRow, number: itemsInRow, totalWidth: totalWidth, heightWidthRate: itemWidthHeightRate)
		return (0..<itemsInRow).map { sizeCollection.rectForItem($0) }
	}
}

public extension UIView {
	public func addCollection(views:[UIView], insets:UIEdgeInsets, gaps:CGSize, itemsInRow:Int, hwRate:CGFloat) -> CGFloat {
		let col = CLCollection(insets: insets, gaps: gaps, itemsInRow: itemsInRow, number: views.count, totalWidth: self.bounds.width, heightWidthRate: hwRate)
		views.enumerated().forEach{
			$0.element.frame = col.rectForItem($0.offset)
			print($0.element.frame)
			self.addSubview($0.element)
		}
		return col.totalHeight()
	}
}

public extension UICollectionView {
	public func setupStyle(itemsInRow:Int, hwRate:CGFloat) {
		guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else { return }
		let size = CLCollection.setCellSizeForCollectionView(self, itemsInRow: itemsInRow, itemWidthHeightRate: hwRate, totalWidth: self.bounds.width)
		layout.itemSize = size
	}
}
