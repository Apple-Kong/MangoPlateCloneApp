//
//  MangoBarButton.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import Foundation


import UIKit
import Tabman

class MangoBarButton: TMBarButton {
    
    // MARK: Defaults
    
    //바 버튼 아이템의 이미지 크기.
    private struct Defaults {
        static let imageSize = CGSize(width: 30, height: 30)
        //미 선택시 크기 축소
        static let unselectedScale: CGFloat = 0.8
    }
    
    // MARK: Properties
    //버튼의 이미지 프로퍼티
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override var tintColor: UIColor! {
        didSet {
            update(for: self.selectionState)
        }
    }
    
    //보니까 UI 관련 변수 받을 때마다 업데이트 함수 호출해주네!!
    //선택 안받았을 때 틴트컬러
    var unselectedTintColor: UIColor = .lightGray {
        didSet {
            update(for: self.selectionState)
        }
    }
    
    // MARK: Lifecycle
    
    override func layout(in view: UIView) {
        super.layout(in: view)
        
        adjustsAlphaOnSelection = false
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 10)])
        
        //이미지 뷰 추가후 constraint 수정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -6),
            imageView.widthAnchor.constraint(equalToConstant: Defaults.imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Defaults.imageSize.height )
            ])
    }
    
    //Populate the button with a bar item.
    
    //각 버튼 아이템에 이미지 설정. 순회 가능한 아이템들이 전달됨
    override func populate(for item: TMBarItemable) {
        super.populate(for: item)
        label.text = titleToText(title: item.title! )
        imageView.image = item.image
    }
    
    
    private func titleToText(title: String) -> String? {
        
        if title == "Find" {
            return "맛집찾기"
        } else if title == "Pick" {
            return "망고픽"
        } else if title == "News" {
            return "소식"
        } else {
            return "내정보"
        }
    }
    
    //버튼의 상태 변경시 호출될 UI 업데이트 함수.
    override func update(for selectionState: TMBarButton.SelectionState) {
        super.update(for: selectionState)
        
        
        //자신이 선택 되었는지에 따라 색 조절.
        
        //문제발생
//        imageView.tintColor = unselectedTintColor.interpolate(with: tintColor, percent: selectionState.rawValue)
//        label.tintColor =
        
        switch selectionState {
        case .selected:
            imageView.tintColor = TinderColors.primaryTint
            label.textColor = TinderColors.primaryTint
        case .unselected:
            imageView.tintColor = TinderColors.unselectedGray
            label.textColor = TinderColors.unselectedGray
        default:
            imageView.tintColor = TinderColors.unselectedGray
            label.textColor = TinderColors.unselectedGray
        }
        
        //자신이 선택 되었는지에 따라 크기 조절
        let scale = 1.0 - ((1.0 - selectionState.rawValue) * (1.0 - Defaults.unselectedScale))
        
        //크기변경
        imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        label.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
