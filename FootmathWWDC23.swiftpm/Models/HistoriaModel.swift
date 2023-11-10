//
//  HistoriaModel.swift
//  Footmath
//
//  Created by Guilherme Ferreira Lenzolari on 20/10/23.
//

import Foundation

class HistoriaModel: ObservableObject {
    
    @Published var etapaAtual = 0
    
    @Published var background = ["Storyboard 1", "Storyboard 2", "Storyboard 3"]
    @Published var texto = ["In a distant galaxy, there was a planet called Duo.", "On this planet, the tribes coexisted and two things were very important: math and football.", "These tribes held an annual mathematical football tournament to keep the peace: the footmath cup.", "Choose your side and do your best to defend the honor of your people."]

    let victory = "Congratulations, you've proved that you can calculate and the peace has been kept!"
    let defeat = "The opposing tribe won, But don't worry, peace prevails. don't get discouraged, keep practicing!"
    
    
    func avancar() -> Bool{
        print(etapaAtual)
        if etapaAtual < background.count - 1{
            etapaAtual += 1
            return true
        } else {
            return false
        }
    }
}
