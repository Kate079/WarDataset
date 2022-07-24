//
//  FileManager.swift
//  WarDataset
//
//  Created by Kate on 14.07.2022.
//

import Foundation

class FileManager {
    static let shared = FileManager()

    func loadJSON<T: Decodable>(fileName: JsonFiles, completionHandler: @escaping (Result<[T], DecodeError>) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName.rawValue, withExtension: "json") else {
            completionHandler(.failure(.fileDoesntExist))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([T].self, from: data)
            completionHandler(.success(jsonData))
        } catch {
            completionHandler(.failure(.decodeError))
        }
    }
}
