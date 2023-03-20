//
//  PokemonModel.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import Foundation

struct PokemonResults : Decodable {
    let id : Int
    let name : String
    let pokemon_species : [PokemonModel]
}

struct PokemonModel : Decodable  {
    let name : String
    let url : String
}
