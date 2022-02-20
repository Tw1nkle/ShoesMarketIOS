//
//  CodableBundleExtension.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 07.08.2021.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // 1. Расположение файла JSON
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // 2. Создание свойств для данных
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        // 3. Создание декодера данных
        let decoder = JSONDecoder()
        
        // 4. Создание свойств для декодера данных
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // 5. Возвращение извлеченных данных
        return decodedData 
    }
}
