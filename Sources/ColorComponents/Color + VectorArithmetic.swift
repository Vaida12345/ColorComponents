//
//  Color + VectorArithmetic.swift
//  ColorComponents
//
//  Created by Vaida on 2026-08-10.
//

import SwiftUI
import simd


extension ColorComponents: VectorArithmetic {
    
    @inlinable
    public static func - (lhs: ColorComponents, rhs: ColorComponents) -> ColorComponents {
        ColorComponents(lhs.components - rhs.components)
    }
    
    @inlinable
    public static func + (lhs: ColorComponents, rhs: ColorComponents) -> ColorComponents {
        ColorComponents(lhs.components + rhs.components)
    }
    
    public static let zero = ColorComponents(red: 0, green: 0, blue: 0, alpha: 0)
    
    @inlinable
    public mutating func scale(by rhs: Double) {
        self.components *= rhs
    }
    
    @inlinable
    public var magnitudeSquared: Double {
        simd_dot(self.components, self.components)
    }
}
