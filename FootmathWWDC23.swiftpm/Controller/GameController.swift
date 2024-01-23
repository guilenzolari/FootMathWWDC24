import Foundation
import SwiftUI

class GameController: ObservableObject {
    
  //  var timerController = TimerController()
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
            }else if contadorDeAcertos() >= 3 {
                proximaFase()
            }else {
                gameOver()
            }
        }
    }
    
    func contadorDeAcertos() -> Int {
        let resultadosFiltrado = resultados.filter{ $0 == ResultadoJogada.acertou}
        print(resultadosFiltrado.count)
        return resultadosFiltrado.count
    }
    
    func resetarJogo(){
        indiceContaFase = 0
        resultados = [ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio]
    }
    
    func proximaFase(){
        indiceFaseJogo += 1
        resetarJogo()
        navigationLinkProximaFase = false
        }
    
    func gameOver(){
        navigationLinkGameOverView = true
        resetarJogo()
    }
}
