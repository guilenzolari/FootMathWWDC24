//
//  OpcoesView.swift
//  Footmath
//
//  Created by Guilherme Ferreira Lenzolari on 24/10/23.
//

import SwiftUI

struct OpcoesView: View {

    @EnvironmentObject var audioPlayer:AudioPlayer
    @State private var isEditing = false
    @State var volume = 0.0
    
    var body: some View {
        ZStack{
            
            Image("BackMenu")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .blur(radius: 10.0)
            
            
            
            Rectangle()
                .background(Color.black)
                .cornerRadius(50)
                .opacity(0.7)
                .padding(.horizontal, 100)
                .padding(.vertical, 300)

        
            
            VStack(spacing: 80){
                
                HStack(spacing: 40){
                    Text("Efeitos")
                    Slider(value: $audioPlayer.effectsVolume, in: 0...2)
                }
                
                
                HStack(spacing: 40){
                    Text("Música")
                    Slider(value: $audioPlayer.musicVolume, in: 0...2)
                }
                
            }.foregroundColor(.white)
            .accentColor(.yellow)
            .frame(width: 300, height: 50)
            .font(.title)
            
        }
    }
}

#Preview {
    OpcoesView()
}
