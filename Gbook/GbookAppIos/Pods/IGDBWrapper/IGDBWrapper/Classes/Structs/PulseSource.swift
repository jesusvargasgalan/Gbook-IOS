//
//  PulseSource.swift
//
//  Created by Filip Husnjak on 2018-01-23.
//  Copyright © 2018 igdb. All rights reserved.
//

import Foundation

public struct PulseSource: Codable {
    public var id: UInt64?
    public var name: String?
    public var game: ObjectType<Game>?
    public var page: ObjectType<Page>?
    public var _score: Float64?
    public var error: [String]?
    
    public init() {}
}
