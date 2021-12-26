//
//  RestInfo.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/26.
//

import Foundation
import UIKit


struct RestInfo {
    
    //추가하는 url
    var urlString: String?
    
    var url: URL? {
        guard let urlString = urlString else {
            return nil
        }

        return URL(string: urlString)
    }
    
    var image: UIImage? {
        do {
            if let url = url {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    let detail: Restaurant

}
