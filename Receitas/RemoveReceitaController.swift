//
//  RemoveReceitaController.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 22/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import Foundation
import UIKit

class RemoveReceitaController{
    let controlador: UIViewController
    init (controlador: UIViewController){
        self.controlador = controlador
    }
    
    func mostraAlerta(receita: Receita, handler:((UIAlertAction!) -> Void)) {
        let detalhes = UIAlertController(title: receita.nome,
                                         message: receita.detalhes(),
                                         preferredStyle: UIAlertControllerStyle.Alert)
        let remover = UIAlertAction(title: "Remover", style: UIAlertActionStyle.Destructive, handler: handler)
        detalhes.addAction(remover)
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        detalhes.addAction(cancelar)
        
        controlador.presentViewController(detalhes, animated: true, completion: nil)
    }
    
}