//
//  ViewControllerDetails.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 16/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//

import UIKit

class ViewControllerDetails: UIViewController {
    //variables para los datos, los datos los recibo desde el otro view controller por eso estan vacias
    var name = "test"
    var overview = ""
    var imagePath = ""
    var date = ""
    var voteCount = 0
    var popularity = 0
    var image: UIImage? = nil
    //variables de objetos en pantalla
    @IBOutlet weak var serieImage: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    @IBOutlet weak var labelVotes: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //coloco todos los datos en pantalla
        labelName.text = name
        labelOverview.text = overview
        labelDate.text = "Fecha de lanzamiento: " + date
        labelVotes.text = "Votos: " + String(voteCount)
        labelPopularity.text = "Indice de popularidad: " + String(popularity)
        serieImage.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //función para volver al mainviewcontroller
    @IBAction func goBack(_ sender: UIButton) {
        performSegue(withIdentifier: "goBack", sender: self)
        
    }
}
