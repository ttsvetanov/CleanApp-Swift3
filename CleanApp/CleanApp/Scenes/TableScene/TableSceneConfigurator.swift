//
//  TableSceneConfigurator.swift
//  CleanApp
//
//  Created by Vitaliy Podolskiy on 22/07/2016.
//  Copyright (c) 2016 InstaRobot.NET. All rights reserved.
//

import UIKit

extension TableSceneViewController: TableScenePresenterOutput {
  /// Переопределяем сегвей для контроллера
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    router.passDataToNextScene(segue: segue)
  }
}

extension TableSceneInteractor: TableSceneViewControllerOutput {}
extension TableScenePresenter: TableSceneInteractorOutput {}

class TableSceneConfigurator {
  /// Настройка производится лишь один раз
  class var sharedInstance: TableSceneConfigurator {
    return TableSceneConfigurator()
  }
  
  /// Настройка и конфигурация контроллера
  func configure(viewController: TableSceneViewController) {
    /// Создаем роутер
    let router = TableSceneRouter()
    router.viewController = viewController
    /// Создаем презентер
    let presenter = TableScenePresenter()
    presenter.output = viewController
    /// Создаем интерактор
    let interactor = TableSceneInteractor()
    interactor.output = presenter
    /// Связываем контроллер с иницированными зависимостями
    viewController.output = interactor
    viewController.router = router
  }
  
}
