//
//  endPageView.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/11.
//

import SwiftUI

struct endPageView: View {
    @Binding var  endPage  : Bool
    
    @State private var firstName = ""
    @State private var lastName = ""
        
    var body: some View {
        VStack{
            //Text(score)
            List {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("add phone")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .overlay(
                Button(action: {endPage = false
        
                }
                       , label:{Image("叉叉")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(60)
                        
                       } ),alignment: .topTrailing
            )
        }
        
    }
}

struct endPageView_Previews: PreviewProvider {
    static var previews: some View {
        endPageView(endPage: .constant(true))
            .previewLayout(.fixed(width: 844, height: 390))
            .previewDevice("iPhone 11")
    }
}
