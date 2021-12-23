//
//  MangoBar.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import Tabman

class MangoBar {
    
    //타입 자체가 템플릿이 달라서 인디케이터가 보이지 않음
    typealias BarType = TMBarView<MangoBarLayout, MangoBarButton, TMBarIndicator.None>
    
    static func make() -> TMBar {
        let bar = BarType()
        
        bar.scrollMode = .swipe
        bar.buttons.customize { (button) in
            //색관련 정보 저장해주어야하는듯.
            button.tintColor = TinderColors.primaryTint
            button.unselectedTintColor = TinderColors.unselectedGray
        }
        
        bar.backgroundView.style = .flat(color: .white)
        
        
        bar.layout.transitionStyle = .snap
        
        

        return bar
    }
}
