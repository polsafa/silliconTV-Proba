//
//  Service.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 14/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

//apikey = c6aeee577586ba38e487b74dfede5deb

//clase Service que me servira para hacer requests con Alomafire
class Service{
    //url api para conseguir las peliculas mas populares, he decidido poner las rutas a la api aqui ya que nadie va a modificarlas
    fileprivate var ApiUrl = "https://api.themoviedb.org/3/tv/popular?api_key=c6aeee577586ba38e487b74dfede5deb&language=es-ES&page="
    
    //url api para coger sus imagenes, la url no esta entera ya que se necesuta recoger primero el listado de series y el backDropPath el cual es la parte final de la ruta donde se encuentra la imagen
    fileprivate var ApiImages = "https://image.tmdb.org/t/p/original"
    
    //funciona a la que le pasamos un int llamado endpoint que definira a que pagina de la api hacemos la peticion
    func getAllTv(endpoint: String,completed: @escaping ([Serie], Bool) -> Void ){
        //array de objeto serie para guardas los resultados ya recogidos
        var ser = [Serie]()
        //funcion de la libreria alamofire que me permite atacar a la api
        Alamofire.request(ApiUrl + endpoint).responseJSON{
            response in
            //switch para comprobar si la llamada a la api ha tenido exito o no
            switch response.result{
            case .success:
                //funcion para recibir el json, es de la libreria swiftyJSON la cual facilita el recibir y parsear json
                let result = try? JSON(data: response.data!)
                let resultsArray = result!["results"]
                //recorremos el array desglosando los objetos recibidos
                for i in resultsArray.arrayValue{
                    let id = i["id"].intValue
                    let lang = i["original_language"].stringValue
                    let name = i["original_name"].stringValue
                    let description = i["overview"].stringValue
                    let date = i["first_air_date"].stringValue
                    let popu = i["popularity"].intValue
                    let vote = i["vote_count"].intValue
                    let back = i["backdrop_path"].stringValue
                    //llenamos un objeto serie
                    let s = Serie.init(id: id,language: lang,name: name,overview: description,date: date,popularity: popu,voteCount: vote,backDropPath: back)
                    //lo añadimos al array de series
                    ser.insert(s, at: ser.count)
                    
                }
                //con esto marcamos que la función se ha terminado y enviamos el resultado. He usado este metodo porque al ser asincrona con un return normal devolveria los datos antes de terminar la request, de esta manera cuando termina de ejecutarse envia los datos a mi view controller y sigue leyendo el codigo desde alli. Envio al viewcontroller unarray y un bool
                completed(ser, true)
                break;
            case .failure:
                //si la respuesta falla muestro un mensaje de error por consola
                print("ERROR: CAN'T CONNECT TO THE API SERVICE")
                completed(ser,false)
                break;
                }
            }
    }
    //función que permite conectarse a la api para recibir imagenes
    func getImage(endpoint: String,completed: @escaping (UIImage?, Bool) -> Void ){
       //en este caso he usado la libreria/pod AlamofireImage que permite descargar imagenes de una url, el endpoint en este caso es la parte restante del path que necesito para acceder a la url imagen, esta información la he recogido en la otra función con todas las series
        Alamofire.request(ApiImages + endpoint).responseImage{
            response in
            //switch para verificar el estado de la response
            switch response.result{
            case .success:
                //si es exitosa devuelvo una uiimage y un bool
            let result = response.result.value
            completed(result!, true)
                break
            case .failure:
                //si falla la request muestro un mensaje de error por consola
                print("ERROR: CAN'T CONNECT TO THE API SERVICE")
                break
            }
        }
    }
    }
