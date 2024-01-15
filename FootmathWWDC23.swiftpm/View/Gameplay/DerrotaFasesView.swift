//
//  SwiftUIView.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 09/01/24.
//

import SwiftUI

struct DerrotaFasesView: View {
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

