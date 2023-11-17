//
//  Router.swift
//  ArchitecturesShowcase
//
//  Created by Наталья Захарова on 17.11.2023.
//

import UIKit

protocol RoutingLogic {
    func goToStart()
   
}

class Router : RoutingLogic {
    weak var vc: DisplayLogic?

    func goToStart(){
        vc.present(vc: MVCViewController(), animated: false)
    }
     
}

