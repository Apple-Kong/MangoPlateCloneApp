//
//  NaverData.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/26.
//

import Foundation

struct NaverData: Decodable {
    let lastBuildDate: String // date time 타입이라는 데 뭔지 모르겠음
    let total: Int
    let start: Int
    let display: Int
    let items: [ImageData]
}

struct ImageData: Decodable {
    let title: String
    let link: String
    let thumbnail: String
    let sizeheight: String
    let sizewidth: String
}
