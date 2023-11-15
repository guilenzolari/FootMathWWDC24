//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 13/11/23.
//

import Foundation

class GameController: ObservableObject{
    var escolhaTime: EscolhaTime = EscolhaTime.azul
    
    func contasMais() -> [String]{
        let numero1 = Int.random(in: 1...10)
        let numero2 = Int.random(in: 1...10)
        let resultado = numero1 + numero2
        print(resultado)
        return ["\(numero1)","+","\(numero2)","\(resultado)"]
    }
    
    
}
