//
//  Red Victory.swift
//  Footmath
//
//  Created by Guilherme Ferreira Lenzolari on 07/04/23.
//

import Foundation
import SwiftUI



struct RedVictory: View {

    var body: some View{
        ZStack{
            
            EmptyArray()
            
            Image("Red Victory")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            
            ZStack{
                NavigationLink{
                                Menu()
                            } label: {
                                Image("quit")
                            }
            }.padding(.top, 950)

            ZStack{
                NavigationLink{
                                Gameplay()
                            } label: {
                                Image("play")
                                    
                            }
            }.padding(.top, 650)

            
            VStack{
                Text(victory)
                    .font(Font.custom("8-bit Arcade In", size:80))
                    .foregroundColor(colorYellow)
                    .font(.system(size: 40))
                    .padding(.top, 77)
                    .padding(.horizontal, 48)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}
