import Foundation
import SwiftUI

class GameController: ObservableObject {
    
    var timerController = TimerController()
    var timerEnds = false
    var navigationLinkProximaFase = false
        
    @Published var resultados: [ResultadoJogada] = [ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio]
    @Published var indiceFaseJogo: Int = 0
    @Published var indiceContaFase: Int = 0
    
    func armazenarResultado(_ novoResultado: ResultadoJogada) {
        resultados.remove(at: indiceContaFase)
        resultados.insert(novoResultado, at: indiceContaFase)
        indiceContaFase += 1
    }
    
    func proximaFase(){
        if indiceContaFase == 5{
            navigationLinkProximaFase = true
            indiceFaseJogo += 1
            indiceContaFase = 0
            resultados = [ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio]
        }
    }
    
    func contadorDeAcertos(resultados: [ResultadoJogada]) -> Int {
        let resultadosFiltrado = resultados.filter{ $0 == ResultadoJogada.acertou}
        return resultadosFiltrado.count
    }
}
