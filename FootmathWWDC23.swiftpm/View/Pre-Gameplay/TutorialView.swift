import Foundation
import SwiftUI


struct TutorialView: View {
    
    @State var navigantionLinkAtivo = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    @StateObject var tutorial = TutorialController()
    
    var body: some View {
        
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image(tutorial.infos[tutorial.etapaAtual].background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            Button {
                navigantionLinkAtivo = !tutorial.avancar()
                audioPlayer.playEffect(effect: "click-botao", type: "mp3")
            } label: {
                Image(tutorial.infos[tutorial.etapaAtual].imagem)
                .scaleEffect(0.7)
            }.padding(.top, 880)


            VStack{
                Text(tutorial.infos[tutorial.etapaAtual].texto)
                    .font(Font.custom("8-bit Arcade In", size: 70))
                    .foregroundColor(.yellow)
                    .font(.system(size: 40))
                    .padding(.top, 750)
                    .padding(.horizontal, 48)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            
            NavigationLink("",destination: GameplayView(),isActive: $navigantionLinkAtivo)

            
        }.navigationBarBackButtonHidden(true)

    }
}

