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
        
        let skyNode = SKShapeNode(rect: CGRect(origin: CGPoint(), size: size))
        skyNode.fillColor = SKColor(red:0.38, green:0.60, blue:0.65, alpha:1.0)
        skyNode.strokeColor = SKColor.clear
        skyNode.zPosition = 0
        
        addChild(skyNode)
        
        let groundSize = CGSize(width: size.width, height: size.height * 0.35)
        let groundNode = SKShapeNode(rect: CGRect(origin: CGPoint(), size: groundSize))
        groundNode.fillColor = SKColor(red:0.99, green:0.92, blue:0.55, alpha:1.0)
        groundNode.strokeColor = SKColor.clear
        groundNode.zPosition = 1
        
        addChild(groundNode)
    }
}
