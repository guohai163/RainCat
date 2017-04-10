//
//  BackgroundNode.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/10.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

//Node做为背景容器
public class BackgroundNode:SKNode{
    
    //调用setup 方法添加一个物理体
    public func setup(size : CGSize){
        let yPos = size.height * 0.1
        let startPoint  = CGPoint(x: 0, y: yPos)
        let endPoint = CGPoint(x: size.width, y: yPos)
        
        physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        //restitution属性改变了地面物理弹性
        physicsBody?.restitution = 0.3
        //做物理标记
        physicsBody?.categoryBitMask  = FloorCategory
        physicsBody?.contactTestBitMask = RainDropCategory
    }
}
