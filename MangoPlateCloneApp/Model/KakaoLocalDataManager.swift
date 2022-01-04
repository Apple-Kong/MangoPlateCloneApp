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


        AF.request(Constant.KAKAO_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Key.kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoResponse.self) { response in

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
}
