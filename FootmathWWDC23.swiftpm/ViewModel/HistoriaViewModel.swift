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
    
    @Published var cores: [Color] = [.yellow, .black, .black, .yellow]
    @Published var background = ["Storyboard 1", "Storyboard 2", "Storyboard 3", "Storyboard 4"]
    @Published var texto = ["In a distant galaxy, there was a planet called Duo.", "On this planet, the tribes coexisted and two things were very important: math and football.", "These tribes held an annual mathematical football tournament to keep the peace: the footmath cup.", "Choose your side and do your best to defend the honor of your people."]
    
    func avancar() -> Bool{
        if etapaAtual < background.count - 2{
            etapaAtual += 1
            return true
        } else {
            return false
        }
    }
}
