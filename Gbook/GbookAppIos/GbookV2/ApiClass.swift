//
//  ApiClass.swift
//  GbookV2
//
//  Created by macOS12 on 09/04/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import Foundation
import UIKit
import IGDBWrapper

 func Buscar(){
    let wrapper : IGDBWrapper = IGDBWrapper(apiKey: "3ad6774f040ad7a524158af482b349cc")
let params: Parameters = Parameters()
    .add(fields: "*")
    .add(order: "published_at:desc")

  wrapper.games(params: params, onSuccess: {(jsonResponse: [Game]) -> (Void) in
    // Do something with resulting jsonResponse (JsonArray)
}, onError: {(Error) -> (Void) in
    // Do something on error
})

}
