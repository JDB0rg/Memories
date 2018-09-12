//
//  Memory.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

struct Memory: Equatable, Codable {
    var title: String
    var bodyText: String
    var imageData: Data
}
