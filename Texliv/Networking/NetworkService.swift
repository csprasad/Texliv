//
//  NetworkService.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import Foundation


struct NetworkService {
    
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchToken(email: String, completion: @escaping(Result<ApiResponse<fetchTokenModel>, Error>) -> Void) {
        let params = ["email": email]
        request(route: .fetchToken, method: .post, parameters: params, completion: completion)
    }
    
    func verifyOTP(token: String, email: String, code: String, completion: @escaping(Result<ApiResponse<verifyOTPModel>, Error>) -> Void) {
        let params = ["token": token, "email": email, "verificationCode": code]
        
        request(route: .otpValidate, method: .put, parameters: params, completion: completion)
        print("Params are:", params)
    }
    
    
    private func request<T: Decodable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping(Result<ApiResponse<T>, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<ApiResponse<T>, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
//            if response != nil {
                completion(.success(response))
//            } else {
//                completion(.failure(AppError.unknownError))
//            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    // MARK: - This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: url path for request.
    ///   - method: type of request to called.
    ///   - parameters: params which required to get data from backend.
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .post, .put:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
