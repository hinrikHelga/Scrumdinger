//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Hinrik Helgason on 13/03/2023.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject {
  @Published var scrums: [DailyScrum] = []
  
  private static func fileURL() throws -> URL {
    // Return URL of a file named scrums.data.
    try FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: false
    )
    .appendingPathComponent("scrums.data")
  }
  
  // The method accepts a completion closure that it calls asynchronously with either an array of scrums or an error.
  static func load(completion: @escaping (Result<[DailyScrum], Error>) -> Void) {
    DispatchQueue.global(qos: .background).async {
      do {
        let fileURL = try fileURL()
        
        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
          // Call the completion handler with an empty array if there’s an error opening the file handle since
          // scrums.data doesn’t exist when a user launches the app for the first time.
          DispatchQueue.main.async {
            completion(.success([]))
          }
          return
        }
        
        let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
        
        // Pass decoded scrums to completion handler
        DispatchQueue.main.async {
          completion(.success(dailyScrums))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
  
  static func load() async throws -> [DailyScrum] {
    try await withCheckedThrowingContinuation { continuation in
      load { result in
        switch result {
        case .success(let scrums):
          continuation.resume(returning: scrums)
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  // This method accepts a completion handler that accepts either the number of saved scrums or an error (when encoding
  // scrums).
  static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>) -> Void) {
    DispatchQueue.global(qos: .background).async {
      do {
        let data = try JSONEncoder().encode(scrums)
        let outFile = try fileURL()
        
        try data.write(to: outFile)
        
        DispatchQueue.main.async {
          completion(.success(scrums.count))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
  
  @discardableResult
  static func save(scrums: [DailyScrum]) async throws -> Int {
    try await withCheckedThrowingContinuation { continuation in
      save(scrums: scrums) { result in
        switch result {
        case .failure(let error):
          continuation.resume(throwing: error)
        case .success(let scrumsSaved):
          continuation.resume(returning: scrumsSaved)
        }
      }
    }
  }
}
