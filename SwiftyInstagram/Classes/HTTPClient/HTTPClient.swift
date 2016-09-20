//
//  HTTPClient.swift
//  Pods
//
//  Created by Julien Regnauld on 9/20/16.
//
//

import Foundation
enum Result<T> {
  case Success(T)
  case Failure(Error)
}
enum HTTPMethod: String {
  case get
  case post
  case delete
  var rawValue:String {
   return self.rawValue.uppercased()
  }
}
typealias RequestResultBlock = (_ result: Result<Data>) -> Void
typealias Parameters = [String: String]
typealias RequestHeaders = [String: String]
typealias JSONDictionary = [String: AnyObject]
protocol HTTPClient {
  var session: URLSession { get set }
  var baseURL: URL { get }
  var requestHeaders: RequestHeaders? { get set }
  init(session: URLSession)
  func get(path: String, parameters: Parameters?, completed: @escaping RequestResultBlock)
}
