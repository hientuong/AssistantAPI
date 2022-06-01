//
//  AssistantClient.swift
//  AssistantAPI
//
//  Created by Cong Nguyen on 01/06/2022.
//

import RxSwift
import Alamofire

public struct AssistantClient: AssistantProtocol {
    static var client: BaseClient = BaseClient()
    
    public init(){}
    
    public static func registerDevice(isDevMode: Bool,
                        registrationData: String,
                        deviceCert: String,
                        signature: String,
                        isFromDevice: Bool) -> Single<AppToken> {
        let params: [String: Any] = [
            "device_cert": deviceCert,
            "is_dev_mode": isDevMode,
            "registration_data": registrationData,
            "signature": signature,
            "is_from_device": isFromDevice
        ]
        return client.request(AssistantRouter.registerDevice(params: params))
            .flatMap({ (data: RegisterResponseModel) -> Single<AppToken> in
            return .just(data.response.appToken)
        })
    }
}
