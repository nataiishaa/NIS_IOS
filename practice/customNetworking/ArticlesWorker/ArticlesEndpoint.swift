//
//  ArticlesEndpoint.swift
//  customNetworking
//
//  Created by Nataly Zakharova on 15.12.2023.
//
// практика
import Foundation

enum ArticlesEndpoint: Endpoint {
    case news(rubricId: Int, pageIndex: Int)
    
    var compositePath: String {
        switch self {
        case .news(let rubricId, let pageIndex):
            "todos/3"
        }
    }
    
    var headers: HeaderModel { [:] }
}
