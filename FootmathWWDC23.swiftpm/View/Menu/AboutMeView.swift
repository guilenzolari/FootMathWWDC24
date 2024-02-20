import SwiftUI

struct AboutMeView: View {
    @State var botaoAtivado = true
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Image("aboutMeBackground")
                    .resizable()
                    .ignoresSafeArea()
                
                HStack{
                    Button {
                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                        botaoAtivado = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            gameController.navigantionLinkAtivoAboutMe = false
                            botaoAtivado = true}
                    } label: {
                        Image("back")
                    }
                }.padding(.top, geometry.size.height * 8/10)
                    .disabled(!botaoAtivado)
            }.navigationBarBackButtonHidden(true)
        }
    }
}
