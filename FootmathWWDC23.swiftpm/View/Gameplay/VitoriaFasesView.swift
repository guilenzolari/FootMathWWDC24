import SwiftUI

struct VitoriaFasesView: View {
    @State var botaoAtivado = true
    @State var navigantionLinkAtivoJogar = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    @StateObject var vitoriaFases = VitoriaFasesModel()
    
    var body: some View {
        GeometryReader {geometry in
            ZStack{
                
                Image(vitoriaFases.images[vitoriaFases.currentImageIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                    .onAppear{
                        audioPlayer.playEffect(effect: "goal-scream", type: "mp3", volume: 3.5)
                        vitoriaFases.startImageChangeTimer(intervalInSeconds: 0.5)
                    }
                
                Button {
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        navigantionLinkAtivoJogar = true}
                    botaoAtivado = false
                } label: {
                    Image("menuBotaoAzul")
                }.padding(.top, geometry.size.height * 7/10)
                    .disabled(!botaoAtivado)
                
                NavigationLink("",destination: MenuView(),isActive: $navigantionLinkAtivoJogar)
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}
