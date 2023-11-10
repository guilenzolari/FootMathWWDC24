import SwiftUI

struct Menu: View {
    @State private var pontoAtual = 0
    @State var navigantionLinkAtivoJogar = false
    @State var navigantionLinkAtivoOpcoes = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    
    var body: some View {
        ZStack {
            Image("BackMenu")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            Image("ball")
            
            VStack{
                Button {
                    navigantionLinkAtivoJogar = true
                    audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                } label: {
                    Image("jogar")
                        .scaleEffect(0.7)
                }
            
                Button {
                    navigantionLinkAtivoOpcoes = true
                    audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                } label: {
                    Image("opcoes")
                        .scaleEffect(0.7)
                }.padding(.top, -20)
                
                Button {
                    audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                    exit(0)
                } label: {
                    Image("sair")
                        .scaleEffect(0.7)
                }.padding(.top, -20)
                
            }.padding(.top, 650)
            

            
            NavigationLink("",destination: Historia(),isActive: $navigantionLinkAtivoJogar)
            NavigationLink("",destination: OpcoesView(),isActive: $navigantionLinkAtivoOpcoes)

            
        }.navigationBarBackButtonHidden(true)
    }
}





