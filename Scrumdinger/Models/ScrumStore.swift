//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Ashley Nygaard on 3/22/23.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil,create: false)
        .appendingPathComponent("scrums.data")
    }
    
    // single type that represents the outcome of an operation. func accepts a completion closure that is calls async with either an array of scrums or an error
    static func load(completion: @escaping(Result<[DailyScrum], Error>)->Void){
        //longer running task of opening file and decoding contents should be done in background
        DispatchQueue.global(qos: .background).async {
            do {
                let fileUrl = try fileURL()
                // data doesn't exist on first launch, need to call completion handler with emtpy arry if error opening the file handle
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                //longer running task completed so move back to main queue
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
        // suspends the load fn, passes continuation into a closure
        // continuation is a value that reps the code after an awaited fn
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                }
            
            }
        }
    }
    
    
    static func save(scrums: [DailyScrum], completion: @escaping(Result<Int, Error>)->Void){
        DispatchQueue.global(qos: .background).async {
           //encode scrums, send errors to catch
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
            } catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                }
            
        }
    }
    
    @discardableResult
    static func save(scrums: [DailyScrum]) async throws -> Int {
        // suspends the load fn, passes continuation into a closure
        // continuation is a value that reps the code after an awaited fn
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
