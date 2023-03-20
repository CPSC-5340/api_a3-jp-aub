//
//  PokemonDetail.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import SwiftUI

struct PokemonDetail: View {
    
    @ObservedObject var gen = GenerationViewModel()

    var name : String
    var url : String
    
    var body: some View {
        VStack {
            Text(name)
            Text(url)
            Text(String(gen.pokemonGen))
            
            List {
                ForEach(gen.pokemonMoves, id: \.move.name) { move in
                    Text(move.move.name)
                }
            }
        }
        .onAppear {
            gen.fetchData(input: url)
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(name: "Default", url: "URL")
    }
}
