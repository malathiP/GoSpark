//
//  CGSize+Calculate.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/19/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

extension CGSize {
    
    public func aspectHeight(basedOnWidth width: CGFloat) -> CGFloat {
        
        let ratio = width/self.width
        let scaledHeight = self.height * ratio
        return scaledHeight
    }
}
