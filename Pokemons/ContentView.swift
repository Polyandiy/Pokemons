//
//  ContentView.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    @State private var searchedPokemon: String
    @State private var boxNumber: Int = 1
    @State private var showTeam: Bool = false
    
    var body: some View {
        VStack {
            headerBoxView
            tableView
            bottomView
        }
        .padding()
    }
}

@ViewBuilder
private var headerBoxView: some View {
    HStack {
        Image("ic_left_arrow")
            .topIconSizeStyle()
            .padding(.leading, 2)
            .onTapGesture {
                if(viewModel.getFromIndex() >= pageNumber){
                    viewModel.getPokemonsFromAPI(from: viewModel.getFromIndex() - pageNumber)
                    boxNumber -= 1
                }
            }
        
        Text("BOX " + boxNumber.description)
            .withCustomFont(size: 34)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Rectangle().fill(Color.white).cornerRadius(4))
            .shadow(radius: 1)
        
        Image("ic_right_arrow")
            .topIconSizeStyle()
            .padding(.trailing, 2)
            .onTapGesture {
                viewModel.getPokemonsFromAPI(from: viewModel.getFromIndex() + pageNumber)
                boxNumber += 1
            }
    }
}

@ViewBuilder
private var tableView: some View {
    ScrollView {
        LazyVGrid(columns: [
            GridItem(.fixed(100)),
            GridItem(.fixed(100)),
            GridItem(.fixed(100))
        ], spacing: 5, content: {
            ForEach(viewModel.pokemonHomeList) { poke in
                NavigationLink {
                    DetailView(pokemon: poke)
                        .onAppear(){
                            viewModel.activateSearchbar = false
                        }
                } label: {
                    VStack {
                        AsyncImage(url: URL(string: poke.sprites.other.officialArtwork.front_default), transaction: .init(animation: .spring(response: 1.6))) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(.circular)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Text("Failed fetching image. Make sure to check your data connection and try again.")
                                    .foregroundColor(.red)
                            @unknown default:
                                Text("Unknown error. Please try again.")
                                    .foregroundColor(.red)
                            }
                        }
                        .frame(height: 65)
                        .shadow(radius: 1)
                    }
                    .padding()
                    .overlay(
                        Text("#\(poke.pokemonId)  \(poke.name.capitalized)")
                            .withCustomFont(size: 20)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 2)
                        ,alignment: .bottom)
                    .background(Color(bgColorUtils.getPokemonTypeBackgroundColor(type: poke.types[0].type.name)))
                    .cornerRadius(12)
                    .shadow(radius: 1)
                    .padding(5)
                }
            }
        })
    }
}

@ViewBuilder
private var bottomView: some View {
    HStack {
        Image("ic_search").bottomIconSizeStyle().padding(.leading, 20).foregroundColor(.white)
            .onTapGesture {
                viewModel.activateSearchbar = !viewModel.activateSearchbar
            }
        
        Image("ic_team").bottomIconSizeStyle().padding(.leading, 10).foregroundColor(.white)
            .onTapGesture {
                showTeam = !showTeam
            }
        
        Spacer()

        if(!searchedPokemon.isEmpty){
            Text("Clear filter")
                .foregroundColor(.white)
                .padding(.trailing, 20)
                .onTapGesture {
                    searchedPokemon = ""
                    boxNumber = 1
                    viewModel.getPokemonsFromAPI(from: 0)
                }
        }
    }.padding(.bottom, 20)
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
