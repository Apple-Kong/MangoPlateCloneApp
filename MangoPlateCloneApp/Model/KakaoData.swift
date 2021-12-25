//
//  KakaoData.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/26.
//

import Foundation

struct KakaoData: Decodable {
    let documents: [Restaurant]
    let meta: MetaContainer
    struct MetaContainer: Decodable {
        let is_end: Bool
        let pageable_count: Int
        let same_name: RegionInfo
        
        struct RegionInfo: Decodable {
            let keyword: String
            let region: [String]
            let selected_region: String
        }
        let total_count: Int
    }
}


struct Restaurant: Decodable {
    let address_name: String
    let category_group_code: String
    let category_group_name: String
    let category_name: String
    let distance: String
    let id: String
    let phone: String
    let place_name: String
    let place_url: String
    let road_address_name: String
    let x: String
    let y: String
}



