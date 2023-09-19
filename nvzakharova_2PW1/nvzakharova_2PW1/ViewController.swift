//
//  ViewController.swift
//  nvzakharova_2PW1
//
//  Created by Наталья Захарова on 19.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonWasPressed(self)
        // Do any additional setup after loading the view.
    }
    
    func getRandomSize() -> CGSize {
        return CGSize(width: .random(in: 100...200), height: .random(in: 20...360))
    }
    
    func getRandomPoint() -> CGPoint {
        return CGPoint(x: .random(in: 100...200), y: .random(in: 20...360))
    }
    //Method getUniqueColors() returns an array of random colors.
    
    func getRandomColors() -> Set<UIColor> {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        
        return set
    }
    
    //Method  buttonWasPressed  about actions pressing a button.
    @IBAction func buttonWasPressed(_ sender: Any) {
        guard let button = sender as? UIButton else {
               return
           }
        button.setTitle("CLICK ME", for: .normal)
           var colorSet = getRandomColors()
           button.isEnabled = false
                for view in views {
                    UIView.animate(withDuration: 3.5, animations: {
                        view.backgroundColor = colorSet.popFirst()
                        view.layer.cornerRadius = CGFloat.random(in: 0...25)
                        view.frame.size = self.getRandomSize()
                        view.frame.origin = self.getRandomPoint()
                    }) { _ in
                        button.isEnabled = true
                    }
                }
            }
        }
        
