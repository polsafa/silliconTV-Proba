//
//  ViewController.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 12/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//


//apikey = c6aeee577586ba38e487b74dfede5deb


import UIKit
import CoreData


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //variables que necesitare para trabajar la vista
   var series = [Serie]()
   var image: UIImage?
   var indexSerie = 0
   var page = 1
    //variable coredata
    var contexto: NSManagedObjectContext?
    //variables de objetos de la vista
    @IBOutlet weak var tblSerie: UITableView!
    @IBOutlet weak var labelPage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblSerie.delegate = self
        self.tblSerie.dataSource = self
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        contexto = (appDelegate?.persistentContainer.viewContext)!
        //recupero la pagina nada mas empezar la vista, el valor por defecto es uno asi que no petara cuando abres el programa
        getPage()
        conectAPI()
    }
    //con esta funcion puedo cambiar la pagina en la que hago la request, en este caso la función suma
    @IBAction func nextPage(_ sender: UIButton) {
        if(page != 500){
            page = page + 1
            savePage(page: page)
            series.removeAll()
            conectAPI()
        }
    }
    //con esta función cambio la pagina hacia atras la limito a 1 si es uno no hace nada
    @IBAction func previousPage(_ sender: UIButton) {
        if(page != 1){
            page = page - 1
            savePage(page: page)
            series.removeAll()
            conectAPI()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
//función que genera un objeto Service para hacer las llamadas a la API
    func conectAPI(){
        //coloco en el label en que pagina se encuentra el usuario
        labelPage.text = "pagina: " + String(page)
        //objeto service
        let service = Service()
        //función para recibir la lista de series populares
        service.getAllTv(endpoint: String(page)) { ser, check in
            //aqui recupero todos los datos gracias al handeler y puedo recibir el array de todas las series de la pagina, luego reinicio la tabla ya que tiene valores iniciales que no me interesan
            if(check == true){
                self.series = ser
                self.tblSerie.reloadData()
            }
        }
    }
    
    //aqui declaro el tamaño de la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    //Declaro una celdra personalizada
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSerie.dequeueReusableCell(withIdentifier: "mycell")
        cell?.textLabel?.text = self.series[indexPath.row].name
        return cell!
    }
    //Al clicar una pelicula mando una request con el backpath para obtener la foto
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSerie = indexPath.row
        let s = Service()
        s.getImage(endpoint: series[indexPath.row].backDropPath!){ (img, validate) in
            if(validate == true){
                self .image = img
                self.changeView()
            }
        }
    }
    //cambio de view controller
    func changeView(){
        savePage(page: page)
        performSegue(withIdentifier: "viewDetails", sender: self)
    }
    //envio todos los datos al siguiente view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc2 = segue.destination as! ViewControllerDetails
        vc2.name = self.series[indexSerie].name!
        vc2.overview = self.series[indexSerie].overview!
        vc2.popularity = self.series[indexSerie].popularity!
        vc2.imagePath = self.series[indexSerie].backDropPath!
        vc2.date = self.series[indexSerie].date!
        vc2.voteCount = self.series[indexSerie].voteCount!
        vc2.image = self.image
    }
    //aquia accedo al core data y recupero la pagina en la que me encuentro
    func getPage(){
        let fetcRequest = NSFetchRequest<User>(entityName: "User")
        do{
            let user: [User] = try contexto!.fetch(fetcRequest)
            for p in user{
                page = Int(p.page)
            }
        }catch let error as NSError{
            print("HA SALTADO UN ERROR: \(error)")
        }
    }
    //aqui guardo la pagina en la que me encuentro en el core data
    func savePage(page: Int){
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: contexto!)
        let user = User(entity: userEntity!, insertInto: contexto)
        user.page = Int32(page)
        do{
            try contexto?.save()
        }catch let error as NSError{
            print("HA SALTADO UN ERROR: \(error)")
        }
    }}

