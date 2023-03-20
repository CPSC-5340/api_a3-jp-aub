//
//  GenerationViewModel.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import Foundation

class PokemonInfoViewModel : ObservableObject {
    
    @Published private(set) var pokemonIdentify = Int()
    @Published private(set) var pokemonMoves = [PokemonMovesModel]()
    
    func fetchData(input: String) {
        if let apiUrl = URL(string: input) {
            URLSession
                .shared
                .dataTask(with: apiUrl) { data, response, error in
                    if let error = error {
                        print(error)
                    } else {
                        if let data = data {
                            do {
                                let results = try JSONDecoder().decode(GenResults.self, from: data)
                                self.pokemonIdentify = results.id
                                
                                // Using the ID from the first API call, call the endpoint containing
                                // that pokemon's list of moves:
                                self.fetchMoves()
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
        }
    }
    
    func fetchMoves() {
        let pID = String(self.pokemonIdentify)
        if let apiUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pID)/") {
            URLSession
                .shared
                .dataTask(with: apiUrl) { data, response, error in
                    if let error = error {
                        print(error)
                    } else {
                        if let data = data {
                            do {
                                let results = try JSONDecoder().decode(PokemonDetailsResults.self, from: data)
                                self.pokemonMoves = results.moves
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
        }
    }
}
