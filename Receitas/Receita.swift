//
//  Receita.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import Foundation

class Receita: NSObject, NSCoding{
    let nome: String
    let nota: Int
    var items = Array<Ingredientes>()
    
    init(nome: String, nota: Int){
        self.nome = nome
        self.nota = nota
    }
    required init?(coder aDecoder: NSCoder) {
        self.nome = aDecoder.decodeObjectForKey("nome") as! String
        self.nota = aDecoder.decodeIntegerForKey("nota")
        self.items = aDecoder.decodeObjectForKey("items") as! Array
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nome, forKey: "nome")
        aCoder.encodeInteger(nota, forKey: "nota")
        aCoder.encodeObject(items, forKey: "items")
    }
    
    func detalhes() -> String{
        var mensagem = "Nota: \(self.nota) \n\n Ingredientes: \n"
        for item in self.items {
            mensagem += "* \(item.nome) - \(item.calorias) calorias \n"
        }
        return mensagem
    }
    
    func totalCalorias(){
        var total = 0.0
        for item in items{
            total += item.calorias
        }
    }
}