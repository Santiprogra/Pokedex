//
//  CeldaPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Santiago Briñez on 11/06/24.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenPokemon: UIImageView!
    
    @IBOutlet weak var nombrePokemon: UILabel!
    
    @IBOutlet weak var ataquePokemon: UILabel!

    @IBOutlet weak var defensaPokemon: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        imagenPokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
