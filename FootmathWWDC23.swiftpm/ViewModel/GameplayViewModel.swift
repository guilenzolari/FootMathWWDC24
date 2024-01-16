//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 15/01/24.
//

import Foundation

class GameplayViewModel: ObservableObject{
 
    let background = ["GameplayBackground1", "GameplayBackground2", "GameplayBackground3"]
    let goleiro = ["goleiro1", "goleiro2", "goleiro3"]
    let goleiroSegurandoBola = ["goleiroSegurandoBola1", "goleiroSegurandoBola2", "goleiroSegurandoBola3"]
    let goleiroPerdeu = ["goleiroPerdeu1", "goleiroPerdeu2", "goleiroPerdeu3"]
    let operacao = ["soma", "subtracao", "multiplicacao"]
    
    @Published var numero1:Int = 0
    @Published var numero2:Int = 0
    @Published var resultado:Int = 0
    @Published var palpites:[Int] = []
    @Published var palpiteCorreto:Int = 0
    @Published var operacaoMatematica: String = ""
    
    func iniciarJogada(operacao: String) {
        numero1 = Int.random(in: 1...10)
        numero2 = Int.random(in: 1...10)
        
        switch operacao{
        case "soma":
            resultado = soma(numero1: numero1, numero2: numero2)
            operacaoMatematica = "\(numero1) + \(numero2)"
        case "subtracao":
            resultado = subtracao(numero1: numero1, numero2: numero2)
            operacaoMatematica = "\(numero1) - \(numero2)"
        case "multiplicacao":
            resultado = multiplicacao(numero1: numero1, numero2: numero2)
            operacaoMatematica = "\(numero1) x \(numero2)"
        default:
            print("Erro ao selecionar a operação")
        }
        
        self.palpites = [
            chuteAleatorio(operacao: operacao),
            chuteAleatorio(operacao: operacao),
            chuteAleatorio(operacao: operacao),
            chuteAleatorio(operacao: operacao),
            chuteAleatorio(operacao: operacao),
            chuteAleatorio(operacao: operacao)
        ]
        
        self.palpiteCorreto = posicaoCorreta()
        
        self.palpites[palpiteCorreto] = resultado
    }
    
    func soma(numero1: Int, numero2: Int) -> Int{
        let resultado = numero1 + numero2
        return resultado
    }
    
    func subtracao(numero1: Int, numero2: Int) -> Int {
        if numero1 <= numero2 {
            self.numero1 = Int.random(in: 1...10)
            self.numero2 = Int.random(in: 1...10)
            return subtracao(numero1: self.numero1, numero2: self.numero2)
        } else {
            return numero1 - numero2
        }
    }
    
    func multiplicacao(numero1: Int, numero2: Int)-> Int{
        let resultado = numero1 * numero2
        return resultado
    }
    
    func chuteAleatorio(operacao: String) -> Int {
        var chute: Int
        var intervalo: ClosedRange<Int>
        
        switch operacao {
        case "soma":
            intervalo = 1...20
        case "subtracao":
            intervalo = 1...10
        case "multiplicacao":
            intervalo = 1...100
        default:
            fatalError("Operação não suportada")
        }
        
        repeat {
            chute = Int.random(in: intervalo)
        } while chute == resultado || palpites.contains(chute)
        
        return chute
    }
    
    func posicaoCorreta() -> Int {
        return Int.random(in: 0...5)
    }
    
    func posicaoGoleiroAcerto(index: Int) -> Int?{
        var posicoes = [0,1,2,3,4,5]
        posicoes.remove(at: index)
        return posicoes.randomElement()
    }
    
}
