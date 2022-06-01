//
//  AssistantAPIProtocol.swift
//  AssistantAPI
//
//  Created by Cong Nguyen on 01/06/2022.
//

import Foundation
import RxSwift

public protocol AssistantProtocol {
    static func registerDevice(isDevMode: Bool,
                        registrationData: String,
                        deviceCert: String,
                        signature: String,
                        isFromDevice: Bool) -> Single<AppToken>
}
