//
//  CustomDelegate.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 23/4/2024.
//

import Foundation

class CustomDelegate: NSObject, URLSessionDelegate {

  // Need to do it because Willow has SSL proxy protection for when we call other API's. 
  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
      let protectionSpace = challenge.protectionSpace
      
      if protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, protectionSpace.host.contains("dummyjson.com") {
          if let serverTrust = protectionSpace.serverTrust {
              completionHandler(.useCredential, URLCredential(trust: serverTrust))
              return
          }
      }
      
      completionHandler(.performDefaultHandling, nil)
  }
}

