//
//  ContentView.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/7.
//
/*
 1. 搜集多益單字放入陣列，並給index（index,圖,單字)
 2. 將單字打散顯示在上方並可以拖曳，根據字數挖空格顯示在下方
 3. 依據index賦予每個空個應該有的值(foreach)
 */
import SwiftUI
import AVFoundation

class GameTimer: ObservableObject {
    private var frequency = 1.0
    private var timer: Timer?
    private var startDate: Date?
    @Published var secondsElapsed = 0
    func start() {
        secondsElapsed = 0
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
    { timer in
            if let startDate = self.startDate {
                self.secondsElapsed = Int(timer.fireDate.timeIntervalSince1970 -
    startDate.timeIntervalSince1970)
            }
        }
        //if timer > 50 ???????????????
    }
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    func update(){
        let totalTime = 60
        secondsElapsed = 0
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
    { timer in
            if let startDate = self.startDate {
                self.secondsElapsed = Int(timer.fireDate.timeIntervalSince1970 -
    startDate.timeIntervalSince1970)
            }
        }
        
    }
    
}

struct ContentView: View {
    
    @AppStorage("username") var username : String = "Anonymous"
    @AppStorage("") var Mymoney : String = "null"
    @StateObject var gameTimer = GameTimer()
    @State private var num = 0
    @State private var offsets = [CGSize.zero]
    @State private var newPosition = [CGSize.zero]
    //@State private var answers = [String]()
    @State private var answers = [[""]]
    //@State private var ShowQuestion = [String]()
    @State private var questions = [[""]]
    @State private var questionNumber = 0
    @State private var answerFrame = [CGRect.zero]
    @State private var questionFrame = [CGRect.zero]
    
    @State private var start = false
    @State private var sigleMatch = [Bool]()
    @State private var endPage = false
    @State private var ifTime = 0
    
    
    func initialGame(){//生成題目跟答案
        answers.removeAll()
        gameTimer.start()
        
        
        for i in 0..<vocabulary.count{
            
            answers.append(vocabulary[i].map(String.init))//拆開字母
            for j in 0..<answers[i].count{
                            if(answers[i][j]==" "){
                                answers[i][j] = ""
                            }
                        }
            print(String(i))
            print(answers[i])
            
            var tmp = answers[i]
            
            tmp.shuffle()
            //print(tmp)
            while (answers[i].elementsEqual(tmp)){
                tmp.shuffle()
            }
            questions.append(tmp)
            print(String(i))
            print(questions[i+1])//append的字從陣列1??????????
        }
    }
    func speak(speakWord:String){
        
        let utterance =  AVSpeechUtterance(string: speakWord)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }

    var body: some View {
      ZStack{
        
        Image("背景2")
            .scaleEffect(0.85)
            .offset(x: 0, y: 40)
        
          
        
        VStack{
            
            if start{
                HStack{
                    ForEach(0..<questions[num].count, id: \.self){
                        index in
                        
                        Image("answerIcon")
                            .frame(width:10,height:10)
                            .padding(30)
                            //第幾個字母的位移
                            .scaleEffect(0.5)
                            .overlay(
                                GeometryReader(content: { geometry in
                                    Color.clear
                                        .onAppear(perform: {
                                            answerFrame = [CGRect](repeating: CGRect.zero, count: questions[num].count+1)
                                            answerFrame[index]=(geometry.frame(in: .global))
                                            print(answerFrame[index])/////
                                        })
                                })
                             )
                    }
                }
                HStack{
                    
                    Image("食物\(num)")
                        .scaleEffect(0.5)
                        .frame(width:200,height:200)
                    if gameTimer.secondsElapsed < 5{
                        Text("\(gameTimer.secondsElapsed)")
                    }else{
                        Text("end")
                        //endPage = true
                    }
                    
                }
                
                HStack{
                    ForEach(0..<questions[num].count, id: \.self){
                        
                        index in
                        
                        Image(questions[num][index])
                            .frame(width:50,height:50)
                            //第幾個字母的位移
                            .scaleEffect(0.5)
                            .offset(offsets[index])
                            .gesture(DragGesture()
                                        .onChanged({value in
                                            offsets[index].width = newPosition[index].width + value.translation.width
                                            //print(offsets[index].width)
                                            offsets[index].height = newPosition[index].height + value.translation.height
                                            //print(offsets[index].height)
                                            
                                        })
                                        .onEnded({value in newPosition[index] = offsets[index]}))//
                            .overlay(
                                GeometryReader(content: { geometry in
                                    Color.clear
                                        .onAppear(perform: {
                                            questionFrame = [CGRect](repeating: CGRect.zero, count: questions[num].count+1)
                                            questionFrame[index]=(geometry.frame(in: .global))
                                           
                                            /*if questionFrame[index].intersects(answerFrame[index]){
                                                print("ya\(index)")
                                                print(questionFrame[index])
                                                print(answerFrame[index])
                                            }*/
 
                                            //print(questionFrame[index])

                                        })
                                })
                            )
                        
                        
                    
                        
                            
                        
                    }
                }

                
            }
            HStack{
                Button(action:{
                    initialGame()
                    speak(speakWord: "開始")
                    start = true
                    num+=1
                    offsets = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    newPosition = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    
                    
                }, label: {Text("開始計時")})
                Button(action: {
                    /*
                    ifTime = gameTimer.secondsElapsed
                    if ifTime > 5{
                        endPage = true
                    }*/
                    num+=1
                    start = true
                    offsets = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    newPosition = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    
                    
                
                }, label: {Text("再來")})
                .sheet(isPresented: $endPage, content:{
               endPageView()
                })
            }
        }
        
          
        
      }
     }
  
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 844, height: 390))
            .previewDevice("iPhone 11")
    }
}
