//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 09/11/23.
//

import Foundation

class TutorialController: ObservableObject {
    
    @Published var infos: [TutorialModel] = [
    TutorialModel(background: "tutorial 6.1", texto: "But first, a quick tutorial", imagem: "next button"),
    TutorialModel(background: "tutorial 6.2", texto: "Do the mathematical operations in blue", imagem: "next button"),
    TutorialModel(background: "tutorial 6.3", texto: "Click on the result in the goal", imagem: "next button"),
    TutorialModel(background: "tutorial 6.4", texto: "You will have 15 seconds to answer each operation", imagem: "next button"),
    TutorialModel(background: "tutorial 6.5", texto: "Match at least 3 out of 5 to win.", imagem: "Start button")
    ]
    
    @Published var etapaAtual = 0
    
    func avancar() -> Bool {
        if etapaAtual < infos.count - 1 {
            etapaAtual += 1
            return true
        } else {
            return false
        }
    }
}
