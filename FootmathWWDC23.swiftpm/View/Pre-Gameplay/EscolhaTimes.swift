//
//  File.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 06/04/23.
//

import Foundation
import SwiftUI

//Storyboard 4 --> Choose your team
struct EscolhaTimes: View {
    
    @State var isActive = false
    
    
    var body: some View{
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)

            Image("Storyboard 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            
            Rectangle()
                .onTapGesture{
//                    gameController.teamChoice = "blue"
                    isActive = true
                    print("blue")
                }
                .foregroundColor(.black).opacity(0.1)
                .frame(width: 350, height: 150)
                .foregroundColor(.blue)
                .padding(.top, 880).padding(.leading, 370)
                
            
            
            Rectangle()
                .onTapGesture{
//                    gameController.teamChoice = "red"
                    isActive = true
                    print("red")
                }
                .foregroundColor(.black).opacity(0.1)
                .frame(width: 350, height: 150)
                .foregroundColor(.blue)
                .padding(.top, 880).padding(.trailing, 370)
            
        }.navigationBarBackButtonHidden(true)
        
        NavigationLink("",destination: Tutorial(), isActive: $isActive)

    }

}


