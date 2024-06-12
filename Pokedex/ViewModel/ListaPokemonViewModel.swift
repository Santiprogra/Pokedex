//
//  ListaPokemonViewModel.swift
//  Pokedex
//
//  Created by Santiago Briñez on 12/06/24.
//

import Foundation

protocol ListaPokemonViewModelDelegate {
    func mostrarPokemones()
}

class ListaPokemonViewModel {
    // MARK: - Variables
    private var pokemonManager = PokemonManager()

    private var pokemons: [Pokemon] = []

    private var pokemonSeleccionado: Pokemon?

    private var pokemonFiltrados : [Pokemon] = []

    var delegado: ListaPokemonViewModelDelegate?

    init() {
        pokemonManager.delegado = self
    }

    //Ejecutar el metodo para buscar la lista de pokemon
    func fetchPokemons() {

        pokemonManager.verPokemon()

    }

    func searchBar(textDidChange searchText: String) {

        pokemonFiltrados = []

        if searchText == "" {
            pokemonFiltrados = pokemons
        } else {
            for poke in pokemons {
                if  poke.name.lowercased().contains(searchText.lowercased()) {
                    pokemonFiltrados.append(poke)
                }
            }
        }
    }

    func listaPokemones() -> [Pokemon] {
        return pokemonFiltrados
    }

    func seleccionarPokemon(int: Int) {
        pokemonSeleccionado = pokemonFiltrados[int]
    }

    func obtenerPokemonSeleccionado() -> Pokemon? {
        return pokemonSeleccionado
    }
}

extension ListaPokemonViewModel : PokemonManagerDelegado {

    func mostrarListaPokemon(lista: [Pokemon]) {

        pokemons = lista

        DispatchQueue.main.async {
            self.pokemonFiltrados = self.pokemons
            self.delegado?.mostrarPokemones()
        }
    }
}
