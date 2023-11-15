//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 14/11/23.
//

import Foundation

class ChutesController {
    
    func possibilidadeAleatoria() -> Int{
        return Int.random(in: 1...30)
    }
    
    func posicaoCorreta() -> Int {
        return Int.random(in: 0...5)
    }
}
