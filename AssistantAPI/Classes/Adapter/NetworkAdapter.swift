//
//  NetworkAdapter.swift
//  AssistantAPI
//
//  Created by Cong Nguyen on 01/06/2022.
//

import Foundation
public protocol NetworkEnv {
    var baseUrl: String { get }
}

public class NetworkAdapter {
    public static var shared: NetworkAdapter = NetworkAdapter()
    public var environment: NetworkEnv!
    var appToken: AppToken?
    
    init() {}
    
    public func setupAdapter(environment: NetworkEnv) {
        self.environment = environment
    }
    
    func setAppToken(appToken: AppToken) {
        self.appToken = appToken
    }
    
    func getAppToken() -> AppToken? {
        return self.appToken
    }
            
}
