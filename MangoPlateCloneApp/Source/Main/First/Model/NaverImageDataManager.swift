//
//  NaverImageDataManager.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2022/01/04.
//

import Foundation
import Alamofire

class NaverImageDataManager {
    //주소와 이름을 통해  이미지 URL 불러오는 함수.
    func fetchImage(place_name: String, location: String, completion: @escaping (String) -> Void) {
        
        let params = [
            // 검색어를 가게 이름 + 주소로 설정
            "query" : "\(place_name))",
            // 하나의 항목만 필요하니까 1개
            "display" : "1",// 이부분 정수로 받아야해서 문제 생길 거 같은데 일단 해봐
            // 유사도 순으로 정렬
            "sort" : "sim"
        ]
        
        AF.request(Constant.NAVER_URL, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: Key.naverHeaders)
            .validate()
            .responseDecodable(of: NaverImageResponse.self) { response in
                switch response.result {
                case .success:
                    print("🌊🌊🌊 naver decoded  successful")
                    if let value = response.value {
                        if value.items.isEmpty {
                            print("no image")
                        } else {
                            completion(value.items[0].link)
                        }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    completion("요청실패")
                }
            }
    }
}
