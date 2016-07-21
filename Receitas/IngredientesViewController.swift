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

    @IBOutlet weak var campoIngrediente: UITextField!
   
    @IBOutlet weak var campoCalorias: UITextField!
    
    var delegate: AdicionarIngredienteDelegate?
    
    init(delegate: AdicionarIngredienteDelegate){
        self.delegate = delegate
        super.init(nibName: "IngredientesViewController" , bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func botaoAdiciona(sender: UIButton) {
        if campoIngrediente == nil || campoCalorias == nil{
            return
        }
        
        let ingrediente = campoIngrediente!.text
        let calorias = NSString(string: campoCalorias!.text!).doubleValue
        
        let item = Ingredientes(nome: ingrediente!, calorias: calorias)
        
        if delegate == nil{
            return
        }
        
        delegate!.adicionarItem(item)
        
        if let navigation = navigationController {
            navigation.popViewControllerAnimated(true)
        }
        
    }
}
