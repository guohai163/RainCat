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
    
    override func sceneDidLoad() {
        backgroundColor = SKColor(red: 0.3, green: 0.81, blue: 0.89, alpha: 1)
        
    }
}
