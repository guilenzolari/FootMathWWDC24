import SwiftUI

struct PlacarView: View {
    @EnvironmentObject var gameController:GameController

    var body: some View{
        
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
    }
    
}
