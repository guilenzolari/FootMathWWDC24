//
//  SwiftUIView.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 14/11/23.
//

import SwiftUI

struct ChutesView: View {
    
    var gameController:GameController

    
    init(gameController:GameController ){
        self.gameController = gameController
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Text("\(gameController.palpites[0])")
                Spacer()
                Text("\(gameController.palpites[1])")
                Spacer()
                Text("\(gameController.palpites[2])")
                Spacer()
            }.padding(.bottom, 50)
            
            HStack{
                Spacer()
                Text("\(gameController.palpites[3])")
                Spacer()
                Text("\(gameController.palpites[4])")
                Spacer()
                Text("\(gameController.palpites[5])")
                Spacer()
            }
            
        }.font(Font.custom("8-bit Arcade In", size: 100))
            .foregroundColor(.black)
    }
}

#Preview {
    ChutesView(gameController: GameController())
}
