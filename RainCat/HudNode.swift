//
//  HubNode.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/15.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

class HudNode : SKNode {
    
    private let scoreKey = "RAINCAT_HIGHSCORE"
    
    private let scoreNode = SKLabelNode(fontNamed: "Pixel Digivolve")
    
    private var score : Int = 0
    private var highScore:Int = 0
    private var showingHighScore = false
    
    
    public func setup(size: CGSize) {
        let defaults = UserDefaults.standard
        
        highScore = defaults.integer(forKey: scoreKey)
        
        scoreNode.text = String(highScore)
        scoreNode.fontSize = 70
        scoreNode.position = CGPoint(x: size.width/2, y: size.height - 100)
        scoreNode.zPosition = 1
        
        addChild(scoreNode)
    }
    
    ///add point
    public func addPoint(){
        score += 1
        updateScoreboard()
        
        //如果当前分高于记录
        if score > highScore {
            highScore = score
            let defaults = UserDefaults.standard
            
            defaults.set(score, forKey: scoreKey)
            
            if !showingHighScore {
                showingHighScore = true
                
                scoreNode.run(SKAction.scale(to: 1.5, duration: 0.25))
                scoreNode.fontColor = SKColor(red: 0.99, green: 0.92, blue: 0.55, alpha: 1)
            }
        }
    }
    
    public func resetPoints(){
        score = 0
        updateScoreboard()
        if showingHighScore {
            showingHighScore = false
            
            scoreNode.run(SKAction.scale(to: 1.0, duration: 0.25))
            scoreNode.fontColor = SKColor.white
        }
    }
    
    private func updateScoreboard(){
        scoreNode.text = "\(score)"
    }
}
