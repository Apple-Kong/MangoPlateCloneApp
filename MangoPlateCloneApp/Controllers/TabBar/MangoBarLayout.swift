//
//  MangoBarLayout.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import Foundation


import UIKit
import Tabman


//탭바 레이아웃 커스터마이징
class MangoBarLayout: TMBarLayout {
    
    // MARK: Defaults
    
    private struct Defaults {
        // 디폴트 컨텐츠 인셋 설정
        static let contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    // MARK: Properties
    // 스택뷰 프로퍼티
    private let stackView = UIStackView()
    //컨테이너 뷰가 담긴 어레이 프로퍼티
    private var containers = [MangoBarButtonContainer]()
    
    private var indicator = MangoBarIndicator()
    // MARK: Lifecycle
    //레이아웃 커스텀
    override func layout(in view: UIView) {
        
        
        //메인 컨텐츠 스택뷰 생성.
        let paddedStackView = UIStackView()
        view.addSubview(paddedStackView)
        
        view.addSubview(indicator)
        paddedStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paddedStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paddedStackView.topAnchor.constraint(equalTo: view.topAnchor),
            paddedStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paddedStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        paddedStackView.addArrangedSubview(stackView)

        // Apply a default content inset.
        contentInset = Defaults.contentInset
    }
    
    //버튼들 을 뷰에 추가.
    override func insert(buttons: [TMBarButton], at index: Int) {
        buttons.forEach { (button) in
            //각 버튼 별 버튼 컨테이너 생성
            let container = MangoBarButtonContainer(for: button)
            //스택뷰에 컨테이너 하나씩 추가
            stackView.addArrangedSubview(container)
            //컨테이너 어레이에 컨테이너 추가
            containers.append(container)
            
            // Make button containers 1/2 the width of the layout guide (view width).
            // 각 컨테이너의 넓이 제약조건을 layout guide 의 절반으로 설정
            container.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        }
    }
    
    
    // 동적으로 버튼 제거할 때 필요 나는 필요 없을 듯.
//    override func remove(buttons: [TMBarButton]) {
//        let containers = stackView.arrangedSubviews.compactMap({ $0 as? MangoBarButtonContainer })
//        let containersToRemove = containers.filter({ buttons.contains($0.button) })
//        containersToRemove.forEach { (container) in
//            stackView.removeArrangedSubview(container)
//            container.removeFromSuperview()
//        }
//    }

    //선택된 바 아이템이 가지는 현재 레이아웃의 영역을 계산하는 함수!
//    override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
//
//    }
    
    
    
//    //컨테이너의 위치를 변경하고자 할 떄 사용. 나는 필요 없을 듯.
//    private func updateContainerOffsets(for position: CGFloat) {

//    }
}
