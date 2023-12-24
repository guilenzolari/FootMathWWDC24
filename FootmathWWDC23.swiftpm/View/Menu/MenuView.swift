import SwiftUI

//TO DO
//Bola viajando
//Musica da tela inicial
//Som de apito ao clicar em play

struct Menu: View {
    @State private var pontoAtual = 0
    @State var navigantionLinkAtivoJogar = false
    @State var botaoAtivado = true
    @EnvironmentObject var audioPlayer:AudioPlayer
    
    var body: some View {
        ZStack {
            Image("BackMenu")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    audioPlayer.playMusic(sound: "latin-music", type: "mp3", volume: 0.1)
                }

            VStack{
                Button {
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        navigantionLinkAtivoJogar = true}
                    botaoAtivado = false
                } label: {
                    Image("jogar")
                }
            }.padding(.top, 550)
            .disabled(!botaoAtivado)
            
            NavigationLink("",destination: GameplayView(),isActive: $navigantionLinkAtivoJogar)

        }.navigationBarBackButtonHidden(true)
    }
}





