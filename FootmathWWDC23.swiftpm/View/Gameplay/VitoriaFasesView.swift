import SwiftUI

struct VitoriaFasesView: View {
    @State var botaoAtivado = true
    @State var navigantionLinkAtivoJogar = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    
    var body: some View {
        ZStack{
            
            Image("VitoriaBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    audioPlayer.playEffect(effect: "goal-scream", type: "mp3", volume: 3.5)
                }
            
            Button {
                audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    navigantionLinkAtivoJogar = true}
                botaoAtivado = false
            } label: {
                Image("menuBotaoAzul")
            }.padding(.top, 550)
                .disabled(!botaoAtivado)
            
            NavigationLink("",destination: MenuView(),isActive: $navigantionLinkAtivoJogar)
            
        }.navigationBarBackButtonHidden(true)
    }
}


