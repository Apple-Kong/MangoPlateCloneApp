//
//  MangoBarIndicator.swift
//  MangoPlateCloneApp
//
//  Created by GOngTAE on 2021/12/23.
//

import UIKit
import Tabman



class MangoBarIndicator: TMLineBarIndicator {
    
    
    public enum DisplayMode {
        case top
        case bottom
        case fill
    }
    
    open override var displayMode: TMBarIndicator.DisplayMode {
        return .top
    }
    
    private var indicatorView = UIView()
    
    override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(indicatorView)
        
        indicatorView.backgroundColor = .orange
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        // Create your indicator in `view`.
    }
}
