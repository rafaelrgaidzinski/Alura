//
//  ReceitasTableViewController.swift
//  Receitas
//
//  Created by Sistemainfo.Mac on 21/07/16.
//  Copyright © 2016 Sistema Mob. All rights reserved.
//

import UIKit

class ReceitasTableViewController: UITableViewController, AdicionaReceitaDelegate{
    
    var receitas: Array<Receita> = []
    
    func adiciona(refeicao: Receita){
        receitas.append(refeicao)
        let diretorio = getUsuarioDiretorio()
        let arquivo = "\(diretorio)/Receitas"
        NSKeyedArchiver.archiveRootObject(receitas, toFile: arquivo)
        tableView.reloadData()
    }
    
    func getUsuarioDiretorio() -> String{
        let usuarioDireorio = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return usuarioDireorio[0] as String
    }
    
    override func viewDidLoad() {
        let diretorio = getUsuarioDiretorio()
        let arquivo = "\(diretorio)/Receitas"
        if let carregaArquivo = NSKeyedUnarchiver.unarchiveObjectWithFile(arquivo){
            receitas = carregaArquivo as! Array
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "adicionaReceita"{
            let tela = segue.destinationViewController as! ViewController
            tela.delegate = self
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receitas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let linha = indexPath.row
        let conteudo = receitas[linha]
        
        let celula = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        celula.textLabel!.text = conteudo.nome
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ReceitasTableViewController.mostraDetalhes))
        celula.addGestureRecognizer(longPress)
        return celula
    }
    
    func mostraDetalhes(recognizer: UILongPressGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.Began{
            let celula = recognizer.view as! UITableViewCell
            let indexPath = tableView.indexPathForCell(celula)
            if indexPath == nil{
                return
            }
            let linha = indexPath!.row
            let receita = receitas[linha]
            
            RemoveReceitaController(controlador: self).mostraAlerta(receita, handler: {action in
                self.receitas.removeAtIndex(linha)
                self.tableView.reloadData()
            })
        }
    }
    
}
