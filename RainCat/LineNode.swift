//
//  LineNode.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/11.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

public class LineNode : SKNode {
    public func initLine(size : CGSize) {
        
        let startPoint  = CGPoint(x: size.width * 0.1, y: size.height * 0.9)
        let endPoint = CGPoint(x: size.width * 0.3, y: size.height * 0.8)
        
        physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        //做物理标记
        physicsBody?.categoryBitMask  = FloorCategory
        physicsBody?.contactTestBitMask = RainDropCategory
    }
}
