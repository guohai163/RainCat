//
//  UmbrellaSprite.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/10.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

public class UmbrellaSprite : SKSpriteNode {
    
    //目的地变量
    private var destination : CGPoint!
    //
    private let easing : CGFloat = 0.1
    
    public static func newInstance() -> UmbrellaSprite {
        DLLog(message: "new umbrella class")
        let umbrell = UmbrellaSprite(imageNamed: "umbrella")
        
//        雨伞路径
        let path = UIBezierPath()
        path.move(to: CGPoint())
        path.addLine(to: CGPoint(x: -umbrell.size.width/2-30, y: 0))
        path.addLine(to: CGPoint(x: 0, y: umbrell.size.height / 2))
        path.addLine(to: CGPoint(x: umbrell.size.width / 2 + 30, y: 0))
        
        umbrell.physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        umbrell.physicsBody?.isDynamic = false
        umbrell.physicsBody?.restitution = 0.9
        
        return umbrell
    }
    
    public func updatePosition(point : CGPoint){
        position = point
        destination = point
    }
    
    public func setDestination(destination : CGPoint){
        self.destination = destination
    }
    
    public func update(deltaTime: TimeInterval){
        //position 为当前雨伞位置
        let distance = sqrt(pow((destination.x - position.x), 2) + pow((destination.y - position.y), 2))
        if(distance > 1) {
            let directionX = (destination.x - position.x)
            let directionY = (destination.y - position.y)
            
            position.x += directionX * easing
            position.y += directionY * easing
        } else {
            position = destination;
        }
    }
}
