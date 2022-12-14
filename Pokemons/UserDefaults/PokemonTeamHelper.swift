//
//  PokemonTeamHelper.swift
//  Pokemons
//
//  Created by Поляндий on 04.12.2022.
//

import Foundation

public enum PokemonTeamAdditionStatus {
    case success, failed, alreadyAdded, teamIsFull
}

public class PokemonTeamHelper {
    let key = "POKEMON_TEAM_POKEDEX"
    
    public func getTeamFromLocalCache() -> [PokemonTeam] {
        if let cachedPokemons = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([PokemonTeam].self, from: cachedPokemons)
                
                return pokemons
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        
        return []
    }
    
    public func deletePokemonFromList(pokemonName: String, currentTeam: [PokemonTeam]) -> [PokemonTeam] {
        var position = 0
        
        for pokemon in currentTeam {
            if(pokemon.name == pokemonName) {
                break
            }
            position += 1
        }
        
        if(position >= currentTeam.count) { return [] }

        var updatedTeam = currentTeam
        updatedTeam.remove(at: position)
        
        updatePokemonList(pokemonList: updatedTeam)
        
        return updatedTeam
    }
    
    private func updatePokemonList(pokemonList: [PokemonTeam]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pokemonList)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Unable to Encode Array of Pokemon (\(error))")
        }
    }
    
    public func addPokemonToList(pokemonName: String, pokemonImage: String) -> PokemonTeamAdditionStatus {
        var pokes = getTeamFromLocalCache()
        
        if(isPokemonAlreadyAdded(name: pokemonName, pokemonTeam: pokes)) {
            return PokemonTeamAdditionStatus.alreadyAdded
        }
        
        if(pokes.count >= 6){
            return PokemonTeamAdditionStatus.teamIsFull
        }
        
        do {
            pokes.append(PokemonTeam(name: pokemonName, imageUrl: pokemonImage))
            let encoder = JSONEncoder()
            let data = try encoder.encode(pokes)
            UserDefaults.standard.set(data, forKey: key)
            return PokemonTeamAdditionStatus.success
        } catch {
            print("Unable to Encode Array of Pokemon (\(error))")
            return PokemonTeamAdditionStatus.failed
        }
    }
    
    private func isPokemonAlreadyAdded(name: String, pokemonTeam: [PokemonTeam]) -> Bool {
        var alreadyAdded = false
        
        for pokemon in pokemonTeam {
            if(pokemon.name == name) { return true }
        }
        
        return alreadyAdded
    }
}
