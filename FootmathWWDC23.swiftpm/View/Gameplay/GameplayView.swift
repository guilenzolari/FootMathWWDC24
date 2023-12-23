//TO DO
//Fazer a bola diminuir de tamanho conforme se move
//fazer goleiro
//colocar sons de quando faz gol e erra

import SwiftUI

struct GameplayView: View {
    @StateObject var timerModel = TimerModel()
    @State private var botaoApertado = false
    @State private var posicaoBola = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 7 / 8)
    @State private var posicaoGoleiro = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 0.6)
    @State private var tamanhoBola = 1.0
    @State private var rotacaoGoleiro: Angle = .degrees(0.0)
    
    var duracaoAnimacao = 1.0
    var gameController = GameController()
    let linhas = [
        GridItem(.fixed(3), spacing: 60),
        GridItem(.fixed(3))]
    let posicoesGoleiro: [CGPoint] = [
        CGPoint(x: 90, y: 380),
        CGPoint(x: 90, y: 440),
        CGPoint(x: 195, y: 380),
        CGPoint(x: 195, y: 440),
        CGPoint(x: 300, y: 380),
        CGPoint(x: 300, y: 440),
        CGPoint(x: 90, y: UIScreen.main.bounds.size.height * 0.6)]
    let posicoesBola: [CGPoint] = [
        CGPoint(x: 20, y: 350),
        CGPoint(x: 20, y: 450),
        CGPoint(x: 195, y: 350),
        CGPoint(x: 195, y: 450),
        CGPoint(x: 370, y: 350),
        CGPoint(x: 370, y: 450)]
    init() {
        gameController.iniciarJogada()
    }

    var body: some View {
        ZStack {
            Image("GameplayBackground")
                .edgesIgnoringSafeArea(.top)

            Text("\(timerModel.countdown)")
                .foregroundColor(.white)
                .padding(.bottom, 640)
                .padding(.leading, 250)

            Text("\(gameController.numero1) + \(gameController.numero2)")
                .foregroundColor(.white)
                .padding(.bottom, 405)
            
            VStack{
                LazyHGrid(rows: linhas, spacing: 60,content: {
                    ForEach(0..<gameController.palpites.count, id: \.self) { index in
                        Text("\(gameController.palpites[index])")
                            .onTapGesture {

                                if !botaoApertado{
                                    botaoApertado = true
                                    withAnimation(.easeInOut(duration: duracaoAnimacao)){
                                        posicaoBola = posicoesBola[index]
                                        tamanhoBola = 0.6
                                    }
                                    if(index == gameController.palpiteCorreto){
                                        gameController.adicionarResultado(ResultadoJogada.acertou)
                                        withAnimation(.easeInOut(duration: duracaoAnimacao)){
                                            posicaoGoleiro = posicoesGoleiro[6]
                                        }
                                    } else{
                                        gameController.adicionarResultado(ResultadoJogada.errou)
                                        withAnimation(.easeInOut(duration: duracaoAnimacao)){
                                            posicaoGoleiro = posicoesGoleiro[index]
                                        }
                                    }
                                }
                            }
                    }
                })
            }.padding(.bottom, 35)
            .foregroundColor(.black)

            Image("goleiro")
                .frame(width: 40, height: 80)
                .position(posicaoGoleiro)
                .foregroundColor(.red)
                .rotationEffect(rotacaoGoleiro)
            
            Image("ball")
                .position(posicaoBola)
                .scaleEffect(CGFloat(tamanhoBola))
            
        }.font(Font.custom("8-bit Arcade In", size: 55))
        .navigationBarBackButtonHidden(true)
    }
}

