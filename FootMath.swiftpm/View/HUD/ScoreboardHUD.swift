//
//  SwiftUIView.swift
//
//
//  Created by Guilherme Ferreira Lenzolari on 16/02/24.
//

import SwiftUI

struct ScoreboardHUD: View {
    @Binding var resultados: [ResultadoJogada]
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: 160, height: 40)
                .foregroundStyle(.ultraThinMaterial)
            
            HStack(spacing: 12){
                ForEach(resultados.indices, id: \.self) {index in
                    let resultado = resultados[index]
                    let id = "result_\(index)"
                    
                    switch resultado {
                    case ResultadoJogada.acertou:
                        Image("GreenSignal").id(id)
                    case ResultadoJogada.errou:
                        Image("RedSignal").id(id)
                    case ResultadoJogada.vazio:
                        Image("GraySignal").id(id)
                    }
                }
            }
        }
    }
}

