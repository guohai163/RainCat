//
//  SoundManager.swift
//  RainCat
//
//  Created by 郭海 on 2017/4/13.
//  Copyright © 2017年 Thirteen23. All rights reserved.
//

import AVFoundation

class SoundManager : NSObject, AVAudioPlayerDelegate {
    static let sharedInstance = SoundManager()
    
    var audioPlayer : AVAudioPlayer?
    var trackPosition = 0
    
    static private let tracks = [
        "bensound-clearday",
        "bensound-jazzcomedy",
        "bensound-jazzyfrenchy",
        "bensound-littleidea"
    ]
    
    //初始化，随机选择一个BGM文件
    private override init() {
        trackPosition = Int(arc4random_uniform(UInt32(SoundManager.tracks.count)))
    }
    
    public func startPlaying() {
        if audioPlayer == nil || audioPlayer?.isPlaying == false {
            let soundURL = Bundle.main.url(forResource: SoundManager.tracks[trackPosition], withExtension: "mp3")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                audioPlayer?.delegate = self
            }catch{
                DLLog(message: error)
                startPlaying()
            }
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            trackPosition = (trackPosition + 1) % SoundManager.tracks.count
            
        } else {
            DLLog(message: "Audio player is alredy playind!")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        startPlaying()
    }
}
