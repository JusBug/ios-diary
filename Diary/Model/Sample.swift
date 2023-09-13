//
//  Sample.swift
//  Diary
//
//  Created by yyss99, Jusbug on 2023/08/29.
//

struct Sample: Decodable {
    let title: String
    let body: String
    let date: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case body
        case date = "created_at"
    }
}
