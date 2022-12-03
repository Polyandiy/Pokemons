//
//  NetworkProtocol.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation
import RxSwift

protocol Network {
    func getPokemonList(from: Int) -> Observable<[PokemonResponse]>
    func getPokemonDetailByUrl(url: String) -> Observable<PokemonDetailResponse>
    func getPokemonDescription(endpoint: String, completionHandler: @escaping (PokemonSpecieResponse?, Error?) -> Void)
    func getPokemonDetailByName(name: String, completionHandler: @escaping (PokemonDetailResponse?, Error?) -> Void)
}
