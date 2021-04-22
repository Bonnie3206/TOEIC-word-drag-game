//
//  HighScorePage.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/20.
//

import SwiftUI

struct HighScorePage: View {
    @ObservedObject var highScoreData = HighScoreData()
    @State var showSwiftUIView = false
    
    var body: some View {
        VStack{
            Text("Result")
                .scaleEffect(1.5)
                .padding(5)
            List{
                HStack{
                    VStack{
                        Text("Rank").padding(.bottom)
                        ForEach(0 ..< highScoreData.record.count){ (i) in
                             Text(String(i + 1))
                                  .padding(.bottom)
                        }
                    }
                    Spacer()
                    VStack{
                        Text("Player").padding(.bottom)
                        ForEach(highScoreData.record){ (i) in
                            if i.PlayerName == ""{
                                Text("Unknown").padding(.bottom)
                            } else {
                                Text(i.PlayerName).padding(.bottom)
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        Text("Score").padding(.bottom)
                        ForEach(highScoreData.record){ (i) in
                            
                             Text(String(i.PlayerScore))
                                  .padding(.bottom)
                        }
                    }
                    Spacer()
                    VStack{
                        Text("Time")
                            .padding(.bottom)
                        ForEach(highScoreData.record){ (i) in
                            Text(String(i.PlayerTime))
                                .padding(.bottom)
                        }
                    }
                    Spacer()
                    VStack{
                        Text("Date")
                            .padding(.bottom)
                        ForEach(highScoreData.record){ (i) in
                            Text(String(i.userDateString))
                                .padding(.bottom)
                        }
                    }
                    
                }
                
            }
        }.sheet(isPresented: $showSwiftUIView, content:{
            SwiftUIView()
        })
        .overlay(
            Button(action: { showSwiftUIView = true
    
            }
                   , label:{Image("叉叉")
                    .resizable()
                    .scaleEffect(0.9)
                    .frame(width: 50, height: 50)
                    .padding(60)
                    .offset(x: 60, y: -60)
                    
                   } ),alignment: .topTrailing
        )
    }
}

struct HighScorePage_Previews: PreviewProvider {
    static var previews: some View {
        HighScorePage()
            .previewLayout(.fixed(width: 844, height: 390))
            .previewDevice("iPhone 11")
    }
}
