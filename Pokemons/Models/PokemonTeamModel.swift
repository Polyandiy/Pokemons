//
//  PokemonTeamModel.swift
//  Pokemons
//
//  Created by Поляндий on 04.12.2022.
//

import Foundation

public struct PokemonTeam: Identifiable, Codable {
    public var id = UUID()
    var name: String
    var imageUrl: String
}
