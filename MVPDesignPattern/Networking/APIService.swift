//
//  APIservice.swift
//  MVPDesignPattern
//
//  Created by Nuntapat Hirunnattee on 25/10/2565 BE.
//

import Foundation
enum NetworkError: Error{
    case invalidURL
    case invalidData
    case invalidDecoder
    case sessionError
}

class APIService{
    
    static let shared = APIService()
    
    private init(){ }
    
    func fatchData(urlString: String, completion: @escaping (Result<[User], NetworkError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.sessionError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let safeData = try JSONDecoder().decode([User].self, from: data)
                completion(.success(safeData))
            }
            catch{
                completion(.failure(.invalidDecoder))
            }
        }
        task.resume()
    }
}
