//
//  Color + Methods.swift
//  ColorComponents
//
//  Created by Vaida on 2026-08-10.
//


extension ColorComponents {
    
    /// Multiplies the opacity of the color by the given amount.
    public func opacity(_ opacity: Double) -> ColorComponents {
        ColorComponents(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha * opacity)
    }
    
    /// Mix `self` with `other` by the given `fraction`.
    public func mix(
        with other: ColorComponents,
        by fraction: Double
    ) -> ColorComponents {
        ColorComponents(
            red: (1 - fraction) * self.red + fraction * other.red,
            green: (1 - fraction) * self.green + fraction * other.green,
            blue: (1 - fraction) * self.blue + fraction * other.blue,
            alpha: (1 - fraction) * self.alpha + fraction * other.alpha
        )
    }
    
}
