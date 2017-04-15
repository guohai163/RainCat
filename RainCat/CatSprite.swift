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
    
    //猫咪叫声文件
    private let meowSFX = [
        "cat_meow_1.mp3",
        "cat_meow_2.mp3",
        "cat_meow_3.mp3",
        "cat_meow_4.mp3",
        "cat_meow_5.wav",
        "cat_meow_6.wav",
        "cat_meow_7.mp3"
    ]
    //当前被击中
    private var currentRainHits = 4
    //最大被击中数
    private var maxRainHits = 4
    
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
        //当猫猫被重置后，计时功能
        timeSinceLastHit += deltaTime
        
        if timeSinceLastHit >= maxFlailTime {
            
     
            //增加猫的动画
            if action(forKey: walkingActionKey) == nil{
                let walkingAction = SKAction.repeatForever(
                    SKAction.animate(with: walkFrames, timePerFrame: 0.1, resize: false, restore: true)
                )
                run(walkingAction, withKey: walkingActionKey)
            }
            
            if zRotation != 0 && action(forKey: "action_rotate") == nil {
                run(SKAction.rotate(toAngle: 0, duration: 0.25), withKey: "action_rotate")
            }
            
            if foodLocation.y > position.y && abs(foodLocation.x - position.x) < 2 {
                physicsBody?.velocity.dx = 0
                removeAction(forKey: walkingActionKey)
                texture = walkFrames[1]
            }else if foodLocation.x < position.x {
                //Food is left
                position.x -= movementSpeed * CGFloat(deltaTime)
                xScale = -1
            } else {
                //Food is right
                position.x += movementSpeed * CGFloat(deltaTime)
                xScale = 1
            }
            physicsBody?.angularVelocity = 0
        }
    }
    
    //cat hit event
    public func HitByRain(){

        timeSinceLastHit = 0
        //移除走路事件
        removeAction(forKey: walkingActionKey)
        
        if currentRainHits < maxRainHits {
            currentRainHits += 1
            return
        }
        
        if action(forKey: "action_sound_effect") == nil {
            currentRainHits = 0
            //使用随机数，取出一个叫声文件
            let selectSFX = Int(arc4random_uniform(UInt32(meowSFX.count)))
            
            run(SKAction.playSoundFileNamed(meowSFX[selectSFX], waitForCompletion: true), withKey: "action_sound_effect")
            
        }
    }
}
