//
//  MangoBar.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import Tabman

class MangoBar {
    
    //타입 자체가 템플릿이 달라서 인디케이터가 보이지 않음
    typealias BarType = TMBarView<TMConstrainedHorizontalBarLayout, TMTabItemBarButton, MangoBarIndicator>
    
    static func make() -> TMBar {
        let bar = BarType()
        
       
        bar.scrollMode = .swipe
        bar.buttons.customize { (button) in
            //색관련 정보 저장해주어야하는듯.
            button.tintColor = .gray
            button.selectedTintColor = TinderColors.primaryTint
        }
        
        bar.backgroundView.style = .flat(color: .white)
        bar.backgroundColor = .white
        
        bar.layout.transitionStyle = .snap
        
        

        return bar
    }
}
