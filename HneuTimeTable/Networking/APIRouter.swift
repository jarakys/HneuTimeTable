//
//  APIRouter.swift
//  KhForum
//
//  Created by Kirill on 18.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    
    case faculties
    case specialities(facultetId: Int)
    case groups(facultetId: Int,specialitId: Int, course: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .faculties, .specialities, .groups:
            return .get
            
        }
    }
    
    private var path: String {
        switch self {
        case .faculties:
            return "xmlmetadata?q=faculties&auth=\(K.ProductionServer.auth)"
        case .specialities(let facultetId):
            return "xmlmetadata?q=specialities&facultyid=\(facultetId)&auth=\(K.ProductionServer.auth)"
        case .groups(let facultetId, let specialitId, let course ):
            return "xmlmetadata?q=groups&facultyid=\(facultetId)&specialityid=\(specialitId)&course=\(course)&auth=\(K.ProductionServer.auth)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
//        case .login(let email, let password):
//            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .faculties, .specialities, .groups:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        let data = path.data(using: .utf8)!
        let stringSpecfSym = String(data: data, encoding: .nonLossyASCII)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(stringSpecfSym))
        debugPrint(path)
        debugPrint(urlRequest)
        urlRequest.httpBody = data
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
}
