//
//  ViewController.swift
//  WheatherApp
//
//  Created by Mac on 28.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let backGroundView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }


}
extension ViewController {
    func style() {
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.image = UIImage(named: "background")
        backGroundView.contentMode = .scaleAspectFill
    }
    
    func layout() {
        view.addSubview(backGroundView)
        //autoLayout
        NSLayoutConstraint.activate([
            backGroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
