//
//  Constants.swift
//  KhForum
//
//  Created by Kirill on 18.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
struct K {
    struct ProductionServer {
        static let baseURL = "http://services.ksue.edu.ua:8081/schedule/"
        static let auth = "com.alcsan.atimetable_19092013_552ca3ffa5"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
