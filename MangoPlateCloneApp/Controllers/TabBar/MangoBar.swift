//
//  MangoBar.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import Tabman

class MangoBar {
    
    typealias BarType = TMBarView<MangoBarLayout, MangoBarButton, MangoBarIndicator>
    
    static func make() -> TMBar {
        let bar = BarType()
        
        bar.scrollMode = .swipe
        bar.buttons.customize { (button) in
            //색관련 정보 저장해주어야하는듯.
            button.tintColor = TinderColors.primaryTint
            button.unselectedTintColor = TinderColors.unselectedGray
        }
        
        bar.layout.transitionStyle = .snap
        
        

        return bar
    }
}
