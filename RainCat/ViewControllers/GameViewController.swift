//
//  GameViewController.swift
//  RainCat
//
//  Created by Marc Vandehey on 8/29/16.
//  Copyright © 2016 Thirteen23. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    DLLog(message: "项目启动到GameViewController")
    //a声明一个scene对象
    let sceneNode = MenuScene(size: view.frame.size)
    
    SoundManager.sharedInstance.startPlaying()
    DLLog(message: "声明一个scene对象")
    //获取当前人VEIW
    if let view = self.view as! SKView? {
        //将新创见的scene添加到当前的view中
      view.presentScene(sceneNode)
        //一些方便调试信息的基础设置
      view.ignoresSiblingOrder = true
      view.showsPhysics = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
    DLLog(message: "GameViewController结束")
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }
}
