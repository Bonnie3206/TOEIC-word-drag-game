//
//  AVplayerExtension.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/12.
//

import Foundation
import UIKit
import AVFoundation

extension AVPlayer{
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    
    static let sharedDingPlayer: AVPlayer = {
    guard let url = Bundle.main.url(forResource: "ding", withExtension:
    "mp3") else { fatalError("Failed to find sound file.") }
    return AVPlayer(url: url)
    }()

    func playFromStart() {
    seek(to: .zero)
    play()
    }
    
    static func setupBgMusic(){
        
        guard let url = Bundle.main.url(forResource: "cute", withExtension: "mp3")else{fatalError("Failed to find dound file.")}
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
}

