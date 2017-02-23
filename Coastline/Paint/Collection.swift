//
//  Collection.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

struct CLCollection {
	var insets:UIEdgeInsets
	var gaps:CGSize
	var itemsInRow:Int
	var number:Int
	var totalWidth:CGFloat
	var heightWidthRate:CGFloat
	
	func rowsCount() -> Int {
		return number / itemsInRow + (number % itemsInRow) > 0 ? 1 : 0
	}
	
	func vectorIndexOfIndex(_ index:Int) -> (Int, Int) {
		return (index / itemsInRow, index & itemsInRow)
	}
	
	func itemSize() -> CGSize {
		let contentWidth = totalWidth - insets.left - insets.right
		let width = (contentWidth - CGFloat(itemsInRow - 1) * gaps.width) / CGFloat(itemsInRow)
		let height = width * heightWidthRate
		return CGSize(width: width, height: height)
	}
	
	func rectForItem(_ index:Int) -> CGRect {
		let vIndex = vectorIndexOfIndex(index)
		let nSize = itemSize()
		return CGRect(x: insets.left + CGFloat(vIndex.1) * nSize.width,
		              y: insets.top + CGFloat(vIndex.0) * nSize.height,
		              width: nSize.width, height: nSize.height)
	}
	
	func totalHeight() -> CGFloat {
		let lastRow = (number - 1)  / itemsInRow
		let nSize = itemSize()
		return insets.top + insets.bottom + CGFloat(lastRow) * nSize.height
	}
	
	static func setCellSizeForCollectionView(_ collectionView:UICollectionView, itemsInRow:Int, itemWidthHeightRate:CGFloat, totalWidth:CGFloat) -> CGSize {
		guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
		let gaps = CGSize(width: layout.minimumInteritemSpacing+0.2, height: layout.minimumLineSpacing+0.2)
		let sizeCollection = CLCollection(insets: layout.sectionInset, gaps: gaps, itemsInRow: itemsInRow, number: 100, totalWidth: totalWidth, heightWidthRate: itemWidthHeightRate)
		layout.itemSize = sizeCollection.itemSize()
		return sizeCollection.itemSize()
	}
	
	static func buildTabList(edge:CGFloat, gap:CGFloat, itemsInRow:Int, itemWidthHeightRate:CGFloat, totalWidth:CGFloat) -> [CGRect] {
		let sizeCollection = CLCollection(insets: UIEdgeInsets(top: 0, left: edge, bottom: 0, right: edge), gaps: CGSize(width: gap, height: 0), itemsInRow: itemsInRow, number: itemsInRow, totalWidth: totalWidth, heightWidthRate: itemWidthHeightRate)
		return (0..<itemsInRow).map { sizeCollection.rectForItem($0) }
	}
}
