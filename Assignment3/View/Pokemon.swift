//
//  Pokemon.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import SwiftUI

struct Pokemon: View {
    
    @ObservedObject var pokemonvm = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(pokemonvm.pokemonData, id: \.name) { pokemon in
                    NavigationLink {
                        PokemonInfo(name: pokemon.name, url: pokemon.url)
                    } label: {
                        Text(pokemon.name.capitalized)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("First Gen Pokemon")
            .alert(isPresented: $pokemonvm.hasError, error: pokemonvm.error, actions: {
                Text("")
            })
        }
        .task {
            await pokemonvm.fetchData()
        }
    }
}

struct Pokemon_Previews: PreviewProvider {
    static var previews: some View {
        Pokemon()
    }
}
