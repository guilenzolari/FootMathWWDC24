//TO DO

import SwiftUI

struct GameplayView: View {
    @StateObject var timerController = TimerController()
    @EnvironmentObject var audioPlayer:AudioPlayer
    @State private var botaoApertado = false
    @State private var posicaoBola = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 7 / 8)
    @State private var posicaoGoleiro = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 0.62)
    @State private var tamanhoBola = 1.0
    @State private var rotacaoGoleiro: Angle = .degrees(0.0)
    @State private var opacidadeGoleiro = 1.0
    @State private var opacidadeGoleiroSegurandoBola = 0.0

    var duracaoAnimacaoDepoisChute = 1.0
    var duracaoAnimacaoDepoisDefesa = 0.7
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
        gameController.iniciarJogada(operacao: gameController.operacao[gameController.indiceFaseJogo])
    }

    var body: some View {
        ZStack {
            Image(gameController.background[gameController.indiceFaseJogo])
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    audioPlayer.playMusic(sound: "soccer-stadium", type: "mp3", volume: 0.5)
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                }

            Text("\(timerController.tempo)")
                .foregroundColor(.white)
                .padding(.bottom, 640)
                .padding(.leading, 250)

            Text(gameController.operacaoMatematica)
                .foregroundColor(.white)
                .padding(.bottom, 380)
            
            VStack{
                LazyHGrid(rows: linhas, spacing: 60,content: {
                    ForEach(0..<gameController.palpites.count, id: \.self) { index in
                        Text("\(gameController.palpites[index])")
                            .onTapGesture {
    
                                if !botaoApertado{
                                    botaoApertado = true
                                    audioPlayer.playEffect(effect: "soccer-kick", type: "mp3", volume: 7.0)
                                    withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisChute)){
                                        posicaoBola = posicoesBola[index]
                                        tamanhoBola = 0.6
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        gameController.iniciarJogada(operacao: "soma")
                                        botaoApertado = false
                                        posicaoGoleiro = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 0.62)
                                        posicaoBola = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 7 / 8)
                                        tamanhoBola = 1.0
                                        opacidadeGoleiro = 1.0
                                        opacidadeGoleiroSegurandoBola = 0.0
                                    }
                                    if(index == gameController.palpiteCorreto){
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            audioPlayer.playEffect(effect: "goal-scream", type: "mp3", volume: 2.0)}
                                        gameController.adicionarResultado(ResultadoJogada.acertou)
                                        withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisChute)){
                                            posicaoGoleiro = posicoesGoleiro[gameController.posicaoGoleiroAcerto(index: index) ?? 6]
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                                withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisDefesa)){
                                                    posicaoGoleiro = CGPoint(x: posicaoGoleiro.x, y: posicoesGoleiro[1].y)
                                                }
                                            }
                                        }
                                    } else{
                                        gameController.adicionarResultado(ResultadoJogada.errou)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            audioPlayer.playEffect(effect: "missed-goal", type: "mp3", volume: 0.8)}
                                        withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisChute)){
                                            posicaoGoleiro = posicoesGoleiro[index]
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                            opacidadeGoleiro = 0.0
                                            opacidadeGoleiroSegurandoBola = 1.0
                                            withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisDefesa)){
                                                posicaoBola = CGPoint(x: posicaoBola.x, y: posicoesBola[1].y)
                                                posicaoGoleiro = CGPoint(x: posicaoGoleiro.x, y: posicoesGoleiro[1].y)
                                            }
                                        }
                                    }
                                }
                            }
                    }
                })
            }.padding(.bottom, 5)
            .foregroundColor(.black)

            ZStack{
                Image(gameController.goleiro[gameController.indiceFaseJogo])
                    .opacity(opacidadeGoleiro)
                Image(gameController.goleiroSegurandoBola[gameController.indiceFaseJogo])
                    .opacity(opacidadeGoleiroSegurandoBola)
                
            }.frame(width: 40, height: 80)
                .position(posicaoGoleiro)
                .rotationEffect(rotacaoGoleiro)
            
            Image("ball")
                .position(posicaoBola)
                .scaleEffect(CGFloat(tamanhoBola))
                .opacity(opacidadeGoleiro)
            
            
            NavigationLink("",destination: Menu(),isActive: $timerController.navigationLinkAtivo)
            
        }.font(Font.custom("Minecraftia-Regular", size: 30))
        .navigationBarBackButtonHidden(true)
    }
}

