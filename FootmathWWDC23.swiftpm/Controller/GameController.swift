import Foundation
import SwiftUI

class GameController: ObservableObject {
    var timerEnds = false
    @Published var navigationLinkProximaFase = false
    @Published var navigationLinkGameOverView = false
    @Published var navigationLinkVitoriaFasesView = false
    @Published var resultados: [ResultadoJogada] = [ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio]
    @Published var indiceFaseJogo: Int = 0
    @Published var indiceContaFase: Int = 0
    
    func armazenarResultado(_ novoResultado: ResultadoJogada) {
        resultados.remove(at: indiceContaFase)
        resultados.insert(novoResultado, at: indiceContaFase)
        indiceContaFase += 1
    }
    
    func fimDaJogada(tempo: Int) {
        if indiceContaFase == 5 || tempo == 0 {
            if indiceFaseJogo == 2 && contadorDeAcertos() >= 3 {
                navigationLinkVitoriaFasesView = true
                resetarJogo()
            }else if contadorDeAcertos() >= 3 {
                proximaFase()
            }else {
                gameOver()
            }
        }
    }
    
    func contadorDeAcertos() -> Int {
        let resultadosFiltrado = resultados.filter{ $0 == ResultadoJogada.acertou}
        return resultadosFiltrado.count
    }
    
    func resetarFase(){
        indiceContaFase = 0
        resultados = [ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio]
    }
    
    func resetarJogo(){
        resetarFase()
        indiceFaseJogo = 0
    }
    
    func proximaFase(){
        indiceFaseJogo += 1
        resetarFase()
        navigationLinkProximaFase = false
    }
    
    func gameOver(){
        navigationLinkGameOverView = true
        resetarFase()
    }
}
