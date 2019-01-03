//
//  SearchableRecord.swift
//  Timeline
//
//  Created by Brady Bentley on 1/2/19.
//  Copyright © 2019 Brady. All rights reserved.
//

import Foundation
import CloudKit

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
