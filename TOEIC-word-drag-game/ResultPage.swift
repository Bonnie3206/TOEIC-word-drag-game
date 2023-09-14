//
//  ResultPage.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/20.
//

import SwiftUI

struct ResultPage: View {
    
    @State private var playerName = ""
    @State private var playerDateStr = ""
    @State var playerScore: Int
    @State var playerDate: Date?
    @State var playerTime: Double
    @State private var GOHighScorePage = false
    
    let dateFormatter = DateFormatter()
    var HighScoreData: HighScoreData
    var body: some View {
        
        VStack{
            Form{
                Section(header: Text("Your name?"))
                {
                    TextField("Your name",text:$playerName)
                }
                Section(header: Text("Your score"))
                {
                    Text(String(playerScore))
                }
                Section(header: Text("Time"))
                {
                    Text(String(playerTime))
                }
                Section(header: Text("Date"))
                {
                    Text(String(playerDateStr))
                }
            }
            Button(action: {
                let record = Record(PlayerName: playerName, PlayerScore:playerScore, PlayerTime:playerTime,userDateString: playerDateStr)
                self.HighScoreData.record.insert(record, at: 0)
                            
                            self.GOHighScorePage = true
                        }, label: {
                            Text("Save Data")
                                .frame(width: 110)
                                
                        })
                        .padding()
            
        }
        .onAppear{
                    dateFormatter.dateFormat = "y/ MM/ d"
                    playerDateStr = dateFormatter.string(from: playerDate!)
        }
        .fullScreenCover(isPresented: $GOHighScorePage, content: {
            HighScorePage()
        })
    }
}
struct ResultPage_Previews: PreviewProvider {
    static var previews: some View {
        ResultPage(playerScore: 10, playerDate: Date(),playerTime: 0.0, HighScoreData: HighScoreData())
    }
}
