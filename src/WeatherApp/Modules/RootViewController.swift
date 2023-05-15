//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 15.05.2023.
//
import UIKit

final class RootViewController: UIViewController {
    private let moduleView = RootView()

    override func loadView() {
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
