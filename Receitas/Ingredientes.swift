//
//  Ingredientes.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import Foundation

class Ingredientes : NSObject, NSCoding {
    let nome: String
    let calorias: Double
    
    init(nome: String, calorias: Double){
        self.nome = nome
        self.calorias = calorias
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.nome = aDecoder.decodeObjectForKey("nome") as! String
        self.calorias = aDecoder.decodeDoubleForKey("calorias")
    }
        
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(nome, forKey: "nome")
        aCoder.encodeDouble(calorias, forKey: "calorias")
    }
        
}

func ==(primeiro: Ingredientes, segundo: Ingredientes) -> Bool {
    return primeiro.nome == segundo.nome && primeiro.calorias == segundo.calorias
}
