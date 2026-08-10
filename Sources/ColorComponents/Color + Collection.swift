//
//  Color + Collection.swift
//  ColorComponents
//
//  Created by Vaida on 2026-08-10.
//


extension ColorComponents: MutableCollection {
    
    @inlinable
    public var startIndex: Int { 0 }
    
    @inlinable
    public var endIndex: Int { 4 }
    
    @inlinable
    public func index(after i: Int) -> Int { i &+ 1 }
    
}
