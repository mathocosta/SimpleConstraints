//
//  SimpleConstraints.swift
//
//
//  Created by Matheus Oliveira Costa on 29/08/20.
//

import UIKit

public typealias Constraint = (_ view: UIView, _ superview: UIView) -> NSLayoutConstraint

// MARK: - NSLayoutAnchor
public func constraint<Axis, Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    equalTo otherAnchor: KeyPath<UIView, Anchor>,
    constant: CGFloat = 0
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { (view, superview) in
        view[keyPath: anchor].constraint(equalTo: superview[keyPath: otherAnchor],
                                         constant: constant)
    }
}

public func constraint<Axis, Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    lessThanOrEqualTo otherAnchor: KeyPath<UIView, Anchor>,
    constant: CGFloat = 0
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { (view, superview) in
        view[keyPath: anchor].constraint(
            lessThanOrEqualTo: superview[keyPath: otherAnchor],
            constant: constant
        )
    }
}

public func constraint<Axis, Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    greaterThanOrEqualTo otherAnchor: KeyPath<UIView, Anchor>,
    constant: CGFloat = 0
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { (view, superview) in
        view[keyPath: anchor].constraint(
            greaterThanOrEqualTo: superview[keyPath: otherAnchor],
            constant: constant
        )
    }
}

// MARK: - NSLayoutDimension
public func equal<Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    toConstant constant: CGFloat
) -> Constraint where Anchor: NSLayoutDimension {
    return { (view, _) in
        view[keyPath: anchor].constraint(equalToConstant: constant)
    }
}

public func lessThanOrEqual<Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    toConstant constant: CGFloat
) -> Constraint where Anchor: NSLayoutDimension {
    return { (view, _) in
        view[keyPath: anchor].constraint(lessThanOrEqualToConstant: constant)
    }
}

public func greaterThanOrEqual<Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    toConstant constant: CGFloat
) -> Constraint where Anchor: NSLayoutDimension {
    return { (view, _) in
        view[keyPath: anchor].constraint(greaterThanOrEqualToConstant: constant)
    }
}

// MARK: - Shorthands, helpers
public func equal<Axis, Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    constant: CGFloat = 0
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    constraint(anchor, equalTo: anchor)
}

public func lessThanOrEqual<Axis, Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    constant: CGFloat = 0
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    constraint(anchor, lessThanOrEqualTo: anchor)
}

public func greaterThanOrEqual<Axis, Anchor>(
    _ anchor: KeyPath<UIView, Anchor>,
    constant: CGFloat = 0
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    constraint(anchor, greaterThanOrEqualTo: anchor)
}

public func prioritize(_ constraint: @escaping Constraint,
                       as priority: UILayoutPriority) -> Constraint {
    return { (view, superview) in
        let layoutConstraint = constraint(view, superview)
        layoutConstraint.priority = priority

        return layoutConstraint
    }
}

extension Array where Element == Constraint {
    public static var edges: [Constraint] {
        return [equal(\.topAnchor),
                equal(\.bottomAnchor),
                equal(\.leadingAnchor),
                equal(\.trailingAnchor)]
    }

    @available(iOS 11.0, *)
    public static var safeAreaEdges: [Constraint] {
        return [equal(\.safeAreaLayoutGuide.topAnchor),
                equal(\.safeAreaLayoutGuide.bottomAnchor),
                equal(\.safeAreaLayoutGuide.leadingAnchor),
                equal(\.safeAreaLayoutGuide.trailingAnchor)
        ]
    }
}

extension UIView {
    public func addSubview(_ child: UIView, constraints: [Constraint]) {
        addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.map { $0(child, self) })
    }
}
