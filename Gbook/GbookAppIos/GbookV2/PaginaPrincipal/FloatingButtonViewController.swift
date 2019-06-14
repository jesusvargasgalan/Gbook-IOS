//
//  FloatingButtonViewController.swift
//  GbookV2
//
//  Created by macOS12 on 09/05/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import Foundation

public class FloatingButtonViewController: UIViewController {
    private var floatingButton: UIButton?
    // TODO: Replace image name with your own image:
    private let floatingButtonImageName = "a1"
    private static let buttonHeight: CGFloat = 75.0
    private static let buttonWidth: CGFloat = 75.0
    private let roundValue = FloatingButtonViewController.buttonHeight/2
    private let trailingValue: CGFloat = 15.0
    private let leadingValue: CGFloat = 15.0
    private let shadowRadius: CGFloat = 2.0
    private let shadowOpacity: Float = 0.5
    private let shadowOffset = CGSize(width: 0.0, height: 5.0)
    private let scaleKeyPath = "scale"
    private let animationKeyPath = "transform.scale"
    private let animationDuration: CFTimeInterval = 0.4
    private let animateFromValue: CGFloat = 1.00
    private let animateToValue: CGFloat = 1.05
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createFloatingButton()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        guard floatingButton?.superview != nil else {  return }
        DispatchQueue.main.async {
            self.floatingButton?.removeFromSuperview()
            self.floatingButton = nil
        }
        super.viewWillDisappear(animated)
    }
    
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        floatingButton?.backgroundColor = .white
        floatingButton?.setImage(UIImage(named: floatingButtonImageName), for: .normal)
        floatingButton?.addTarget(self, action: #selector(doThisWhenButtonIsTapped(_:)), for: .touchUpInside)
        constrainFloatingButtonToWindow()
        makeFloatingButtonRound()
        addShadowToFloatingButton()
        addScaleAnimationToFloatingButton()
    }
    
    // TODO: Add some logic for when the button is tapped.
    @IBAction private func doThisWhenButtonIsTapped(_ sender: Any) {
        print("Button Tapped")
    }
    
    private func constrainFloatingButtonToWindow() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.keyWindow,
                let floatingButton = self.floatingButton else { return }
            keyWindow.addSubview(floatingButton)
            keyWindow.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor,
                                                constant: self.trailingValue).isActive = true
            keyWindow.bottomAnchor.constraint(equalTo: floatingButton.bottomAnchor,
                                              constant: self.leadingValue).isActive = true
            floatingButton.widthAnchor.constraint(equalToConstant:
                FloatingButtonViewController.buttonWidth).isActive = true
            floatingButton.heightAnchor.constraint(equalToConstant:
                FloatingButtonViewController.buttonHeight).isActive = true
        }
    }
    
    private func makeFloatingButtonRound() {
        floatingButton?.layer.cornerRadius = roundValue
    }
    
    private func addShadowToFloatingButton() {
        floatingButton?.layer.shadowOffset = shadowOffset
        floatingButton?.layer.masksToBounds = false
        floatingButton?.layer.shadowRadius = shadowRadius
        floatingButton?.layer.shadowOpacity = shadowOpacity
    }
    

}
