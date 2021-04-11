//
//  SwiftUIView.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/11.
//

import SwiftUI
import AVFoundation


struct SwiftUIView: View {
    
    @State var showGamePage = false
    var body: some View {
        
        ZStack{
            Image("背景1")
                .scaleEffect(0.70)
                .offset(x: 0, y: 40)
            VStack{
                Text("多益填填看")
                    .scaleEffect(5)
                    .padding(5)
                    .foregroundColor(.init(red: 0.9, green: 0.1, blue: 0.1))
                    .offset(x: 0, y: -40)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200)
                Button(action: {
                    showGamePage = true
                    
                    
                },label: {
                    Text("開始玩囉").font(.title)

                    .foregroundColor(.init(red: 0.9, green: 0.1, blue: 0.1))
                   
                    
                }).sheet(isPresented: $showGamePage, content:{
                    ContentView()
                })
            }
            
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            .previewLayout(.fixed(width: 844, height: 390))
            .previewDevice("iPhone 11")
    }
}
