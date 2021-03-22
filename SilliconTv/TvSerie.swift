//
//  TvSerie.swift
//  SilliconTv
//
//  Created by Pol Galbarro on 18/3/21.
//  Copyright © 2021 Pol Galbarro. All rights reserved.
//

import Foundation


struct Serie: Decodable {
    
   // var original_language: String?
    var name: String?
   // var description: String?
 //   var popularity: Double?
 //   var poster_path: String?
  //  var vote_average: Double?
  //  var vote_count: Int?
  //  var backdrop_path: String?
  //  var first_air: String?
  //  var genre_id: Int?
    
    
    enum CodingKeys: String, CodingKey {
    //    case original_language = "original_language"
        case name = "original_name"
      //  case description = "overview"
     //   case popularity = "popularity"
    //    case poster_path = "poster_path"
    //    case vote_average
    //    case vote_count
     //   case backdrop_path
     //   case first_air
    //    case genre_id
    }
}
