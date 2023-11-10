import Foundation
import SwiftUI


struct Tutorial: View {
    
    @State var navigantionLinkAtivo = false
    @ObservedObject var tutorial = TutorialController()
    
    var body: some View {
        
        ZStack{
            Image(tutorial.infos[tutorial.etapaAtual].background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            Button {
                navigantionLinkAtivo = !tutorial.avancar()
                print(tutorial.etapaAtual)
            } label: {
                Image(tutorial.infos[tutorial.etapaAtual].imagem)
                    .padding(.top, 880)
            }

            VStack{
                Text(tutorial.infos[tutorial.etapaAtual].texto)
                    .font(Font.custom("8-bit Arcade In", size:80))
                    .foregroundColor(colorYellow)
                    .font(.system(size: 40))
                    .padding(.top, 750)
                    .padding(.horizontal, 48)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
            }
            
//            NavigationLink("",destination: Gameplay(),isActive: $navigantionLinkAtivo)

            
        }.navigationBarBackButtonHidden(true)

    }
}

