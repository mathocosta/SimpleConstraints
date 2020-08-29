//
//  ViewController.swift
//  Example
//
//  Created by Matheus Oliveira Costa on 29/08/20.
//

import UIKit
import SimpleConstraints

class ViewController: UIViewController {

    let leftBox = UIView()
    let centerBox = UIView()
    let rightBox = UIView()

    let threeBoxesWrapper = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        threeBoxesWrapper.backgroundColor = .systemGray
        leftBox.backgroundColor = .systemRed
        centerBox.backgroundColor = .systemGreen
        rightBox.backgroundColor = .systemBlue

        view.addSubview(threeBoxesWrapper, constraints: [
            equal(\.safeAreaLayoutGuide.topAnchor, constant: 8),
            equal(\.leadingAnchor, constant: 8),
            equal(\.trailingAnchor, constant: -8),
            equal(\.heightAnchor, toConstant: 100)
        ])

        let topConstraint = equal(\.topAnchor, constant: 4)
        let bottomConstraint = equal(\.bottomAnchor, constant: -4)

        threeBoxesWrapper.addSubview(leftBox, constraints: [
            topConstraint,
            equal(\.leadingAnchor, constant: 4),
            bottomConstraint
        ])

        threeBoxesWrapper.addSubview(centerBox, constraints: [
            topConstraint,
            bottomConstraint
        ])

        threeBoxesWrapper.addSubview(rightBox, constraints: [
            topConstraint,
            equal(\.trailingAnchor, constant: -4),
            bottomConstraint
        ])

        let leadingEqualToTrailing = constraint(\.leadingAnchor,
                                                equalTo: \.trailingAnchor,
                                                constant: 8)

        let trailingEqualToLeading = constraint(\.leadingAnchor,
                                                equalTo: \.trailingAnchor,
                                                constant: 8)

        NSLayoutConstraint.activate([
            leftBox.widthAnchor.constraint(equalTo: threeBoxesWrapper.widthAnchor, multiplier: 0.3),
            leadingEqualToTrailing(centerBox, leftBox),
            trailingEqualToLeading(centerBox, rightBox)
        ])
    }

}

