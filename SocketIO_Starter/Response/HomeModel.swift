//
//  BaseClass.swift
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import Foundation

struct HomeModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case game
    }
    
    var game: Game?
    
    init() {
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        game = try container.decodeIfPresent(Game.self, forKey: .game)
    }
    
}

// MARK: -
// MARK: - Game Object
struct Game: Codable {
    
    enum CodingKeys: String, CodingKey {
        case preview
        case streamUrl = "stream_url"
        case channel
        case title
        case date
    }
    
    var preview: String?
    var streamUrl: String?
    var channel: Int?
    var title: String?
    var date: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        preview = try container.decodeIfPresent(String.self, forKey: .preview)
        streamUrl = try container.decodeIfPresent(String.self, forKey: .streamUrl)
        channel = try container.decodeIfPresent(Int.self, forKey: .channel)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        date = try container.decodeIfPresent(String.self, forKey: .date)
    }
    
}
