//
//  MoveModel.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation

public struct MoveModel: Identifiable {
    public var id = UUID()
    var name: String
    var type: String
    var accuracy: Int
    var power: Int
    var description: String
}
