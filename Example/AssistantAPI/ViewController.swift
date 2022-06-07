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
    
    @IBAction func generateAudioDidTouch() {
        self.generateAudio()
    }
    
    func pushMessage() {
        AssistantClient.pushMessage(message: "Cho tôi hỏi Ocean Park rộng bao nhiêu ha?",
                                    vaAgenId: "1653292868813182109",
                                    nlpFeature: ["DIALOG"])
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap({ messageId -> Single<VAResponse> in
                return AssistantClient.getVAResponse(by: messageId)
            }).subscribe { response in
            print("DEBUG: getVAResponse by session id ")
            print(response)
                for item in response.vaData?.dmResponse?.botMessage ?? [] {
                    print("DEBUG: type \(item.type)")
                    print("DEBUG: value \(item.getBotMessageValueObject())")
                }
                
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
    
    func generateAudio() {
        AssistantClient.generateAudio(text: "quanh hồ tây có nhà hàng nào không 1? tôi muốn tìm nhà hàng", languageCode: "vi_vn", voiceName: "female_south2", generator: "melgan", acousticModel: "fastspeech2", style: "news", ouputFormat: "mp3").subscribe(onSuccess: { audioResponse in
            print("DEBUG: \(audioResponse)")
        }, onFailure: { error in
            print("DEBUG: \(error)")
        }).disposed(by: disposeBag)
    }
    
}

