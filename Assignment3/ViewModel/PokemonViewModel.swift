//
//  PokemonViewModel.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import Foundation

class PokemonViewModel : ObservableObject {
    
    @Published private(set) var pokemonData = [PokemonModel]()
    
    private let apiUrl = "https://pokeapi.co/api/v2/generation/1/"
    
    func fetchData() {
        if let apiUrl = URL(string: apiUrl) {
            URLSession
                .shared
                .dataTask(with: apiUrl) { data, response, error in
                    if let error = error {
                        print(error)
                    } else {
                        if let data = data {
                            do {
                                let results = try JSONDecoder().decode(PokemonResults.self, from: data)
                                self.pokemonData = results.pokemon_species
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
        }
    }
}
