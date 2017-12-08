//
//  DocumentListEntity.swift
//  ViperDemo
//
//  Created by Thinh Nguyen on 12/3/17.
//  Copyright © 2017 Prospertin. All rights reserved.
//

import Foundation
import ObjectMapper
import ReactiveSwift

class DocumentModel {
    
}

class DocumentUIModel {
    
}

public struct DocQuery {
    
}

extension DocQuery: Mappable {
    public init?(map: Map) {
        mapping(map: map)
    }
    
    mutating public func mapping(map: Map) {
       
    }
}
