//
//  MangoBarButtonContainer.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Tabman

//버튼을 UIView 에 담음.
class MangoBarButtonContainer: UIView {
    
    // MARK: Properties
    
    //internal : 같은 모듈(framework) or 같은 프로젝트 내에서만 접근 가능한 접근 제한자.
    //swift Access Control 공식문서 읽어 볼것,.
    internal let button: TMBarButton
    
    
    //constraint 관련 프로퍼티
    private var xAnchor: NSLayoutConstraint!
    
    var offsetDelta: CGFloat = 0.0 {
        didSet {
            xAnchor.constant = offsetDelta * (button.frame.size.width)
        }
    }
    
    // MARK: Init
    // 버튼 객체를 전달함으로서 컨테이너 객체 생성
    init(for button: TMBarButton) {
        self.button = button
        
        //UIView 초기화
        // Initializes and returns a newly allocated view object with the specified frame rectangle.
        super.init(frame: .zero)
        
        //초기화 함수. 버튼 전달.
        initialize(with: button)
    }
    
    
    //뭔소린지 모르겠음.
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Supported")
    }
    
    
    //초기화 관련함수 constraint 설정.
    private func initialize(with button: TMBarButton) {
        
        xAnchor = button.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        addSubview(button)
        
        //resizing 허용하지 않음.
        button.translatesAutoresizingMaskIntoConstraints = false
        // Y축 센터, top, bottom 맞닿게,  leading trailing 침범 안하게 설정.
        NSLayoutConstraint.activate([
            xAnchor,
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: button.trailingAnchor)
            ])
    }
}
