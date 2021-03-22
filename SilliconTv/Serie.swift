//
//  Serie.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 14/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//

import Foundation

//clase Serie la cuan me permitira manejar los datos de las series
class Serie: NSObject {
    //atributos que me parecian interesantes para mostrar en la pantalla de detalles. Decidi guardar la id tambien por si en un futuro era necesario la id para recoger algun dato mas
    var id: Int?
    var lang: String?
    var name: String?
    var overview: String?
    var date: String?
    var popularity: Int?
    var voteCount: Int?
    var backDropPath: String?
    
    
    //Constructor de clase Serie
    init(id: Int ,language: String, name: String, overview: String, date: String,popularity: Int, voteCount:Int, backDropPath: String) {
        self.id = id
        self.lang = language
        self.name = name
        self.overview = overview
        self.date = date
        self.popularity = popularity
        self.voteCount = voteCount
        self.backDropPath = backDropPath
    }
}
