//
//  GenericViewController.swift
//  AwesomePhotos
//
//  Created by Apple on 3/28/19.
//  Copyright © 2019 Minh Quang Pham. All rights reserved.
//

import UIKit

//Generic view controller from which all other view controllers are going to inherit
public class GenericViewController<View: GenericView> : UIViewController {
    internal var contentView : View {
        return view as! View
    }
    
    public override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func loadView() {
        view = View()
    }
}
