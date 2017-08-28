//
//  Animation.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/8/28.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public class AniDelegate : NSObject {
    var start:(CAAnimation)->() = { _ in }
    var stop:(CAAnimation, Bool)->() = { _ in }
    
    override init() {
        super.init()
    }
    
    public convenience init(start begin:@escaping (CAAnimation)->() = { _ in }, stop end:@escaping (CAAnimation, Bool)->()) {
        self.init()
        
        start = begin
        stop = end
    }
}

extension AniDelegate : CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        start(anim)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stop(anim, flag)
    }
}

var animationTimer:Timer?
public extension CAAnimation {
    func delegateHandler(timeout:TimeInterval, delegate:AniDelegate) {
        animationTimer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(timeAction), userInfo: delegate, repeats: false)
    }
    
    func timeAction(timer:Timer) {
        //
    }
    
    public func startAnimation(layer:CALayer, duration:TimeInterval, complete:@escaping (CAAnimation, Bool)->()) {
        self.duration = duration
        self.delegate =  AniDelegate(stop: complete)
        layer.add(self, forKey: nil)
    }
}
