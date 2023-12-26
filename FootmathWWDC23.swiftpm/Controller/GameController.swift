import Foundation

class GameController {
    var escolhaTime: EscolhaTime = EscolhaTime.azul
    var resultados: [ResultadoJogada] = []
    var timerEnds = false

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
    
    func chuteAleatorio() -> Int {
        var chute: Int
        repeat {
            chute = Int.random(in: 1...30)
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
    
    func adicionarResultado(_ novoResultado: ResultadoJogada) {
        resultados.append(novoResultado)
    }
    
}
