//
//  SportModel.swift
//  Betano
//
//  Created by Pantos, Thomas on 28/4/23.
//

import Foundation
import SwiftUI


struct Sport: Codable , Identifiable{
    let id = UUID()

    var i: String
    var d: String
    var e: [Match]
    
}

struct Match: Codable , Identifiable, Equatable{
    let id = UUID()
    var d: String
    var i: String
    var si: String
    var sh: String
    var tt: Int
    let isLiked: Bool = false

}




