//TO DO

import SwiftUI

struct GameplayView: View {
    @StateObject var timerController = TimerController()
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController:GameController
    @State var botaoApertado = false
    @State var posicaoBola = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 7 / 8)
    @State var posicaoGoleiro = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 0.62)
    @State var tamanhoBola = 1.0
    @State var rotacaoGoleiro: Angle = .degrees(0.0)
    
    @State var imagemGoleiro : Image!
    @State var imagemGoleiroParado: Image!
    @State var imagemGoleiroSegurandoBola: Image!
    @State var imagemGoleiroPerdeu: Image!
    var duracaoAnimacaoDepoisChute = 1.0
    var duracaoAnimacaoDepoisDefesa = 0.7
    
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
    
//    init() {
////        gameController.iniciarJogada(operacao: gameController.operacao[gameController.indiceFaseJogo])
////        imagemGoleiro = Image(gameController.goleiro[gameController.indiceFaseJogo])
////        imagemGoleiroParado = Image(gameController.goleiro[gameController.indiceFaseJogo])
////        imagemGoleiroSegurandoBola = Image(gameController.goleiroSegurandoBola[gameController.indiceFaseJogo])
////        imagemGoleiroPerdeu = Image(gameController.goleiroPerdeu[gameController.indiceFaseJogo])
//
//    }

    var body: some View {
        ZStack {
            Image(gameController.background[gameController.indiceFaseJogo])
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    audioPlayer.playMusic(sound: "soccer-stadium", type: "mp3", volume: 0.5)
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                }
            
            HStack{
                ZStack{
                    Image("scoreboardBack")
                    HStack(spacing: 12){
                        ForEach(gameController.resultados, id: \.self) {resultado in
                            switch resultado {
                            case ResultadoJogada.acertou:
                                Image("GreenSignal")
                            case ResultadoJogada.errou:
                                Image("RedSignal")
                            case ResultadoJogada.vazio:
                                Image("GraySignal")
                            }
                        }
                    }
                }
                    .padding(.bottom, 20)
                Spacer()
                Text("\(timerController.tempo)")
                    .foregroundColor(.white)
            }.padding(.bottom, 640)
            .padding(.horizontal, 22)

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
                                        gameController.iniciarJogada(operacao: gameController.operacao[gameController.indiceFaseJogo])
                                        botaoApertado = false
                                        posicaoGoleiro = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 0.62)
                                        posicaoBola = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 7 / 8)
                                        tamanhoBola = 1.0
                                        imagemGoleiro = imagemGoleiroParado
                                        gameController.proximaFase()
                                    }
                                    if(index == gameController.palpiteCorreto){
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            audioPlayer.playEffect(effect: "goal-scream", type: "mp3", volume: 2.0)
                                            gameController.armazenarResultado(ResultadoJogada.acertou)
                                        }

                                        withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisChute)){
                                            posicaoGoleiro = posicoesGoleiro[gameController.posicaoGoleiroAcerto(index: index) ?? 6]
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                                imagemGoleiro = imagemGoleiroPerdeu
                                                withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisDefesa)){
                                                    posicaoGoleiro = CGPoint(x: posicaoGoleiro.x, y: posicoesGoleiro[1].y)
                                                }
                                            }
                                        }
                                    } else{
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            gameController.armazenarResultado(ResultadoJogada.errou)
                                            audioPlayer.playEffect(effect: "missed-goal", type: "mp3", volume: 0.8)}
                                        withAnimation(.easeInOut(duration: duracaoAnimacaoDepoisChute)){
                                            posicaoGoleiro = posicoesGoleiro[index]
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                            imagemGoleiro = imagemGoleiroSegurandoBola
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

                imagemGoleiro
                .frame(width: 40, height: 80)
                .position(posicaoGoleiro)
                .rotationEffect(rotacaoGoleiro)
            
            Image("ball")
                .position(posicaoBola)
                .scaleEffect(CGFloat(tamanhoBola))
            
            
            NavigationLink("",destination: MenuView(),isActive: $timerController.navigationLinkAtivo)
            NavigationLink("",destination: PlanetasView(),isActive: $gameController.navigationLinkProximaFase)

            
        }.font(Font.custom("Minecraftia-Regular", size: 30))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            gameController.iniciarJogada(operacao: gameController.operacao[gameController.indiceFaseJogo])
            imagemGoleiro = Image(gameController.goleiro[gameController.indiceFaseJogo])
            imagemGoleiroParado = Image(gameController.goleiro[gameController.indiceFaseJogo])
            imagemGoleiroSegurandoBola = Image(gameController.goleiroSegurandoBola[gameController.indiceFaseJogo])
            imagemGoleiroPerdeu = Image(gameController.goleiroPerdeu[gameController.indiceFaseJogo])
        }
    }
}
