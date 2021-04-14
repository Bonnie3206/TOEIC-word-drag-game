//
//  GameObject.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/12.
//

import SwiftUI
import Foundation

class GameObject: ObservableObject{
    
    @Published var isHomeView = true
    @Published var isGameView = false
    @Published var isGameOverView = false
    @Published var isEnterNameView = false
    @Published var isInfoView = false
    @Published var playerName = ""
    @Published var questionNum = 0
    @Published var correctNum = 0
    @Published var score = 0
    @Published var remainTime = 15
    @Published var isTimeUp = false
    @Published var secondsElapsed = 0
    @Published var frequency = 1.0
    @Published var timer: Timer?
    @Published var startDate: Date?
    
    @Published var selections = [SelectionObject(positionX: 66), SelectionObject(positionX: 166), SelectionObject(positionX: 266), SelectionObject(positionX: 366), SelectionObject(positionX: 466), SelectionObject(positionX: 566), SelectionObject(positionX: 666)]
    
    //@Published var plates = [PlateObject(positionX: 50), PlateObject(positionX: 180), PlateObject(positionX: 310), PlateObject(positionX: 440), PlateObject(positionX: 570)]

    
    
    
    func clearObject(){
        playerName = ""
        questionNum = 0
        correctNum = 0
        score = 0
        remainTime = 15
        isTimeUp = false
        secondsElapsed = 0
        frequency = 1.0
    }
}
