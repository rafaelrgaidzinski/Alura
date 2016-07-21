//
//  Receita.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import Foundation

class Receita{
    let nome: String
    let nota: Int
    var items = Array<Ingredientes>()
    
    init(nome: String, nota: Int){
        self.nome = nome
        self.nota = nota
    }
    
    func totalCalorias(){
        var total = 0.0
        for item in items{
            total += item.calorias
        }
    }
}