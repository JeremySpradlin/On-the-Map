//
//  GCDBlackBox.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 11/27/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.sync {
        updates()
    }
}
