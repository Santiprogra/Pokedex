//
//  DatosPokemon.swift
//  Pokedex
//
//  Created by Santiago Briñez on 11/06/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}
