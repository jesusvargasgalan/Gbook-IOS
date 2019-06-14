//
//  Task.swift
//  GbookV2
//
//  Created by macOS12 on 30/04/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//


import Foundation

struct Task{
    var apellidos:String
    var nombre: String
    var id: String
    
    var dictionary: [String: Any] {
        return [
            "Apellidos": apellidos,
            "Nombre": nombre
        ]
    }
}

extension Task{
    init?(dictionary: [String : Any], id: String) {
        guard   let apellidos = dictionary["apellidos"] as? String,
            let nombre = dictionary["nombre"] as? String
            else { return nil }
        
        self.init(apellidos: apellidos, nombre: nombre, id: id)
    }
}
