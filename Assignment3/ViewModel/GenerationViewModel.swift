//
//  GenerationViewModel.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import Foundation

class GenerationViewModel : ObservableObject {
    
    @Published private(set) var pokemonGen = Int()
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
                                self.pokemonGen = results.id
                                
                                
                                // Second API Call
                                let pID = String(self.pokemonGen)
                                print(pID)
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
                                
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
        }
    }
}
