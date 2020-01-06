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
    @IBOutlet weak var selectCharacter: UIButton!
    
    // MARK: Properties
    private let intent = MainIntent()
    private let disposeBag = DisposeBag()
    
    var selectedAlert: UIAlertController?
        
    // MARK: Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtons()
        intent.bind(toView: self)
        selectedAlert = UIAlertController(title: "You selected",
                                          message: "",
                                          preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { _ in self.intent.onDismissCharacter() }
        selectedAlert?.addAction(dismiss)
    }
    
    public func update(withState state: HeroState) {
        switch state {
        case is HeroPresenting:
            let heroState = state as! HeroPresenting
            showPresentState(withPresentState: heroState)
            break
        case is HeroSelected:
            let heroState = state as! HeroSelected
            showSelectedState(withHeroName: heroState.hero.name)
            break
        default:
            break
        }
    }
    
    private func showPresentState(withPresentState state: HeroPresenting) {
        let hero = state.hero
        nameLabel.text = hero.name
        imageView.image = UIImage(named: hero.name)
        speed.progress = hero.speed / 10
        power.progress = hero.power / 10
        stamina.progress = hero.stamina / 10
        
        nextCharacter.isEnabled = state.nextAvailable
        previousCharacter.isEnabled = state.previousAvailable
    }
    
    private func showSelectedState(withHeroName name: String) {
        guard let alert = selectedAlert else { return }
        alert.message = name
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Methods
    private func bindButtons() {
        previousCharacter.rx.tap.bind {
            self.intent.onPreviousCharacterClicked()
        }.disposed(by: disposeBag)
        
        nextCharacter.rx.tap.bind {
            self.intent.onNextCharacterClicked()
        }.disposed(by: disposeBag)
        
        selectCharacter.rx.tap.bind {
            self.intent.onSelectCharacter()
        }.disposed(by: disposeBag)
    }
    
    
}

