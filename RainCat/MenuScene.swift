//
//  MenuScene.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/15.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import SpriteKit

class MenuScene : SKScene {
    let startButtonTexture = SKTexture(imageNamed:"button_start")
    let startButtonPressedTexture = SKTexture(imageNamed:"button_start_pressed")
    let soundButtonTexture = SKTexture(imageNamed:"speaker_on")
    let soundButtonTextureOff = SKTexture(imageNamed:"speaker_off")
    
    let logoSprite = SKSpriteNode(imageNamed:"logo")
    var startButton : SKSpriteNode! = nil
    var soundButton : SKSpriteNode! = nil
    
    let highScoreNode = SKLabelNode(fontNamed:"Pixel Digivolve")
    
    var selectedButton : SKSpriteNode?
    
    
    ///初始化scene
    override func sceneDidLoad() {
        backgroundColor = SKColor(red: 0.3, green: 0.81, blue: 0.89, alpha: 1)
        
        logoSprite.position = CGPoint(x: size.width/2, y: size.height/2+100)
        addChild(logoSprite)
        
        startButton = SKSpriteNode(texture: startButtonTexture)
        
        startButton.position = CGPoint(x: size.width/2, y: size.height / 2 - startButton.size.height/2)
        addChild(startButton)
        
        let edgeMargin : CGFloat = 25
        
        //Set up sound button
        soundButton = SKSpriteNode(texture: soundButtonTexture)
        soundButton.position = CGPoint(x: size.width - soundButton.size.width / 2 - edgeMargin, y: soundButton.size.height / 2 + edgeMargin)
        addChild(soundButton)
        
        //Set up high-score node
        let defaults = UserDefaults.standard
        
        let highScore = defaults.integer(forKey: ScoreKey)
        
        highScoreNode.text = "\(highScore)"
        highScoreNode.fontSize = 90
        highScoreNode.verticalAlignmentMode = .top
        highScoreNode.position = CGPoint(x: size.width / 2, y: startButton.position.y - startButton.size.height / 2-50)
        highScoreNode.zPosition = 1
        
        addChild(highScoreNode)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    ///处理启动按钮悬停行为
    func handlesStartButtonHover(isHovering:Bool){
        if isHovering {
            startButton.texture = startButtonPressedTexture
        } else {
            startButton.texture = startButtonTexture
        }
    }
    
    func handlesSoundButtonHover(isHovering:Bool){
        if isHovering {
            soundButton.alpha = 0.5
        }else{
            soundButton.alpha = 1.0
        }
    }
    
    /// Stubbed out start button on click method
    func handleStartButtonClick(){
        print("start clicked")
    }
    
    /// Stubbed out sound button on click method
    func handleSoundButtonClick(){
        print("sound clicked")
    }
}
