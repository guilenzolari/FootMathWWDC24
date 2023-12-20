//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 13/11/23.
//

import Foundation

class GameController {
    var escolhaTime: EscolhaTime = EscolhaTime.azul
    var resultados: [ResultadoJogada] = []
    
    @Published var numero1:Int = 0
    @Published var numero2:Int = 0
    @Published var resultado:Int = 0
    @Published var palpites:[Int] = []
    @Published var palpiteCorreto:Int = 0
    
    
    func iniciarJogada() {
        numero1 = Int.random(in: 1...10)
        numero2 = Int.random(in: 1...10)
        resultado = numero1 + numero2
        
        self.palpites = [
            chuteAleatorio(),
            chuteAleatorio(),
            chuteAleatorio(),
            chuteAleatorio(),
            chuteAleatorio(),
            chuteAleatorio()
        ]
        
        self.palpiteCorreto = posicaoCorreta()
        
        self.palpites[palpiteCorreto] = resultado
    }
    
    func chuteAleatorio() -> Int{
        return Int.random(in: 1...30)
    }
    
    func posicaoCorreta() -> Int {
        return Int.random(in: 0...5)
    }
    
    func adicionarResultado(_ novoResultado: ResultadoJogada) {
        resultados.append(novoResultado)
    }
}
