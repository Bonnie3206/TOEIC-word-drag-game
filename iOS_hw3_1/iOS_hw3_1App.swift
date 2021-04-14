//
//  iOS_hw3_1App.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/7.
//

import SwiftUI
import AVFoundation

@main

struct iOS_hw3_1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SwiftUIView()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {

func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.volume = 0.2
        AVPlayer.bgQueuePlayer.play()

    return true
    }
}

