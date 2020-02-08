//
//  Variables.swift
//  CalendarTexting
//
//  Created by Jairo Millan on 8/20/19.
//  Copyright © 2019 Jairo Millan. All rights reserved.
//

import Foundation
var date = Date()
var date0 = date.date_0()
let calendar = Calendar.current
var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)
var monthCaracter = calendar.monthSymbols[month-1]
