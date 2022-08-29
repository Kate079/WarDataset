//
//  FileManager.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func loadData<T: Decodable>(fileName: JsonFiles, completionHandler: @escaping (Result<[T], DecodeError>) -> Void)
}

class NetworkManager {
// Resource Links
//    https://raw.githubusercontent.com/Kate079/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json
//    https://raw.githubusercontent.com/Kate079/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json

    // MARK: - Static properties

    static let shared = NetworkManager()

    // MARK: - Private properties
    
    private let session = URLSession.shared
    private let baseURL = "https://raw.githubusercontent.com/Kate079/2022-Ukraine-Russia-War-Dataset/main/data"

    // MARK: - Lifecycle

    private init() {}
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
    func loadData<T: Decodable>(fileName: JsonFiles, completionHandler: @escaping (Result<[T], DecodeError>) -> Void) {
        let endpoint = baseURL + "/\(fileName.rawValue).json"
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.URLError))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode([T].self, from: data)
                completionHandler(.success(jsonData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
