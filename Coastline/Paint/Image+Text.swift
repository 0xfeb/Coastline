//
//  Image+Text.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/7/15.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension String {
    func image(color:UIColor = UIColor.white, backColor:UIColor = UIColor.darkGray, size:CGSize = CGSize(width:200, height:200)) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let canvas:CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let backRect = CGRect(origin:CGPoint(), size:size)
        canvas.setFillColor(backColor.cgColor)
        canvas.fill(backRect)

        let attr = CLAttributes()
        if #available(iOS 8.2, *) {
            let font = UIFont.systemFont(ofSize: size.width / 4.0, weight: UIFontWeightLight)
            attr.font = font
        } else {
            let font = UIFont.systemFont(ofSize: size.width / 4.0)
            attr.font = font
        }
        attr.alignment = NSTextAlignment.center
        attr.textColor = color
        self.drawInRect(backRect, attr: attr.dict)

        let img = UIGraphicsGetImageFromCurrentImageContext()?.cgImage

        UIGraphicsEndImageContext()
        
        if let img = img {
            return UIImage(cgImage: img)
        }
        return nil
    }
}
