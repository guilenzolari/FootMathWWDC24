//
//  SwiftUIView.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 14/11/23.
//

import SwiftUI

struct ChutesView: View {
    
    var chutes = ChutesController()
    var palpites: [Int]
    var gameController = GameController()
    
    init(){
        self.palpites = [
            chutes.possibilidadeAleatoria(),
            chutes.possibilidadeAleatoria(),
            chutes.possibilidadeAleatoria(),
            chutes.possibilidadeAleatoria(),
            chutes.possibilidadeAleatoria(),
            chutes.possibilidadeAleatoria()
        ]
        
        let posicaoCorreta = chutes.posicaoCorreta()
        let contasMaisResultado = Int(gameController.contasMais().last!)!
        self.palpites[chutes.posicaoCorreta()] = contasMaisResultado
    }
    

    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Text("\(palpites[0])")
                Spacer()
                Text("\(palpites[1])")
                Spacer()
                Text("\(palpites[2])")
                Spacer()
            }.padding(.bottom, 50)
            
            HStack{
                Spacer()
                Text("\(palpites[3])")
                Spacer()
                Text("\(palpites[4])")
                Spacer()
                Text("\(palpites[5])")
                Spacer()
            }
            
        }.font(Font.custom("8-bit Arcade In", size: 100))
            .foregroundColor(.black)
    }
}

#Preview {
    ChutesView()
}
