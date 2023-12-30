import Foundation

class GameController {
    var escolhaTime: EscolhaTime = EscolhaTime.azul
    var resultados: [ResultadoJogada] = []
    var timerEnds = false
    
    let background = ["GameplayBackground1", "GameplayBackground2", "GameplayBackground3"]
    let goleiro = ["goleiro1", "goleiro2", "goleiro3"]
    let goleiroSegurandoBola = ["goleiroSegurandoBola1", "goleiroSegurandoBola2", "goleiroSegurandoBola3"]
    let operacao = ["soma", "subtracao", "multiplicacao"]

    @Published var numero1:Int = 0
    @Published var numero2:Int = 0
    @Published var resultado:Int = 0
    @Published var palpites:[Int] = []
    @Published var palpiteCorreto:Int = 0
    @Published var indiceFaseJogo: Int = 0
    @Published var navigationLinkAtivo = false

    
    func iniciarJogada(operacao: String) {
        numero1 = Int.random(in: 1...10)
        numero2 = Int.random(in: 1...10)
        
        if operacao == "soma" {
            resultado = soma(numero1: numero1, numero2: numero2)
        } else if operacao == "subtracao" {
            resultado = subtracao(numero1: numero1, numero2: numero2)
        } else if operacao == "multiplicacao" {
            resultado = multiplicacao(numero1: numero1, numero2: numero2)
        }
        
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
    
    func soma(numero1: Int, numero2: Int) -> Int{
        let resultado = numero1 + numero2
        return resultado
    }
    
    func subtracao(numero1: Int, numero2: Int)-> Int{
        let resultado = numero1 - numero2
        if resultado < 0 {
            return subtracao(numero1:  numero1, numero2: numero1)
        } else{
            return resultado
        }
    }
    
    func multiplicacao(numero1: Int, numero2: Int)-> Int{
        let resultado = numero1 * numero2
        return resultado
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
 
    func proximoIndice(){
        indiceFaseJogo += 1
    }
}
