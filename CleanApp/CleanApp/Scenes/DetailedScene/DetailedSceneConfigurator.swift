//
//  DetailedSceneConfigurator.swift
//  CleanApp
//
//  Created by Vitaliy Podolskiy on 22/07/2016.
//  Copyright (c) 2016 InstaRobot.NET. All rights reserved.
//

import UIKit
import XCDYouTubeKit

extension DetailedSceneViewController: DetailedScenePresenterOutput {
  /// Переопределяем сегвей для контроллера
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    router.passDataToNextScene(segue: segue)
  }
}

extension DetailedSceneInteractor: DetailedSceneViewControllerOutput {}
extension DetailedScenePresenter: DetailedSceneInteractorOutput {}

class DetailedSceneConfigurator {
  /// Настройка производится лишь один раз
  class var sharedInstance: DetailedSceneConfigurator {
    return DetailedSceneConfigurator()
  }
  
  /// Настройка и конфигурация контроллера
  func configure(viewController: DetailedSceneViewController) {
    /// Создаем роутер
    let router = DetailedSceneRouter()
    router.viewController = viewController
    /// Создаем презентер
    let presenter = DetailedScenePresenter()
    presenter.output = viewController
    /// Создаем интерактор
    let interactor = DetailedSceneInteractor()
    interactor.output = presenter
    /// Связываем контроллер с иницированными зависимостями
    viewController.output = interactor
    viewController.router = router
    /// Создаем плеер для последующей работы с ним
    viewController.videoPlayerViewController = XCDYouTubeVideoPlayerViewController()
  }
  
}
