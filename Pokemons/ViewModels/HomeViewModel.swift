//
//  HomeViewModel.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation
import RxSwift

public class HomeViewModel: ObservableObject {
    
    @Published var pokemonHomeList: [PokemonDetailResponse] = []
    @Published var activateSearchbar: Bool = false
    @Published var showNotFoundMessage: Bool = false
    
    private var from: Int = 0
    private var repository = PokemonNetwork()
    
    private var pokemons: Observable<[PokemonResponse]>?
    private var pokeDetail: Observable<PokemonDetailResponse>?
    private let disposeBag = DisposeBag()
    
    func getFromIndex() -> Int {
        return from
    }
    
    func getPokemonsFromAPI(from: Int){
        self.showNotFoundMessage = false
        self.pokemonHomeList.removeAll()
        self.from = from
        
        pokemons = repository.getPokemonList(from: from)
        pokemonsSubscriber()
    }
    
    private func pokemonsSubscriber(){
        pokemons?.subscribe(onNext: { [weak self] (list) in
            for i in 0...(list.count-1) {
                if(i == -1) { return }
                self?.addPokemonDetailToList(list: list, i: i)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func addPokemonDetailToList(list: [PokemonResponse], i: Int) {
        pokeDetail = repository.getPokemonDetailByUrl(url: list[i].url)
        pokemonDetailSubscriber(url: list[i].url, itemsNumber: list.count, pokeDetail: pokeDetail)
    }
    
    private func pokemonDetailSubscriber(url: String, itemsNumber: Int, pokeDetail: Observable<PokemonDetailResponse>?){
        pokeDetail?.subscribe(onNext: { [weak self] (detail) in
            self?.pokemonHomeList.append(detail)
            self?.repository.getPokemonDetailByUrl(url: url)
            
            if(self?.pokemonHomeList.count == itemsNumber){
                self?.pokemonHomeList.sort(by: { $0.order < $1.order })
            }
        })
        .disposed(by: disposeBag)
    }
    
    func getPokemonDetailByName(name: String) {
        repository.getPokemonDetailByName(name: name, completionHandler: { pokemonDetail, error in
            self.pokemonHomeList.removeAll()
            
            if(pokemonDetail == nil) {
                DispatchQueue.main.async{
                    self.showNotFoundMessage = true
                    self.activateSearchbar = false
                }
                return
            }
            
            self.showNotFoundMessage = false
            self.pokemonHomeList.append(pokemonDetail!)
            self.activateSearchbar = false
        })
    }

}
