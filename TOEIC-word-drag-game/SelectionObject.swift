//
//  SelectionObject.swift
//  iOS_hw3_1
//
//  Created by CK on 2021/4/13.
//

import Foundation
import SwiftUI

struct SelectionObject{
    var positionX: CGFloat
    var positionY: CGFloat = 100
    var oldOffset = CGSize.zero
    var newOffset = CGSize.zero
}

struct PlateObject{
    var positionX: CGFloat
    var positionY: CGFloat = 150
}

struct Question{
    var voc: String
    var answer: [String]
    var selection: [String]
}
