//
//  JSONRequest.swift
//  Lincoln
//
//  Created by David House on 9/9/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

public enum NetworkRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum NetworkRequestEncoding {
    case none
    case form(formElements: [String: CustomStringConvertible])
    case multipartForm(elements: [MultipartFormElement])
    case json(data: Data)
    case codable(object: NetworkEncodable)
}

public protocol NetworkRequest {
    var host: String { get }
    var endpoint: String { get }
    var method: NetworkRequestMethod { get }
    var bodyEncoding: NetworkRequestEncoding { get }

    func url() -> URL?
}

public protocol NetworkEncodable {
    func toData() -> Data?
}

public struct MultipartFormElement {
    let name: String
    let fileName: String?
    let contentType: String?
    let data: Data

    public init(name: String, value: String) {
        self.name = name
        self.fileName = nil
        self.contentType = nil
        self.data = value.data(using: .utf8) ?? Data()
    }

    public init(name: String, fileName: String, contentType: String, data: Data) {
        self.name = name
        self.fileName = fileName
        self.contentType = contentType
        self.data = data
    }
}

extension NetworkRequest {

    public func createRequest(headers: [String: CustomStringConvertible] = [:]) -> URLRequest? {

        guard let encodedEndpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }

        let url: URL? = {

            if encodedEndpoint.hasPrefix("/") {
                return URL(string: "\(host)\(encodedEndpoint)")
            } else {
                return URL(string: "\(host)/\(encodedEndpoint)")
            }
        }()

        guard let requestURL = url else {
            return nil
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue

        let encodingType = bodyEncoding
        switch encodingType {
        case .none:
            break
        case .form(let formElements):
            let mappedParameters: String = formElements.compactMap {
                if let value = $0.value.description.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~/?")) {
                    return "\($0.key)=\(value)"
                } else {
                    return nil
                }
                }.joined(separator: "&")
            request.httpBody = mappedParameters.data(using: .utf8)
            request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        case .json(let data):
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
        case .codable(let object):
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = object.toData() ?? Data()
        case .multipartForm(let elements):
            let boundary = "Boundary-" + UUID().uuidString.replacingOccurrences(of: "-", with: "")
            request.addValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
            var formData = Data()

            for element in elements {
                formData.appendString("--" + boundary + "\r\n")
                if element.fileName != nil {
                    formData.appendString("Content-Disposition: form-data; name=\"\(element.name)\"; filename=\"\(element.fileName ?? "")\"\r\n")
                } else {
                    formData.appendString("Content-Disposition: form-data; name=\"\(element.name)\"\r\n")
                }

                if element.contentType != nil {
                    formData.appendString("Content-Type: \"\(element.contentType ?? "")\"\r\n")
                }

                formData.appendString("\r\n")
                formData.append(element.data)
            }

            formData.appendString("\r\n--" + boundary + "--")
//            request.addValue(String(formData.count), forHTTPHeaderField: "Content-Length")
            request.httpBody = formData
        }

        for (key, value) in headers {
            request.addValue(value.description, forHTTPHeaderField: key)
        }

        return request
    }
}
