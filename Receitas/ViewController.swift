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
    
    func getUsuarioDiretorio() -> String{
        let usuarioDireorio = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return usuarioDireorio[0] as String
    }
    
    override func viewDidLoad() {
        let diretorio = getUsuarioDiretorio()
        let arquivo = "\(diretorio)/Receitas"
        if let carregaArquivo = NSKeyedUnarchiver.unarchiveObjectWithFile(arquivo){
            items = carregaArquivo as! Array
        }
        let botaoAdicionaIngrediente = UIBarButtonItem(title: "Adicionar Ingrediente",
                                                       style: UIBarButtonItemStyle.Plain,
                                                       target: self,
                                                       action: #selector(ViewController.adicionarIngrediente) )
        navigationItem.rightBarButtonItem = botaoAdicionaIngrediente
    }
    
    func adicionarIngrediente(){
        let telaAdicionarIngrediente = IngredientesViewController(delegate: self)
        if let navigation = self.navigationController{
            navigation.pushViewController(telaAdicionarIngrediente, animated: true)
        }
    }
    
    func adicionarItem(item: Ingredientes) {
        items.append(item)
        if let tabela = tabelaIgredientes {
            let diretorio = getUsuarioDiretorio()
            let arquivo = "\(diretorio)/Receitas"
             NSKeyedArchiver.archiveRootObject(items, toFile: arquivo)
            tabela.reloadData()
        } else {
                Alerta.init(controlador: self).mostraAlerta("Um erro ocorreu ao tentar carregar a tabela!")
        }
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
    
    func getReceita() -> Receita? {
        if ((campoReceita!.text?.isEmpty == true) || (campoNota!.text?.isEmpty == true)) {
            return nil
        }
        
        let nome = campoReceita!.text
        let nota = Int(campoNota!.text!)
        
        if nota == nil {
            return nil
        }
        
        let receita = Receita(nome: nome!, nota: nota!)
        receita.items = itemsSelecionados
        
        print("Receita \(receita.nome) com ingredientes \(receita.items) adicionada com nota \(receita.nota)")
        
        return receita
    }
    
    @IBAction func botaoAdicionar(sender: UIButton) {
        if let receita = getReceita(){
            if let receitas = delegate{
                receitas.adiciona(receita)
                if let navigation = self.navigationController{
                    navigation.popViewControllerAnimated(true)
                } else{
                    Alerta.init(controlador: self).mostraAlerta("Um erro ocorreu ao carregar a tela, mas a receita foi adicionada!")
                }
                return
            }
        }
        Alerta.init(controlador: self).mostraAlerta("Não foi possível adicionar uma nova receita!")
    }
    
}