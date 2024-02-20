import Foundation
import SwiftUI

class GameController: ObservableObject {
    weak var timer: TimerController?
    @Published var navigationLinkProximaFase = false
    @Published var navigationLinkGameOverView = false
    @Published var navigationLinkVitoriaFasesView = false
    @Published var navigantionLinkAtivoAboutMe = false
    @Published var resultados: [ResultadoJogada] = [ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio, ResultadoJogada.vazio]
    @Published var indiceFaseJogo: Int = 0
    @Published var indiceContaFase: Int = 0
    @Published var didFoundPlan = false
    
    func armazenarResultado(_ novoResultado: ResultadoJogada) {
        resultados.remove(at: indiceContaFase)
        resultados.insert(novoResultado, at: indiceContaFase)
        indiceContaFase += 1
    }
    
    func fimDaJogada(tempo: Int) {
        if indiceContaFase == 5 || tempo == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                self.timer?.stopTimer()
                print("Fim da Fase")
                if self.indiceFaseJogo == 2 && self.contadorDeAcertos() >= 3 {
                    self.didFoundPlan = false
                    print("Ir pra fase de vitória")
                    self.faseDeVitoria()
                }else if self.contadorDeAcertos() >= 3 {
                    self.didFoundPlan = false
                    print("Ir pra próxima fase de vitória")
                    self.proximaFase()
                }else {
                    print("Ir pro Game Over")
                    gameOver()
                }
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
    
    func faseDeVitoria(){
        navigationLinkVitoriaFasesView = true
        resetarJogo()
    }
}
