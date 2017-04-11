//
//  FoodSprite.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/11.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

public class FoodSprite : SKSpriteNode {
    
    public static func newInstance () -> FoodSprite {
        let foodSprite = FoodSprite(imageNamed: "food_dish")
        
        //设定物理体尺寸
        foodSprite.physicsBody = SKPhysicsBody(rectangleOf: foodSprite.size)
        foodSprite.physicsBody?.categoryBitMask = FoodCategory
        foodSprite.physicsBody?.contactTestBitMask = WorldCategory | RainDropCategory | CatCategory
        foodSprite.zPosition = 5
        
        return foodSprite
        
    }
}
