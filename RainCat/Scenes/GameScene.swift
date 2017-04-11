//
//  GameScene.swift
//  RainCat
//
//  Created by Marc Vandehey on 8/29/16.
//  Copyright © 2016 Thirteen23. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    private var currentRainDropSpawnTime : TimeInterval = 0
    private var rainDropSpawnRate : TimeInterval = 1
    //背景
    private let backgroundNode = BackgroundNode()
    //增加BUG
    private let lineNode = LineNode()
    
    //雨滴
    let raindropTexture = SKTexture(imageNamed: "rain_drop")
    //雨伞
    private let umbrellaNode = UmbrellaSprite.newInstance()
    //猫
    private var catNode : CatSprite!
    
    //scene精灵初始化
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        backgroundNode.setup(size: size)
        addChild(backgroundNode)
        
        lineNode.initLine(size: size)
        addChild(lineNode)
        
        
        //设置世界大小
        var worldFrame = frame
        worldFrame.origin.x -= 100
        worldFrame.origin.y -= 100
        
        worldFrame.size.height += 200
        worldFrame.size.width += 200
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
        self.physicsBody?.categoryBitMask = WorldCategory
        
        self.physicsWorld.contactDelegate = self
        
        //umbrellaNode.position = CGPoint(x: frame.midX, y: frame.midY)
        umbrellaNode.updatePosition(point: CGPoint(x: frame.midX, y: frame.midY))
        umbrellaNode.zPosition = 4
        addChild(umbrellaNode)
        
    }
    
    //屏幕按下事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取按下时，触摸位置
        let touchPoint = touches.first?.location(in: self)
        
        if let point = touchPoint {
            umbrellaNode.setDestination(destination: point)
        }
    }
    
    //移动事件
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let point = touchPoint {
            umbrellaNode.setDestination(destination: point)
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update the Spawn Timer
        currentRainDropSpawnTime += dt
        
        // 设定时间间隔，每隔5秒降落一滴
        if currentRainDropSpawnTime > rainDropSpawnRate {
            currentRainDropSpawnTime = 0
            spawnRaindrop()
        }
        
        
        self.lastUpdateTime = currentTime
        umbrellaNode.update(deltaTime: dt)
    }
    
    //复用雨滴事件
    private func spawnRaindrop(){
        let raindrop = SKSpriteNode(texture: raindropTexture)
        //改变落雨点的位置为随机.arc4random 为随机函数，truncatingRemainder 为保证雨滴X坐标在屏幕内
        let xPosition = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width)
        let yPosition = size.height+raindrop.size.height
        
        raindrop.physicsBody = SKPhysicsBody(texture: raindropTexture, size: raindrop.size)
        //设置雨滴物理标记
        raindrop.physicsBody?.categoryBitMask = RainDropCategory
        raindrop.physicsBody?.contactTestBitMask = FloorCategory|WorldCategory
        raindrop.position = CGPoint(x: xPosition, y: yPosition)
        
        raindrop.zPosition = 2
        raindrop.alpha = 0.3
        
        addChild(raindrop)
    }
    
    //碰撞事件
    func didBegin(_ contact: SKPhysicsContact) {
//        DLLog(message: "出发了碰撞方法：")
        
        if contact.bodyA.categoryBitMask == RainDropCategory {
            contact.bodyA.node?.physicsBody?.collisionBitMask = 0
            contact.bodyA.node?.physicsBody?.categoryBitMask = 0
        } else if contact.bodyB.categoryBitMask == RainDropCategory {
            
            contact.bodyB.node?.physicsBody?.collisionBitMask = 0
            contact.bodyB.node?.physicsBody?.categoryBitMask = 0
        }
        
        //检测到碰撞后销毁对象
        if contact.bodyA.categoryBitMask == WorldCategory {
            contact.bodyB.node?.removeFromParent()
            contact.bodyB.node?.physicsBody = nil
            contact.bodyB.node?.removeAllActions()
        } else if contact.bodyA.categoryBitMask == WorldCategory {
            contact.bodyA.node?.removeFromParent()
            contact.bodyA.node?.physicsBody = nil
            contact.bodyA.node?.removeAllActions()
            
        }
    }
    
    //复用猫
    private func spawnCat() {
        
    }
}
