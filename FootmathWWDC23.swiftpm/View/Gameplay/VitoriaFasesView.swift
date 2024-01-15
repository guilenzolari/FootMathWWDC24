import SwiftUI

struct VitoriaFasesView: View {
    @State var botaoAtivado = true
    @State var navigantionLinkAtivoJogar = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    
    var body: some View {
        ZStack{
            Button {
                audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    navigantionLinkAtivoJogar = true}
                botaoAtivado = false
            } label: {
                Image("jogar")
            }.padding(.top, 550)
                .disabled(!botaoAtivado)
            
            NavigationLink("",destination: GameplayView(),isActive: $navigantionLinkAtivoJogar)
            
        }.navigationBarBackButtonHidden(true)
    }
}


