//
//  Alerta.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 22/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import Foundation
import UIKit

class Alerta {
    let controlador: UIViewController
    
    init(controlador: UIViewController){
        self.controlador = controlador
    }
    
    func mostraAlerta(mensagem: String){
        let alerta = UIAlertController(title: "Aviso", message: mensagem, preferredStyle: UIAlertControllerStyle.Alert)
        let botaoAlerta = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alerta.addAction(botaoAlerta)
        controlador.presentViewController(alerta, animated: true, completion: nil)
    }
}