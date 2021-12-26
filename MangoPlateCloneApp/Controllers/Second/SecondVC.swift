//
//  SecondVC.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Tabman
import Pageboy

class SecondVC: TabmanViewController {
    
    
    let tabName = ["EAT딜", "스토리", "Top리스트"]
    
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EATViewControllerVC") as! EATViewControllerVC
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoryViewControllerVC") as! StoryViewControllerVC
               
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TOPViewControllerVC") as! TOPViewControllerVC
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.buttons.customize { button in
            button.tintColor = .gray
            button.selectedTintColor = UIColor(named: "main")
        }
        
        bar.indicator.tintColor = UIColor(named: "main")
        bar.backgroundColor = .white
        
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
        
        let barSystem = bar.systemBar()
        
        barSystem.backgroundStyle = .flat(color: .white)
 
        addBar(barSystem, dataSource: self, at: .top)
        
    }
}


extension SecondVC: TMBarDataSource, PageboyViewControllerDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = tabName[index]
        item.image = UIImage(named: "image.png")
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
