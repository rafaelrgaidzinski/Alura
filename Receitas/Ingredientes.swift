//
//  Ingredientes.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import Foundation

class Ingredientes : Equatable{
    let nome: String
    let calorias: Double
    
    init(nome: String, calorias: Double){
        self.nome = nome
        self.calorias = calorias
    }
}

func ==(primeiro: Ingredientes, segundo: Ingredientes) -> Bool {
    return primeiro.nome == segundo.nome && primeiro.calorias == segundo.calorias
}