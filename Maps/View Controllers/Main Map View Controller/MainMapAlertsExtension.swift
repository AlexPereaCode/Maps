//
//  MainMapAlertsExtension.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

extension MainMapViewController {
    
    internal func presentAlertStopTracking() {
        let alertController = UIAlertController(title: "¿Quieres guardar el trayecto?", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action) in
            self.removeRoute()
        }))
        
        alertController.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action) in
            self.presentSaveNameRouteAlert()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentSaveNameRouteAlert() {
        let alertController = UIAlertController(title: "Nombre de la ruta", message: "Introduce un nombre para la ruta actual", preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "Nombre:"
        }
        
        alertController.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { (action) in
            
            let textFieldName: String? = alertController.textFields?.first?.text
            
            if textFieldName == nil || textFieldName == "" {
                self.presentEmptyNameText()
            } else {
                self.saveLocations(name: textFieldName!)
                self.presentSavedSuccessAlert()
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentEmptyNameText() {
        let alertController = UIAlertController(title: "Introduce un nombre para continuar", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continuar", style: .default, handler: { (action) in
            self.presentSaveNameRouteAlert()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentSavedSuccessAlert() {
        let alertController = UIAlertController(title: "Tu ruta se ha guardado correctamente", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    internal func presentNotAuthorizedLocation() {
        let alertController = UIAlertController(title: "Localización no autorizada", message: "Maps necesita tener acceso a tu localización para funcionar", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Ajustes", style: .default, handler: { (action) in
            if let url = URL(string: "app-settings:root=Privacy&path=MOTION") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
}
