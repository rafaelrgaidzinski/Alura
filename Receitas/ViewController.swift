//
//  ViewController.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import UIKit

protocol AdicionaReceitaDelegate{
    func adiciona(refeicao: Receita)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarIngredienteDelegate {
   
    @IBOutlet weak var campoReceita: UITextField?
    
    @IBOutlet weak var campoNota: UITextField?
    
    @IBOutlet weak var tabelaIgredientes: UITableView!
    
    
    var delegate: AdicionaReceitaDelegate?
    
    var items: Array<Ingredientes> = []
    var itemsSelecionados: Array<Ingredientes> = []
    
    
    override func viewDidLoad() {
        let botaoAdicionaIngrediente = UIBarButtonItem(title: "Adicionar Ingrediente",
                                                       style: UIBarButtonItemStyle.Plain,
                                                       target: self,
                                                       action: #selector(ViewController.adicionarIngrediente) )
        navigationItem.rightBarButtonItem = botaoAdicionaIngrediente
    }
    
    func adicionarIngrediente(){
        let telaAdicionarIngrediente = IngredientesViewController(delegate: self)
        if let navigation = navigationController{
            navigation.pushViewController(telaAdicionarIngrediente, animated: true)
        }
    }
    
    func adicionarItem(item: Ingredientes) {
        items.append(item)
        if tabelaIgredientes == nil{
            return
        }
        tabelaIgredientes.reloadData()
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let linha = indexPath.row
        let conteudo = items[linha]
        
        let celula = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        celula.textLabel?.text = conteudo.nome
        return celula
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let celula = tableView.cellForRowAtIndexPath(indexPath)
        if celula == nil{
            return
        }
        if celula!.accessoryType == UITableViewCellAccessoryType.None {
            celula!.accessoryType = UITableViewCellAccessoryType.Checkmark
            itemsSelecionados.append(items[indexPath.row])
        } else {
            celula!.accessoryType = UITableViewCellAccessoryType.None
            if let posicao = itemsSelecionados.indexOf(items[indexPath.row]){
                itemsSelecionados.removeAtIndex(posicao)
            }
        }
    }
    
    
    @IBAction func botaoAdicionar(sender: UIButton) {
        if campoReceita == nil || campoNota == nil {
            return
        }
        
        let receita = campoReceita!.text
        let nota = Int(campoNota!.text!)
        
        if nota == nil{
            return
        }
        
        let refeicao = Receita(nome: receita!, nota: nota!)
        
        refeicao.items = itemsSelecionados
        
        print("Receita \(refeicao.nome) com ingredientes \(refeicao.items) adicionada com nota \(refeicao.nota)")
        
        if delegate == nil{
            return
        }
        
        delegate!.adiciona(refeicao)
        
        if let navigation = navigationController{
            navigation.popViewControllerAnimated(true)
        }
        
        
    }
    
}