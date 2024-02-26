import SwiftUI

struct GameplayHudView: View {
    @Binding var operacaoMatematica: String
    @EnvironmentObject var timerController: TimerController
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        VStack{
            HStack{
                //Scoreboard
                ScoreboardHUD(resultados: $gameController.resultados)
                
                Spacer()
                
                //Timer
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: 60, height: 40)
                    
                    Text("\(timerController.tempo)")
                        .foregroundColor(.white)
                        .font(.system(size: 33))
                        .onChange(of: timerController.tempo) { newTempo in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                gameController.fimDaJogada(tempo: newTempo)}}
                }.padding(.top, 15)
            }.padding(.horizontal, 24)
            
            //Operacao matematica
            ZStack{
                RoundedRectangle(cornerRadius: 10.0)
                    .frame(width: 170, height: 50)
                    .foregroundStyle(.ultraThinMaterial)
                
                Text(operacaoMatematica)
                    .foregroundColor(.white)
                    .font(.system(size: 33))
                
            }.padding(.top, 24)
            
        }
    }
}

