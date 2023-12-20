//
//  SwiftUIView.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 14/11/23.
//

import SwiftUI

struct ChutesView: View {
    
    var gameController:GameController
    
    let linhas = [
        GridItem(.fixed(3), spacing: 122),
        GridItem(.fixed(3)),
    ]

    init(gameController:GameController ){
        self.gameController = gameController
    }
        
    var body: some View {
        VStack{
            LazyHGrid(rows: linhas, spacing: 117,content: {
                ForEach(0..<gameController.palpites.count, id: \.self) { index in
                    Text("\(gameController.palpites[index])")
                        .onTapGesture {
                            if(index == gameController.palpiteCorreto){
                                let novoResultado = ResultadoJogada.acertou
                                gameController.adicionarResultado(novoResultado)
                            } else{
                                let novoResultado = ResultadoJogada.errou
                                gameController.adicionarResultado(novoResultado)
                            }
                        }
                }
            })
        }
        .font(Font.custom("8-bit Arcade In", size: 100))
        .foregroundColor(.black)
    }
}

#Preview {
    ChutesView(gameController: GameController())
}
