//
//  endPageView.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/11.
//

import SwiftUI

struct endPageView: View {
    @State private var firstName = ""
    @State private var lastName = ""
        
    var body: some View {
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
    }
}

struct endPageView_Previews: PreviewProvider {
    static var previews: some View {
        endPageView()
    }
}
