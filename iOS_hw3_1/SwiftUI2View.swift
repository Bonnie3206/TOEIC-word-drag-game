//
//  SwiftUI2View.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/11.
//

import SwiftUI

struct SwiftUI2View: View {
    @AppStorage("username") var username: String = "Anonymous"

    var body: some View {
        VStack {
            Text("Welcome, \(username)!")

            Button("Log in") {
                username = "@twostraws"
            }
        }
    }
}

