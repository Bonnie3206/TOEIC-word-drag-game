//
//  ScoreRecord.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/20.
//

import SwiftUI
import Foundation

struct Record: Identifiable, Codable  {
    var id = UUID()
    var PlayerName: String
    var PlayerScore :Int
    var PlayerTime: Double
    var userDateString: String

}


class HighScoreData: ObservableObject {
    @Published var record = [Record](){
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(record) {
                UserDefaults.standard.set(data, forKey: "records")
            }
        }
    }
    init(){
        if let data = UserDefaults.standard.data(forKey: "records") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Record].self,from: data) {
                record = decodedData
            }
        }
    }
}
