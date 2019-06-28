//
//  LogoView.swift
//  RateTracker
//
//  Created by Sitora on 27/06/2019.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit

@IBDesignable

class LogoView: UIView {

    var contentView : UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadViewFromNib()

        // use bounds not frame or it'll be offset
        contentView!.frame = bounds

        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }

    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let n = UINib(nibName: "LogoView",
                      bundle: bundle)
//        let nib = UINib(nibName: "LogoView"),
//                        bundle: bundle)
        let view = n.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

}
