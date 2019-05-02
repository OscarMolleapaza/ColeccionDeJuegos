//
//  ViewController.swift
//  ColeccionDeJuegos
//
//  Created by MAC19 on 25/04/19.
//  Copyright © 2019 OscarMolleapaza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: (juego.imagen!))
        return cell
    }
    //Commit de prueba

    @IBAction func btnEditar(_ sender: Any) {
        self.tableView.isEditing = false
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var juegos: [Juego] = []
    
    override func viewDidLoad() {
        self.tableView.isEditing = true
        setEditing(true, animated: true)

        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
  
    }
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to : IndexPath) {
        
        let objetoMovido = self.juegos[fromIndexPath.row]
        juegos.remove(at: fromIndexPath.row)
        juegos.insert(objetoMovido, at: to.row)
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }catch{
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguenteVC = segue.destination as! JuegosViewController
        siguenteVC.juego = sender as? Juego
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //ELIMINAR DE LA BD
            
            context.delete(juegos[indexPath.row])
            //ELIMINAR DE LA TABLA
            juegos.remove(at: indexPath.row)
            tableView.reloadData()
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
    }


}

