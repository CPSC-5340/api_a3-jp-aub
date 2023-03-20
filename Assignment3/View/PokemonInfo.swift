//
//  PokemonDetail.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import SwiftUI

struct PokemonInfo: View {
    
    @ObservedObject var gen = PokemonInfoViewModel()

    var name : String
    var url : String
    
    var body: some View {
        VStack {
            Text(name)
            Text(url)
            Text(String(gen.pokemonIdentify))
            
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
        PokemonInfo(name: "Default", url: "URL")
    }
}
