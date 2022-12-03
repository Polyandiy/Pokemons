//
//  DetailviewModel.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation
import RxSwift

public class DetailViewModel: ObservableObject  {
    @Published var description = ""
    @Published var moves:[MoveModel] = []
    
    private var repository = PokemonNetwork()
    private var textUtils: TextUtils = TextUtils()
    private var pokemonMoves: Observable<PokemonMoveResponse>?
    private let disposeBag = DisposeBag()
    
    func getPokemonDescriptionFromAPI(endpoint: String) {
        repository.getPokemonDescription(endpoint: endpoint, completionHandler: { pokemonSpecieResponse, error in
            if let pokemonSpecieResponse = pokemonSpecieResponse {
                self.description = self.textUtils.removeBlankSpacesFromText(description: pokemonSpecieResponse.flavor_text_entries[0].flavor_text)
            }
        })
    }
    
    func getPokemonMoveFromApi(url: String, name: String) {
        pokemonMoves = repository.getPokemonMoveDetailByUrl(url: url)
        pokemonMovesSubscriber(name: name)
    }
    
    private func pokemonMovesSubscriber(name: String) {
        pokemonMoves?.subscribe(onNext: { [weak self] (move) in
            var moveDescription = ""
            if(!move.effectEntries.isEmpty) {
                moveDescription = move.effectEntries[0].shortEffect
            }
            self?.moves.append(MoveModel(name: name, type: move.type.name, accuracy: move.accuracy ?? 0, power: move.power ?? 0, description: moveDescription))
        })
        .disposed(by: disposeBag)
    }
}
