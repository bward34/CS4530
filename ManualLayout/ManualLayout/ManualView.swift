//
//  ManualView.swift
//  ManualLayout
//
//  Created by Brandon Ward on 1/28/19.
//  Copyright © 2019 Brandon Ward. All rights reserved.
//

import UIKit

class ManualView: UIView {
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerView.frame = bounds
    }
}
