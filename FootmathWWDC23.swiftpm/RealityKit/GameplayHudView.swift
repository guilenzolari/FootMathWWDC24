import SwiftUI

struct GameplayHudView: View {
    @Binding var operacaoMatematica: String
    @EnvironmentObject var timerController: TimerController
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        HStack{
            //Scoreboard
            ZStack{
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width: 160, height: 40)
                    .foregroundStyle(.ultraThinMaterial)
                
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
            
            //Timer
            ZStack{
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(width: 60, height: 40)
                    .padding(.bottom, 20)
                
                Text("\(timerController.tempo)")
                    .foregroundColor(.white)
                    .font(Font.custom("Minecraftia-Regular", size: 30))
            }
            
        }.padding(.bottom, 640)
            .padding(.horizontal, 22)
            .onChange(of: timerController.tempo) { newTempo in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    gameController.fimDaJogada(tempo: newTempo)}
            }
        
        //Operacao matematica
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: 170, height: 50)
                .padding(.bottom, 20)
                .foregroundStyle(.ultraThinMaterial)
            
            Text(operacaoMatematica)
                .foregroundColor(.white)
                .font(Font.custom("Minecraftia-Regular", size: 30))
            
        }.padding(.bottom, 500)
    }
}

