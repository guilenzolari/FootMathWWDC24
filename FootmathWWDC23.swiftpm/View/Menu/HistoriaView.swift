//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 15/09/23.
//

import Foundation
import SwiftUI

struct HistoriaView: View {
    
    @State var navigantionLinkAtivo = false
    @EnvironmentObject var audioPlayer:AudioPlayer

    @StateObject var historia = HistoriaViewModel()
    
    var body: some View{
        
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image(historia.background[historia.etapaAtual])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    audioPlayer.playEffect(effect: historia.sounds[historia.etapaAtual], type: "mp3", volume: 1.0)
                }
            
            VStack{
                
                Button {
                    navigantionLinkAtivo = !historia.avancar()
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 1.0)
                    audioPlayer.playEffect(effect: historia.sounds[historia.etapaAtual], type: "mp3", volume: 1.0)
                } label: {
                    Image(historia.button[historia.etapaAtual])
                        .padding(.top, 600)
                }
            }
            
            NavigationLink("",destination: PlanetasView() ,isActive: $navigantionLinkAtivo)
            
        }.navigationBarBackButtonHidden(true)

    }
}
