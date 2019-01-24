//
//  NetworkTask.swift
//  Lincoln
//
//  Created by David House on 9/9/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation
import os.log

public enum NetworkTaskResponse {
    case success(data: Data)
    case failure(error: Error)
}

struct Log {
    static var network = OSLog(subsystem: "Network", category: "Logging")
}

public class NetworkService<T: NetworkRequest> {

    private let session: URLSession
    private let requestLogging: Bool
    private let responseLogging: Bool
    private let responseDataLogging: Bool
    var bearerToken: String?

    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default, requestLogging: Bool = false, responseLogging: Bool = false, responseDataLogging: Bool = false) {
        session = URLSession(configuration: configuration)
        self.requestLogging = requestLogging
        self.responseLogging = responseLogging
        self.responseDataLogging = responseDataLogging
    }

    public func execute(request: T, completion: @escaping (_ response: NetworkTaskResponse) -> Void) {

        guard let urlRequest = request.createRequest(headers: requestHeaders()) else {
            return
        }

        if requestLogging {
            logRequest(urlRequest)
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if self.responseLogging {
                self.logResponse(data, response, error)
            }

            if let error = error {
                completion(.failure(error: error))
            }

            if let data = data {
                completion(.success(data: data))
            }
        }
        task.resume()
    }

    private func requestHeaders() -> [String: String] {

        guard let token = bearerToken else {
            return [:]
        }

        return ["Authorization": "Bearer \(token)"]
    }

    private func logRequest(_ request: URLRequest) {
        os_log(">>> Network Request >>>", log: Log.network, type: .debug)
        logDetail(">>> URL:", request.url)
        logDetail(">>> Method:", request.httpMethod)
        if let headerFields = request.allHTTPHeaderFields {
            for (key, value) in headerFields {
                logDetail(">>> \(key):", value)
            }
        }
        if responseDataLogging {
            if let body = request.httpBody {
                let dataString = String(data: body, encoding: .utf8)
                logDetail(">>> Data:", dataString)
            }
        }
        os_log(">>> ............... >>>", log: Log.network, type: .debug)
    }

    private func logResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        os_log("<<< Network Response <<<", log: Log.network, type: .debug)
        if let error = error {
            logDetail("<<< Error:", error.localizedDescription)
        }
        if let response = response as? HTTPURLResponse {
            logDetail("<<< Status Code:", response.statusCode)
            for (key, value) in response.allHeaderFields {
                logDetail("<<< \(key):", "\(value)")
            }
        }
        if let data = data {
            logDetail("<<< Data Length:", data.count)
            if responseDataLogging {
                let dataString = String(data: data, encoding: .utf8)
                logDetail("<<< Data:", dataString)
            }
        }
        os_log("<<< ................ <<<", log: Log.network, type: .debug)
    }

    private func logDetail(_ prefix: String, _ value: CustomStringConvertible?) {
        guard let value = value else {
            os_log("%s nil", log: Log.network, type: .debug, prefix)
            return
        }

        os_log("%s %s", log: Log.network, type: .debug, prefix, value.description)
    }
}
