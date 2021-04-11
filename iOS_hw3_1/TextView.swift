//
//  TextView.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/11.
//

import SwiftUI

struct TextView: View {
    
    @State private var array = [Int]()
    var demoData = DemoData()
    
    func updateFrame(geometry: GeometryProxy, index: Int) {
        let frame = geometry.frame(in: .global)
        demoData.orangeFrames[index] = frame
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                ForEach(array.indices, id: \.self) { index in
                    Text("\(index)")
                        .frame(width: 50, height: 50)
                        .background(Color.yellow)
                        .overlay(
                            GeometryReader(content: { geometry in
                                let _ = updateFrame(geometry: geometry, index: index)
                                Color.clear
                            })
                        )
                       
                        .onTapGesture {
                            print(index, demoData.orangeFrames[index])
                        }
                }
            }
            
           
            Button(action: {
                let number = Int.random(in: 1...5)
                demoData.orangeFrames = [CGRect](repeating: .zero, count: number)
                array = [Int](repeating: 1, count: number)
            }, label: {
                Text("Button")
            })
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}

class DemoData: ObservableObject {
    var orangeFrames = [CGRect]()

}

