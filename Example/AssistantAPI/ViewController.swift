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
        let regData =  """
{\"device_code\":\"VINHOMES_OPC_00001\",\"va_release_version_id\":1653911899461852567,\"asr_release_version_id\":1653921035257562939,\"tts_release_version_id\":1653921191625342767,\"va_agent_id\":1653292868813182109,\"device_model\":\"DEFAULT MODEL\",\"device_info\":{\"model\":\"DEFAULT MODEL\",\"manufacture\":\"\",\"vin\":\"VINHOMES_OPC_00001\",\"model_year\":0,\"fuel_capacity\":0,\"variant\":\"\",\"market\":\"\",\"car_type\":\"\",\"sw_version\":\"DEFAULT VERSION\",\"hw_version\":\"\"},\"device_type\":\"VINFAST\",\"device_public_key\":\"1\"}
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

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

