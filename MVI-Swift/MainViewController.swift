//
//  ViewController.swift
//  MVI-Swift
//
//  Created by Marcel Kulina on 06.01.20.
//  Copyright © 2020 Broken Bytes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var speed: UIProgressView!
    @IBOutlet weak var power: UIProgressView!
    @IBOutlet weak var stamina: UIProgressView!
    
    @IBOutlet weak var previousCharacter: UIButton!
    @IBOutlet weak var nextCharacter: UIButton!
    // MARK: Properties
    private let intent = MainIntent()
    private let disposeBag = DisposeBag()
        
    // MARK: Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtons()
        intent.bind(toView: self)
    }
    
    public func update(withState state: HeroState) {
        switch state {
        case is HeroState.HeroPresenting:
            let heroState = state as! HeroState.HeroPresenting
            let hero = heroState.hero
            nameLabel.text = hero.name
            imageView.image = UIImage(named: hero.name)
            speed.progress = hero.speed / 10
            power.progress = hero.power / 10
            stamina.progress = hero.stamina / 10
            break
        case is HeroState.HeroSelected:
            break
        default:
            break
        }
    }
    
    // MARK: Methods
    private func bindButtons() {
        previousCharacter.rx.tap.bind {
            self.intent.onPreviousCharacterClicked()
        }.disposed(by: disposeBag)
        
        nextCharacter.rx.tap.bind {
            self.intent.onNextCharacterClicked()
        }.disposed(by: disposeBag)
    }
    
    
}

