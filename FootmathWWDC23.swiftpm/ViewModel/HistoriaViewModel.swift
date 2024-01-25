//
//  HistoriaModel.swift
//  Footmath
//
//  Created by Guilherme Ferreira Lenzolari on 20/10/23.
//

import Foundation
import SwiftUI

class HistoriaViewModel: ObservableObject {
    
    @Published var etapaAtual = 0
    
    @Published var background = ["Storyboard 1", "Storyboard 2", "Storyboard 3", "Storyboard 4", "Storyboard 5"]
    @Published var sounds = ["space-sound", "soccer-stadium", "goal-scream", "chalk-black-board","rocket-sound"]
    @Published var button = ["next verde", "next azul", "next verde", "next azul", "next verde"]

    
    func avancar() -> Bool{
        if etapaAtual < background.count - 1{
            etapaAtual += 1
            return true
        } else {
            return false
        }
    }
}
