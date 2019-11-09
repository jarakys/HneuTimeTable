//
//  APIClient.swift
//  KhForum
//
//  Created by Kirill on 18.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//
import Alamofire
import Foundation
import XMLParsing
class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: XMLDecoder = XMLDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route).responseData(completionHandler: {data in
            debugPrint(data.value)
        })
        }
//
//    static func login(email: String, password: String, completion:@escaping (Result<User>)->Void) {
//        performRequest(route: APIRouter.login(email: email, password: password), completion: completion)
//    }
    
    static func getFaculteties(completion:@escaping (faculties)->Void) {
        let xmlDecoder = XMLDecoder()
        AF.request("http://services.ksue.edu.ua:8081//schedule/xmlmetadata?q=faculties&auth=com.alcsan.atimetable_19092013_552ca3ffa5").responseData(completionHandler: {data in
            if let result = try?xmlDecoder.decode(faculties.self, from: data.data!) {
                completion(result)
            }
            
        })
    }
    
    static func getSpecialties(facultId: Int, completion:@escaping (specialities)->Void) {
        let xmlDecoder = XMLDecoder()
        AF.request("http://services.ksue.edu.ua:8081/schedule/xmlmetadata?q=specialities&facultyid=\(facultId)&auth=com.alcsan.atimetable_19092013_552ca3ffa5").responseData(completionHandler: {data in
            if let result = try? xmlDecoder.decode(specialities.self, from: data.data!) {
                completion(result)
            }
            
        })
    }
    
    static func getGroups(facultId: Int,specialtyId: Int, course: Int, completion:@escaping (Result<groups,GroupsEmpty>)->Void) {
        let xmlDecoder = XMLDecoder()
        AF.request("http://services.ksue.edu.ua:8081/schedule/xmlmetadata?q=groups&facultyid=\(facultId)&specialityid=\(specialtyId)&course=\(course)&auth=com.alcsan.atimetable_19092013_552ca3ffa5").responseData(completionHandler: {data in
            if let result = try? xmlDecoder.decode(groups.self, from: data.data!) {
                completion(Result.success(result))
                return
            }
            completion(Result.failure(GroupsEmpty()))
            debugPrint(data)
        })
    }
    
//    static func getSubcategories(id:Int, completion:@escaping (Result<[SubCategoryModel], AFError>)->Void) {
//        let jsonDecoder = JSONDecoder()
//        performRequest(route: APIRouter.subcategories(idCategory: id), decoder: jsonDecoder, completion: completion)
//    }
    
//    static func getTopics(id:Int, completion:@escaping (Result<[Article]>)->Void) {
//        let jsonDecoder = JSONDecoder()
//        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
//        performRequest(route: APIRouter.topics(idSubcategory: id), decoder: jsonDecoder, completion: completion)
//    }
    
}
