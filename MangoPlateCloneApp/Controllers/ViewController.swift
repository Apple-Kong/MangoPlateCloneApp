//
//  ViewController.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Tabman
import Pageboy

class ViewController: TabmanViewController {
    
    // 탭 목록
    enum Tab: String, CaseIterable {
        case find
        case pick
        case news
        case my
    }
    
    //탭 목록 바 아이템 가지고 있는 어레이로 생성
    private let tabItems = Tab.allCases.map({ BarItem(for: $0) })
    
    private lazy var viewControllers = tabItems.compactMap({ $0.makeViewController() })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        self.dataSource = self
//        isScrollEnabled = false
        let systemBar = MangoBar.make().systemBar()
        
        systemBar.backgroundStyle = .flat(color: .white)
        
        addBar(systemBar, dataSource: self, at: .bottom)
    }


}

extension ViewController: PageboyViewControllerDataSource, TMBarDataSource {
        func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
            return viewControllers.count
        }
        
        func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
            return viewControllers[index]
        }
        
        func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
            return .at(index: 0)
        }
        
        func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
            return tabItems[index]
        }
    }



class CustomBarIndicator: TMBarIndicator {
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .top
    }
}



private class BarItem: TMBarItemable {
    
    let tab: ViewController.Tab
    
    init(for tab: ViewController.Tab) {
        self.tab = tab
    }
    
    private var _title: String? {
        return tab.rawValue.capitalized
    }
    
    var title: String? {
        get {
            return _title
        } set {}
    }
    
    private var _image: UIImage? {
        return UIImage(named: "ic_\(tab.rawValue)")
    }
    
    var image: UIImage? {
        get {
            return _image
        } set {}
    }
    
    var badgeValue: String?
    
    func makeViewController() -> UIViewController? {
        let storyboardId: String
        switch tab {
        case .find:
            storyboardId = "FirstVC"
        case .pick:
            storyboardId = "SecondVC"
        case .news:
            storyboardId = "ThirdVC"
        case .my:
            storyboardId = "FourthVC"
        }
        
//        return UIStoryboard(name: storyboardId, bundle: nil).instantiateInitialViewController()
        
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardId)
    }
}
