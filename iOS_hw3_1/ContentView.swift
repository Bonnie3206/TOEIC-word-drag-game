//
//  ContentView.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/7.
//
/*
 1.  withAnimation
 2. 
 */
import SwiftUI
import AVFoundation

class QAData: ObservableObject {
    
    var answerFrame = [CGRect.zero]//第一次的絕對位置
    var questionFrame = [CGRect.zero]
    var nowAnswerFrameX = [CGFloat.zero]//新的絕對位置
    var nowAnswerFrameY = [CGFloat.zero]
    var nowQuestionFrameX = [CGFloat.zero]
    var nowQuestionFrameY = [CGFloat.zero]

    
}
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

}

struct ContentView: View {
    
    
    @State public var score = 0
    @StateObject var gameTimer = GameTimer()
    @State private var num = 0
    @State private var offsets = [CGSize.zero]
    @State private var newPosition = [CGSize.zero]
    //@State private var answers = [String]()
    @State private var answers = [[""]]
    //@State private var ShowQuestion = [String]()
    @State private var questions = [[""]]
    @State private var questionNumber = 0

    @State private var correctNum = 0

    @State private var intersectionIndex = Int()
    @State private var gameOverTime = 60
    
    
    @State private var start = false
    @State private var sigleMatch = [Bool]()
    @State private var endPage = false
    @State private var ifTime = 0
    @EnvironmentObject var gameObject: GameObject
    @State private var timeBar = CGSize.zero
    @State private var totalCorrect = 0
    var qaData = QAData()
    //
    func judgeIntersection(objectX: CGFloat, objectY: CGFloat, wordIndex: Int)->Int{
        let objectRect = CGRect(x: objectX, y: objectY, width: 100, height: 100)
        for index in (0..<answers[num-1].count){
            print(answers[num-1].count)
            //print("c\(wordIndex)")
            let targetRect = CGRect(x: qaData.nowAnswerFrameX[index], y: qaData.nowAnswerFrameY[index], width: 100, height: 100)
            print("\(index),\(qaData.answerFrame[index].origin.x),\(qaData.answerFrame[index].origin.y)")
            let interRect = objectRect.intersection(targetRect)
            if(interRect.width>=1 || interRect.height>=1){
                if(answers[num-1][index].isEqual(questions[num][wordIndex])){
                    
                    print("correct\(index)")
                    print("correctNum\(correctNum)")
                    
                    return index
                }//放對位置
                else{
                    return 200//放錯
                }
                
            }
        }
        
        return 100//沒放到
        
    }
    //
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
    func speak(speakWord:String){//說話
        
        let utterance =  AVSpeechUtterance(string: speakWord)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    func moveX(qus:CGFloat,ans:CGFloat) -> CGFloat{//單字跟答案匡的距離
        
        return -(ans-qus)
        
    }
    func moveY(qus:CGFloat,ans:CGFloat) -> CGFloat{
        
        return  -(ans-qus)
        
    }
///
    func updateAnswerFrame(geometry: GeometryProxy, index: Int) {
        
        qaData.answerFrame[index]=(geometry.frame(in: .global))
        qaData.nowAnswerFrameX[index] = qaData.answerFrame[index].origin.x
        qaData.nowAnswerFrameY[index] = qaData.answerFrame[index].origin.y
        print(qaData.answerFrame[index].origin.x+newPosition[index].width)
      }
    func updateQuestionFrame(geometry: GeometryProxy, index: Int) {
        
        qaData.questionFrame[index]=(geometry.frame(in: .global))
      }
   
    
    var body: some View {
        
      ZStack{
        
        Image("背景2")
            .scaleEffect(0.85)
            .offset(x: 0, y: 40)
  
        VStack{
            
            
            if start{
                //timerView(remainTime: gameObject.remainTime)
 //生成答案區
                
                HStack{
                    ForEach(0..<answers[num-1].count, id: \.self){
                        index in
                        
                        Image("answerIcon")
                            .onLongPressGesture{
                                speak(speakWord: answers[num-1][index])
                                print(qaData.answerFrame[index].origin.x+newPosition[index].width)
                            }//其實長按有解答嘿嘿
                            
                            .scaleEffect(0.4)
                            .frame(width:100,height:100)//第幾個字母的位移
                            
                            .overlay(
                                GeometryReader(content: { geometry in
                                    
                                    let _ = updateAnswerFrame(geometry: geometry, index: index)
                                    Color.clear
                                       
                                })
                             )
                            
                    }
                }
                HStack{
//圖片
                    Text("\(score)")
                    
                    Image("食物\(num)")//////為何是從1開始
                        .scaleEffect(0.8)
                        .frame(width:200,height:200)
                        .onTapGesture{
                            speak(speakWord: vocabulary[num-1])
                        }
                    ZStack{
                        
                        Image("進度條")
                            .scaleEffect(0.4)
                            .frame(width:20,height:20)
                        if gameTimer.secondsElapsed < gameOverTime{
                            Image("跑步")
                                .scaleEffect(0.1)
                                .frame(width:3,height:3)
                                .offset(x:0,y:-65+1.5*CGFloat(gameTimer.secondsElapsed))
                        }
                        
                       
                    }
                    if gameTimer.secondsElapsed < gameOverTime{
                        Text("\(gameTimer.secondsElapsed)")
                    }else{
                        Text("end")
                    }
                }
//生成題目
                HStack{
                    ForEach(0..<questions[num].count, id: \.self){
                        
                        index in
                        
                        Image(questions[num][index])
                            
                            .frame(width:50,height:50)
                            //第幾個字母的位移
                            .scaleEffect(0.5)
                            .offset(x:offsets[index].width,y:offsets[index].height)
                            .gesture(
                                DragGesture()
                                        .onChanged(
                                            {value in
                                            
                                            offsets[index].width = newPosition[index].width + value.translation.width
                                            offsets[index].height = newPosition[index].height + value.translation.height
                                            print(offsets[index].width,offsets[index].height)
                                            
                                        })
                                        .onEnded({value in
                                            
                                            newPosition[index] = offsets[index]
                                            speak(speakWord: questions[num][index])
                                            qaData.nowQuestionFrameX[index] = qaData.questionFrame[index].origin.x+newPosition[index].width//移動後座標
                                            qaData.nowQuestionFrameY[index] = qaData.questionFrame[index].origin.y+newPosition[index].height//移動後座標
                                            print(qaData.nowQuestionFrameX[index],qaData.nowQuestionFrameY[index])
                                            
                                            if correctNum < questions[num].count{//還沒完全答對的話/
                                                
                                                intersectionIndex = judgeIntersection(objectX: qaData.nowQuestionFrameX[index],objectY: qaData.nowQuestionFrameY[index],wordIndex: index)
                                                if intersectionIndex == 200||intersectionIndex == 100{//沒有相交
                                                    offsets[index].width = CGFloat.zero
                                                    offsets[index].height = CGFloat.zero
                                                    newPosition[index] = offsets[index]
                                                    
                                                }else{//有相交/
                                                    withAnimation{
                                                        offsets[index].width = 25-moveX(qus: qaData.questionFrame[index].origin.x, ans: qaData.answerFrame[intersectionIndex].origin.x)
                                                        offsets[index].height = 25-moveY(qus: qaData.questionFrame[index].origin.y, ans: qaData.answerFrame[intersectionIndex].origin.y)
                                                                  newPosition[index] = offsets[index]
                                                    }
                                                        
                                                    
                                                    print("ya\(intersectionIndex)")
                                                    correctNum += 1
                                                    if ifTime < gameOverTime && correctNum  == questions[num].count{
                                                        score+=10
                                                        totalCorrect += 1
                                                        correctNum = 0
                                                    }
                                                    
                                                }
                                            }
                                            
                                            
                                        }))
                            .overlay(
                                GeometryReader(content: { geometry in
                                    
                                    let _ = updateQuestionFrame(geometry: geometry, index: index)
                                    Color.clear
                                       
                                })
                             )
                            .overlay(
                                GeometryReader(content: { geometry in
                                    Color.clear
                                        
                                        .onAppear(perform: {
                                        
                                            
                                           
                                        })
                                })
                            )//
                    }
                }

                
            }
            HStack{
                Button(action:{
                    ifTime = gameTimer.secondsElapsed
                    if ifTime > 60{
                        endPage = true
                    }
                    initialGame()
                    speak(speakWord: vocabulary[num])
                    start = true
                    num+=1
                    qaData.answerFrame = [CGRect](repeating: CGRect.zero, count: questions[num].count+1)
                    qaData.questionFrame = [CGRect](repeating: CGRect.zero, count: questions[num].count+1)
                    offsets = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    newPosition = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    qaData.nowAnswerFrameX = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    qaData.nowAnswerFrameY = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    qaData.nowQuestionFrameX = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    qaData.nowQuestionFrameY = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    
                }, label: {Text("開始計時")})
                Button(action: {
                    
                    ifTime = gameTimer.secondsElapsed
                    if ifTime > gameOverTime{
                        endPage = true
                    }
                    speak(speakWord: vocabulary[num])
                    num+=1
                    start = true
                    
                    offsets = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    qaData.answerFrame = [CGRect](repeating: CGRect.zero, count: questions[num].count+1)
                    qaData.questionFrame = [CGRect](repeating: CGRect.zero, count: questions[num].count+1)
                    newPosition = [CGSize](repeating: CGSize.zero, count: questions[num].count+1)
                    qaData.nowAnswerFrameX = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    qaData.nowAnswerFrameY = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    qaData.nowQuestionFrameX = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)
                    qaData.nowQuestionFrameY = [CGFloat](repeating: CGFloat.zero, count: questions[num].count+1)

                
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
