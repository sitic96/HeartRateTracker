//
//  MainViewController.swift
//  RateTracker
//
//  Created by Sitora Guliamova on 1/30/19.
//  Copyright © 2019 Sitora Guliamova. All rights reserved.
//

import UIKit
import SwiftGifOrigin

protocol SplashScreenViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol! { get set }
}

class SplashViewController: UIViewController, SplashScreenViewProtocol {
    @IBOutlet private weak var heartLoadingImageView: UIImageView!

    var presenter: SplashPresenterProtocol!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heartLoadingImageView.loadGif(asset: Const.loadingHeartAssetName)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension Const {
    static let loadingHeartAssetName = "loadHeart"
}
