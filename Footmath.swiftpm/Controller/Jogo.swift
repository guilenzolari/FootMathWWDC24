//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 13/09/23.
//

import Foundation

struct DadosJogada {
    var operacao: String
    var opcoes:[Int]
    var indiceValorCorreto:Int
}

class Jogo: ObservableObject{
    
    @Published var jogadas: [ResultadoJogada] = []
    
    @Published var jogadaAtual = DadosJogada(operacao: "11 + 4",
                                             opcoes: [10, 12, 9, 15, 20, 13],
                                             indiceValorCorreto: 3)
    
    func avaliarJogada(indicePalpite:Int) {
        if indicePalpite == jogadaAtual.indiceValorCorreto {
            print("Acertou!")
            jogadas.append(ResultadoJogada.acertou)
        } else {
            print("Errou!")
            jogadas.append(ResultadoJogada.errou)
        }
    }
    
    func acertou(){
        jogadas.append(ResultadoJogada.acertou)
    }
    
    func errou(){
        jogadas.append(ResultadoJogada.errou)
    }
    
    func vazio(){
        jogadas.append(ResultadoJogada.vazio)
    }
}
