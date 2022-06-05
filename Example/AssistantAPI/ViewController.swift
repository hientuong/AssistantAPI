//
//  ViewController.swift
//  AssistantAPI
//
//  Created by cong nguyen on 05/31/2022.
//  Copyright (c) 2022 cong nguyen. All rights reserved.
//

import UIKit
import AssistantAPI
import RxSwift

public func runOnMainAfter(_ deadline: DispatchTime, work: @escaping @convention(block) () -> Swift.Void) {
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: work)
}

struct AppEnvironment: NetworkEnv {
    var baseUrl: String {
        return "https://vinbase.ai/"
    }
    
    static var shared = AppEnvironment()
}

class ViewController: UIViewController {
    
    var assistantAPI: AssistantProtocol?
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDevice()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func test() {
        self.pushMessage()
    }
    
    func pushMessage() {
        AssistantClient.pushMessage(message: "Tại sao gọi Ocean Park là thành phố 15 phút?",
                                    vaAgenId: "1653292868813182109",
                                    nlpFeature: ["DIALOG"])
            .delay(.microseconds(100), scheduler: MainScheduler.instance)
            .flatMap({ messageId -> Single<VAResponse> in
                return AssistantClient.getVAResponse(by: messageId)
            }).flatMap({ response -> Single<VAResponse> in
                print("DEBUG: getVAResponse by message id ")
                print(response)
                return AssistantClient.getVAResponse()
            })
        .subscribe { response in
            print("DEBUG: getVAResponse by session id ")
            print(response)
        } onFailure: { error in
            print(error)
        }.disposed(by: disposeBag)

    }
    
    
    func registerDevice() {
        let regData =  """
{\"device_code\":\"VINHOMES_OPC_00004\",\"va_release_version_id\":1653911899461852567,\"asr_release_version_id\":1653921035257562939,\"tts_release_version_id\":1653921191625342767,\"va_agent_id\":1653292868813182109,\"device_model\":\"DEFAULT MODEL\",\"device_info\":{\"model\":\"DEFAULT MODEL\",\"manufacture\":\"\",\"vin\":\"VINHOMES_OPC_00001\",\"model_year\":0,\"fuel_capacity\":0,\"variant\":\"\",\"market\":\"\",\"car_type\":\"\",\"sw_version\":\"DEFAULT VERSION\",\"hw_version\":\"\"},\"device_type\":\"VINFAST\",\"device_public_key\":\"1\"}
"""
        
        NetworkAdapter.shared.setupAdapter(environment: AppEnvironment())
        AssistantClient.registerDevice(isDevMode: true,
                                       registrationData: regData,
                                       deviceCert: "",
                                       signature: "",
                                       isFromDevice: false).subscribe { appToken in
            print("DEBUG: \(appToken)")
        } onError: { error in
            print("DEBUG: \(error)")
        }.disposed(by: disposeBag)
    }
    
}

