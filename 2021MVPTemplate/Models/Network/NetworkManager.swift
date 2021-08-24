//
//  NetworkManager.swift
//  OmicronWeather
//
//  Created by Jason Crispell on 3/13/20.
//  Copyright © 2020 Jason Crispell. All rights reserved.
//

import Foundation

class NetworkManager: INetworkManager {
    
    internal let baseURL: String
    let defaultSession = URLSession(configuration: .default)
    private var dataTasks: [URLSessionDataTask?] = []

    required init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    internal func newRequest(method: String, path: String, parameters: JSONDictionary? = nil) -> (URLRequest?, Error?) {
        //TODO: Decide if we want headers, parameters, etc
        guard let url = URL(string: baseURL + path) else {
            return (nil, NetworkManagerError.malformedURL.error())
        }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method
        return (request, nil)
    }
    
    internal func getDataAtPath(path: String,
                                  parameters: JSONDictionary?,
                                  completion: @escaping NetworkManagerGetObjectCompletion) {
        let (optRequest, error) = newRequest(method: "GET", path: path, parameters: parameters)
        guard let request: URLRequest = optRequest, error == nil else {
            completion(nil, error)
            return
        }
        var dataTask: URLSessionDataTask? = nil
        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            defer { self.cleanupDataTask(dataTask: dataTask) }
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let statusCodeError = self.checkStatusCode(response: response)
            DispatchQueue.main.async {
                completion(data, statusCodeError)
            }
        }
            
        if let dataTask: URLSessionDataTask = dataTask {
            dataTasks.append(dataTask)
            dataTask.resume()
        }
    }
    
    internal func checkStatusCode(response: URLResponse?) -> Error? {
        
        guard let response = response as? HTTPURLResponse else {
            return NetworkManagerError.otherError.error()
        }
        
        var error: Error? = nil
        switch response.statusCode {
        case 200:
            error = nil
        case 400:
            error = NetworkManagerError.badData.error()
        case 401:
            error = NetworkManagerError.unauthorized.error()
        case 404:
            error = NetworkManagerError.resourceNotFound.error()
        default:
            return NetworkManagerError.otherError.error()
        }
        return error
    }
    
    
    internal func cleanupDataTask(dataTask: URLSessionDataTask?) {
        if let dataTask: URLSessionDataTask = dataTask,
            let index: Int = dataTasks.firstIndex(of: dataTask) {
            dataTasks.remove(at: index)
        }
    }
}
