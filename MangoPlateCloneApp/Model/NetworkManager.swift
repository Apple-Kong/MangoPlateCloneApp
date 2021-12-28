//
//  NetworkManager.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/26.
//

import Foundation
import Alamofire

class NetworkManager {

    
    let parameters: [String: [String]] = [
        "x": ["127.06283102249932"],
        "y": ["37.514322572335935"],
        "query": ["강남 맛집"]
    ]
    
    let kakaoHeaders: HTTPHeaders = [
        "Authorization": "KakaoAK 98b807749ed5ea240799ffe5ae51b1b4"
    ]
    
    let naverHeaders: HTTPHeaders = [
        "X-Naver-Client-Id" : "UnEPRBm5dkfZ_8EXRe8I",
        "X-Naver-Client-Secret" : "YlEqSjADOZ"
    ]
    
    
    
    
    //맛집 리스트 불러오는 함수.
    func fetchRestaurants(completion: @escaping ([Restaurant]) -> Void) {
        
        var restaurants: [Restaurant] = []
        
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoData.self) { response in

                switch response.result {
                case .success:
                    print("🌊🌊🌊 Kakao decoded successful")
                    if let restaurantList = response.value?.documents {
                        restaurants = restaurantList
                        completion(restaurants)
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    
    
    
    //주소와 이름을 통해  이미지 URL 불러오는 함수.
    func fetchImage(roadAddressName: String, place_name: String, completion: @escaping (String) -> Void) {
        
        let params = [
            // 검색어를 가게 이름 + 주소로 설정
            "query" : "\(place_name) \(roadAddressName)",
            // 하나의 항목만 필요하니까 1개
            "display" : "1", // 이부분 정수로 받아야해서 문제 생길 거 같은데 일단 해봐
            // 유사도 순으로 정렬
            "sort" : "sim"
        ]
        AF.request("https://openapi.naver.com/v1/search/image", method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: naverHeaders)
            
            .validate()
            .responseDecodable(of: NaverData.self) { response in
                switch response.result {
                case .success:
                    print("🌊🌊🌊 naver decoded  successful")
                    if let link = response.value?.items[0].link {
                        completion(link)
                    }
                case let .failure(error):
                    print(error)
                    completion("fail")
                }
            }
    }
}



