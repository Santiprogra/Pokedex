//
//  DetallePokemonViewController.swift
//  Pokedex
//
//  Created by Santiago Briñez on 11/06/24.
//

import UIKit

class DetallePokemonViewController: UIViewController {

    // MARK: - Variables
    var pokemonMostrar: Pokemon?

    // MARK: - IBOutlets

    @IBOutlet weak var imagenPokemon: UIImageView!

    @IBOutlet weak var descripcionPokemon: UITextView!

    @IBOutlet weak var tipoPokemon: UILabel!

    @IBOutlet weak var ataquePokemon: UILabel!

    @IBOutlet weak var defensaPokemon: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //Imagen a mostrar

        imagenPokemon.loadFrom(URLAddress: pokemonMostrar?.imageUrl ?? "")

        tipoPokemon.text = "Tipo : \(pokemonMostrar?.type ?? "")"
        ataquePokemon.text = "Ataque \(pokemonMostrar!.attack)"
        defensaPokemon.text = "Defensa \(pokemonMostrar!.defense)"
        descripcionPokemon.text = pokemonMostrar?.description ?? ""
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imagenData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
