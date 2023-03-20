//
//  PokemonDetailModel.swift
//  Assignment3
//
//  Created by JP on 3/20/23.
//

import Foundation

struct PokemonDetailsResults : Decodable {
    let id : Int
    let name : String
    let moves : [PokemonMovesModel]
}

struct PokemonMovesModel : Decodable {
    let move : PokemonMoveDetail
}

struct PokemonMoveDetail : Decodable {
    let name : String
}
