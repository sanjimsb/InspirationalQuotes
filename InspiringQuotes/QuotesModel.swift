//
//  QuotesModel.swift
//  InspiringQuotes
//
//  Created by Bipin Msb on 2022-08-14.
//

import Foundation

struct QuotesModel: Codable {
    var results: [QuotesData]
}

struct QuotesData: Codable {
    var _id: String
    var content: String
    var author: String
}


struct AuthorsList: Codable {
    var results: [Authors]
}

struct Authors: Codable {
    var _id: String
    var name: String
    var slug: String
    var description: String
    var bio: String
}

struct FavList: Codable {
    var results: [Fav]
}

struct Fav: Codable {
    var _id: String
    var content: String
    var author: String
}

