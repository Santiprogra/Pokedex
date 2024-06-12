//
//  ViewController.swift
//  Pokedex
//
//  Created by Santiago Briñez on 11/06/24.
//

import UIKit

class ListaPokemonViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tablaPokemon: UITableView!
    
    @IBOutlet weak var searchBarPokemon: UISearchBar!

    var listaPokemonViewModel = ListaPokemonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //Registrar la nueva celda
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")

        searchBarPokemon.delegate = self

        tablaPokemon.delegate =  self
        tablaPokemon.dataSource = self

        listaPokemonViewModel.fetchPokemons()

        listaPokemonViewModel.delegado = self

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon" {
            let verPokemon = segue.destination as! DetallePokemonViewController
            verPokemon.pokemonMostrar = listaPokemonViewModel.obtenerPokemonSeleccionado()
        }
    }
}


// MARK: - searchBar
extension ListaPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        listaPokemonViewModel.searchBar(textDidChange: searchText)

        self.tablaPokemon.reloadData()
    }
}

extension ListaPokemonViewController: ListaPokemonViewModelDelegate {
    func mostrarPokemones() {
        self.tablaPokemon.reloadData()
    }
}

// MARK: - Tabla
extension ListaPokemonViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaPokemonViewModel.listaPokemones().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as? CeldaPokemonTableViewCell else {
            return UITableViewCell()
        }

        let listaPokemones = listaPokemonViewModel.listaPokemones()

        celda.nombrePokemon.text = listaPokemones[indexPath.row].name
        celda.ataquePokemon.text = "Ataque: \(listaPokemones[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(listaPokemones[indexPath.row].defense)"

        //Celda imagen desde URL
        let urlString = listaPokemones[indexPath.row].imageUrl
            if let imageURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imageURL) else { return }
                    let  image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPokemon.image = image
                    }
                }
            }

        return celda
    }
}

extension ListaPokemonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listaPokemonViewModel.seleccionarPokemon(int: indexPath.row)
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
        //Deseleccionamos la Celda
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
}         
