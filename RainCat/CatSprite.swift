//
//  CatSprite.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/11.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

public class CatSprite : SKSpriteNode {
    
    private let movementSpeed : CGFloat = 100
    
    public static func newInstance() -> CatSprite {
        let cat = CatSprite(imageNamed: "cat_one")
        cat.zPosition = 5
        cat.physicsBody = SKPhysicsBody(circleOfRadius: cat.size.width/2)
        
        cat.physicsBody?.categoryBitMask = CatCategory
        cat.physicsBody?.contactTestBitMask = WorldCategory | RainDropCategory
        
        
        return cat
    }
    
    public func update(deltaTime : TimeInterval, foodLocation: CGPoint) {
        if foodLocation.x < position.x {
            //Food is left
            position.x -= movementSpeed * CGFloat(deltaTime)
            xScale = -1
        } else {
            //Food is right
            position.x += movementSpeed * CGFloat(deltaTime)
            xScale = 1
        }
    }
}
