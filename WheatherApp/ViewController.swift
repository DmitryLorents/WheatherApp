//
//  ViewController.swift
//  WheatherApp
//
//  Created by Mac on 28.02.2023.
//

import UIKit

class ViewController: UIViewController {
    let locationButton = UIButton()
    let searchButton = UIButton()
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
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        
        searchButton.translatesAutoresizingMaskIntoConstraints =  false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
    }
    
    func layout() {
        //add views
        view.addSubview(backGroundView)
        view.addSubview(locationButton)
        view.addSubview(searchButton)
        
        //autoLayout
        
        NSLayoutConstraint.activate([
            backGroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            locationButton.heightAnchor.constraint(equalToConstant: 44),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchButton.trailingAnchor, multiplier: 1),
            searchButton.heightAnchor.constraint(equalTo: locationButton.heightAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor)
        ])
    }
}
