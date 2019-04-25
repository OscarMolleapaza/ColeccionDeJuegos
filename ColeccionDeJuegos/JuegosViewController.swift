//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by MAC19 on 25/04/19.
//  Copyright © 2019 OscarMolleapaza. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    var juego:Juego? = nil
    
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
 
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion:  nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil{
            juego!.titulo = tituloTextField.text
            juego!.imagen = juegoImageView.image?.jpegData(compressionQuality: 0.50)
            
        }else {
        
            let context = (UIApplication.shared.delegate as!
                AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = juegoImageView.image?.jpegData(compressionQuality: 0.50)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var juegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil {
            juegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagenSeleccionada = info[.originalImage] as? UIImage
        juegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
