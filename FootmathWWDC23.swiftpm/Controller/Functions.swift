//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 10/04/23.
//

import Foundation
import SwiftUI

func Win(){
    winOrLose.append(1)
}


func Lose() {
    winOrLose.append(0)
}

func EmptyArray() -> EmptyView {
    winOrLose.removeAll()
    return EmptyView()
}
