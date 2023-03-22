//
//  PokemonViewModel.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import Foundation

class PokemonViewModel : ObservableObject {
    
    @Published private(set) var pokemonData = [PokemonModel]()
    @Published var hasError = false
    @Published var error : PokemonViewError?
    
    private let apiUrl = "https://pokeapi.co/api/v2/generation/1/"
    
    @MainActor
    func fetchData() async {
        if let apiUrl = URL(string: apiUrl) {
            do {
                let (data, _) = try await URLSession.shared.data(from: apiUrl)
                guard let results = try JSONDecoder().decode(PokemonResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = PokemonViewError.decodeErr
                    return
                }
                self.pokemonData = results.pokemon_species
            }
            catch {
                self.hasError.toggle()
                self.error = PokemonViewError.customErr(error: error)
            }
        }
    }
}

extension PokemonViewModel {
    enum PokemonViewError : LocalizedError {
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
