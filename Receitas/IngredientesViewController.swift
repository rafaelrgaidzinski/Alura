//
//  IngredientesViewController.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import UIKit

protocol AdicionarIngredienteDelegate{
    func adicionarItem(item: Ingredientes)
}

class IngredientesViewController: UIViewController {

    @IBOutlet weak var campoIngrediente: UITextField?
   
    @IBOutlet weak var campoCalorias: UITextField?
    
    var delegate: AdicionarIngredienteDelegate?
    
    init(delegate: AdicionarIngredienteDelegate){
        self.delegate = delegate
        super.init(nibName: "IngredientesViewController" , bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getIngrediente() -> Ingredientes? {
        if ((campoIngrediente!.text?.isEmpty == true) || (campoCalorias!.text?.isEmpty == true)) {
            return nil
        }
        
        let ingrediente = campoIngrediente!.text
        let calorias = NSString(string: campoCalorias!.text!).doubleValue
        
        let item = Ingredientes(nome: ingrediente!, calorias: calorias)
        print("Item: \(campoIngrediente!.text) com \(campoCalorias!.text) calorias")
        
        return item
    }
    
    @IBAction func botaoAdiciona(sender: UIButton) {
        if let ingrediente = getIngrediente(){
            if let ingredientes = delegate{
                ingredientes.adicionarItem(ingrediente)
                if let navigation = self.navigationController {
                    navigation.popViewControllerAnimated(true)
                } else {
                    Alerta.init(controlador: self).mostraAlerta("Um erro ocorreu ao carregar a tela, mas o ingrediente foi adicionado!")
                }
            }
        }
        Alerta.init(controlador: self).mostraAlerta("Não foi possível adicionar um novo ingrediente!")
    }
    
}
