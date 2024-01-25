import SwiftUI

struct PlanetasView: View {
    
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController:GameController
    
    let posicoesFoguete = [
        CGPoint(x: 260, y: 120),
        CGPoint(x: 270, y: 300),
        CGPoint(x: 320, y: 535),
        CGPoint(x: 255, y: 745)
    ]
    let raio: [CGFloat] = [30.0, 40.0, 35.0]
    let tempoTotal: [Double] = [4.1, 3.8, 5.2]
    
    @State var foguetePosition: CGPoint = .zero
    @State var navigationLinkAtivo = false
    
    var body: some View {
        ZStack {
            Image("PlanetasBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .onAppear {
                    audioPlayer.playMusic(sound: "rocket-sound", type: "mp3", volume: 3.5)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        animacaoFoguete(raio: raio[gameController.indiceFaseJogo], posicao: foguetePosition, tempoTotal: tempoTotal[gameController.indiceFaseJogo])
                    }
                }
            
            Image("Foguete")
                .position(foguetePosition)
            
            NavigationLink("", destination: ContentView(), isActive: $gameController.navigationLinkProximaFase)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            foguetePosition = posicoesFoguete[gameController.indiceFaseJogo]
        }
    }
    
    func animacaoFoguete(raio: CGFloat, posicao: CGPoint, tempoTotal: Double) {
        var tempo = 0.0
        let velocidade = 0.3
        
        Timer.scheduledTimer(withTimeInterval: velocidade, repeats: true) { timer in
            tempo += 0.5
            
            let angle = 2 * .pi * tempo / Double(10.0)
            let newX = raio * cos(angle) + foguetePosition.x
            let newY = raio * sin(angle) + foguetePosition.y
            
            withAnimation(.linear(duration: velocidade)) {
                foguetePosition = CGPoint(x: newX, y: newY)
            }
            
            if tempo >= tempoTotal {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    gameController.navigationLinkProximaFase = true
                }
            }
        }
    }
}
