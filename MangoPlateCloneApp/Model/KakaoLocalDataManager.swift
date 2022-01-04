//
//  KakaoLocalDataManager.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2022/01/04.
//

import Foundation
import Alamofire

class KakaoLocalDataManager {
    //맛집 리스트 불러오는 함수.
    func fetchRestaurants(x: String, y: String, delegate: FirstVC) {

        let parameters: [String: [String]] = [
            "x": ["\(x)"],
            "y": ["\(y)"],
            "query": ["맛집"]
        ]


        AF.request(Constant.KAKAO_LOCAL_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Key.kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoLocalResponse.self) { response in

                switch response.result {
                case .success(let response):
                    print("🌊🌊🌊 Kakao decoded successful")
                    delegate.didRetrieveLocal(response: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
    
    func fetchCurrentLocation(x: String, y: String, completion: @escaping (String) -> Void) {
        let parameters: [String: [String]] = [
            "x": ["\(x)"],
            "y": ["\(y)"]
        ]
        
        AF.request(Constant.KAKAO_GEO_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Key.kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoGeoResponse.self) { response in
                switch response.result {
                case .success:
                    print("위치정보 받아오기 성공")
                    
                    if let locationString = response.value?.documents[0].region_2depth_name {
                        completion(locationString)
                    } else {
                        completion("현재 지역 정보 불러오기 실패")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

    }
}

