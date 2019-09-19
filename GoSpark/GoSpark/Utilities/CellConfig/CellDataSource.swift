//
//  CellDataSource.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

public protocol CellDataSource {
    
    static var identifer : String { get }
    static var className : AnyClass { get }
}

