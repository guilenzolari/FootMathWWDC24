import SwiftUI

struct GameOverHudView: View {
    @EnvironmentObject var timerController: TimerController
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Text("GAME\nOVER")
                    .foregroundColor(.white)
                    .font(Font.custom("8-bit Arcade In", size: 150))
                
                Spacer()
                Spacer()
                
                Button {
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 1.0)
                    gameController.navigationLinkProximaFase = false
                    gameController.navigationLinkGameOverView = false
                    gameController.didFoundPlan = false
                } label: {
                    Image("playAgain")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    GameOverHudView()
}
