import SwiftUI

//TO DO
//Bola viajando
//Musica da tela inicial
//Som de apito ao clicar em play

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

            
            VStack{
                Button {
                    navigantionLinkAtivoJogar = true
                    audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                } label: {
                    Image("jogar")
                }
            
//                Button {
//                    navigantionLinkAtivoOpcoes = true
//                    audioPlayer.playEffect(effect: "click-botao", type: "mp3")
//                } label: {
//                    Image("opcoes")
//                        .scaleEffect(0.7)
//                }
            }.padding(.top, 550)
            
            NavigationLink("",destination: GameplayView(),isActive: $navigantionLinkAtivoJogar)
            NavigationLink("",destination: OpcoesView(),isActive: $navigantionLinkAtivoOpcoes)

        }.navigationBarBackButtonHidden(true)
    }
}





