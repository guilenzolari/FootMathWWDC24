//
//  File.swift
//
//
//  Created by Guilherme Ferreira Lenzolari on 15/09/23.
//

import Foundation
import SwiftUI

struct EscolhaTimesView: View {
    
    @State var navigantionLinkAtivo = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    @StateObject var historia = HistoriaController()
    var gameController = GameController()
    
    var body: some View{
        
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image(historia.background[3])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            
            VStack{
                Text(historia.texto[3])
                    .foregroundColor(historia.cores[3])
                    .padding(.horizontal, 8)
                    .padding(.top, -350)
                    .font(Font.custom("8-bit Arcade In", size: 70))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
                
                HStack{
                    Button {
                        navigantionLinkAtivo = true
                        audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                        gameController.escolhaTime = EscolhaTime.vermelho
                    } label: {
                        Image("red button")
                            .scaleEffect(0.7)}
                    
                    Spacer()
                    
                    Button {
                        navigantionLinkAtivo = true
                        audioPlayer.playEffect(effect: "click-botao", type: "mp3")
                        gameController.escolhaTime = EscolhaTime.azul

                    } label: {
                        Image("blue button")
                            .scaleEffect(0.7)}
                
            }.padding(.bottom, 100)}
            .padding(.horizontal, 60)

            
            NavigationLink("",destination:TutorialView() ,isActive: $navigantionLinkAtivo)
            
        }.navigationBarBackButtonHidden(true)

    }
}

