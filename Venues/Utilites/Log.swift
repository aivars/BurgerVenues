//
//  Log.swift
//  Venues
//
//  Created by Aivars Meijers on 22/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import Foundation
import os.log

struct Log {
    static var general = OSLog (
    subsystem: "com.aivarsmeijers.Venues", category: "general")
}
