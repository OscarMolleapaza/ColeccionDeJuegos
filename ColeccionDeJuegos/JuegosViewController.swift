//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by MAC19 on 25/04/19.
//  Copyright © 2019 OscarMolleapaza. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

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
            juego!.categoria = txtCategoria.text
            
        }else {
        
            let context = (UIApplication.shared.delegate as!
                AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = juegoImageView.image?.jpegData(compressionQuality: 0.50)
            juego.categoria = txtCategoria.text
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var juegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var txtCategoria: UITextField!
    var categorias = ["Accion","Niños","Adultos","Conquista"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        if juego != nil {
            juegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            txtCategoria.text = juego!.categoria
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
        //    eliminarBoton.isHidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return categorias[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        self.txtCategoria.text = self.categorias[row]
        self.dropDown.isHidden = false
    }
    func textFieldDidBeginEditing(textField: UITextField){
        if textField == self.txtCategoria {
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagenSeleccionada = info[.originalImage] as? UIImage
        juegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
