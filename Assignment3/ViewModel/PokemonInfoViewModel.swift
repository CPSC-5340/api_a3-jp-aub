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
    @Published var hasError = false
    @Published var error : PokemonInfoViewError?
    
    @MainActor
    func fetchData(input: String) async {
        if let apiUrl = URL(string: input) {
            do {
                let (data, _) = try await URLSession.shared.data(from: apiUrl)
                guard let results = try JSONDecoder().decode(GenResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = PokemonInfoViewError.decodeErr
                    return
                }
                self.pokemonIdentify = results.id
                
                // Using the ID from the first API call, call the endpoint containing that pokemon's list of moves:
                await self.fetchMoves()
                
            }
            catch {
                self.hasError.toggle()
                self.error = PokemonInfoViewError.customErr(error: error)
            }
        }
    }
    
    @MainActor
    func fetchMoves() async {
        let pID = String(self.pokemonIdentify)
        if let apiUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pID)/") {
            do {
                let (data, _) = try await URLSession.shared.data(from: apiUrl)
                guard let results = try JSONDecoder().decode(PokemonDetailsResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = PokemonInfoViewError.decodeErr
                    return
                }
                self.pokemonMoves = results.moves
            }
            catch {
                self.hasError.toggle()
                self.error = PokemonInfoViewError.customErr(error: error)
            }
            
        }
    }
}


extension PokemonInfoViewModel {
    enum PokemonInfoViewError : LocalizedError {
        case decodeErr
        case customErr(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeErr:
                return "There is a decoding error"
            case .customErr(let error):
                return error.localizedDescription
            }
        }
    }
}
