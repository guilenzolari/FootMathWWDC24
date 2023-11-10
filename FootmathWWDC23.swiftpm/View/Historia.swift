//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 15/09/23.
//

import Foundation
import SwiftUI

struct Historia: View {
    
    @State var navigantionLinkAtivo = false
    @EnvironmentObject var audioPlayer:AudioPlayer

    @StateObject var historia = HistoriaModel()
    
    var body: some View{
        
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image(historia.background[historia.etapaAtual])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            
            VStack{
                Text(historia.texto[historia.etapaAtual])
                    .foregroundColor(.yellow)
                    .padding(.horizontal, 15)
                    .padding(.top, -350)
                    .font(Font.custom("8-bit Arcade In", size: 70))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black, radius: 1)
                
                Button {
                    navigantionLinkAtivo = !historia.avancar()
                    audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                } label: {
                    Image("next button")
                        .padding(.bottom, 100)
                }
            }
            
            NavigationLink("",destination: EscolhaTimes(),isActive: $navigantionLinkAtivo)
            
        }.navigationBarBackButtonHidden(true)

    }
}
