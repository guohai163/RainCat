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
    private let walkingActionKey = "action_walking"
    
    //设置小猫晕眩时间
    private var timeSinceLastHit : TimeInterval = 2
    private let maxFlailTime : TimeInterval = 2
    
    //两个图像针
    private let walkFrames = [
        SKTexture(imageNamed: "cat_one"),
        SKTexture(imageNamed: "cat_two")
    ]
    
    //静态单例方法
    public static func newInstance() -> CatSprite {
        let cat = CatSprite(imageNamed: "cat_one")
        cat.zPosition = 5
        cat.physicsBody = SKPhysicsBody(circleOfRadius: cat.size.width/2)
        
        cat.physicsBody?.categoryBitMask = CatCategory
        cat.physicsBody?.contactTestBitMask = WorldCategory | RainDropCategory
        
        
        return cat
    }
    
    public func update(deltaTime : TimeInterval, foodLocation: CGPoint) {
        
        if timeSinceLastHit >= maxFlailTime {
            //增加猫的动画
            if action(forKey: walkingActionKey) == nil{
                let walkingAction = SKAction.repeatForever(
                    SKAction.animate(with: walkFrames, timePerFrame: 0.1, resize: false, restore: true)
                )
                run(walkingAction, withKey: walkingActionKey)
            }
            
            
            if foodLocation.x < position.x {
                //Food is left
                position.x -= movementSpeed * CGFloat(deltaTime)
                xScale = -1
            } else {
                //Food is right
                position.x += movementSpeed * CGFloat(deltaTime)
                xScale = 1
            }}
    }
    
    //cat hit event
    public func HitByRain(){
        timeSinceLastHit = 0
        //移除走路事件
        removeAction(forKey: walkingActionKey)
    }
}
