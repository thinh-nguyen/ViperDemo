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

public struct DocumentModel {
    var documentId: String = ""
    var title: String = ""
    var matchSentence: String = ""
    var url: String = ""
    var reach: Int = 0
    
    
    public init?(json: [String: Any]) {
        guard
            let documentId = json["documentId"] as? String,
            let title = json["title"] as? String,
            let matchSentence = json["openingText"] as? String,
            let url = json["url"] as? String,
            let reach = json["reach"] as? Int
            else { return nil }
        
        self.documentId = documentId
        self.title = title
        self.matchSentence = matchSentence
        self.url = url
        self.reach = reach
        
    }
}

extension DocumentModel: Mappable {
    
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
        documentId        <- map["documentId"]
        title             <- map["title"]
        matchSentence     <- map["matchSentence"]
        url               <- map["url"]
        reach             <- map["reach"]
    }
}

class DocumentUIModel {
    var displayTitle = MutableProperty("")
    var displayMatchSentence = MutableProperty("")
    var displayUrl = "Unknown"
    
    public init?(document: DocumentModel) {
        self.displayTitle.value = document.title
        
        var openingString = document.matchSentence
        if( openingString.count > 240) {
            let index = openingString.index(openingString.startIndex, offsetBy: 236)
            openingString = "\(openingString[..<index])"
        }
        self.displayMatchSentence.value = openingString
        self.displayUrl = document.url
        
    }
}

public struct DocQuery {
    var dupDocsCapSize: Int = 5
    var country: String = "us"
    var pageSize: Int = 20
    var groupFrom: Int = 0
    var dateEnd: String = "2017-11-07T20:00:19.028Z"
    var sortOrder: String = "DESC"
    var groupOption: String = "close"
    var dateStart: String = "2017-11-02T19:01:49.000Z"
    var agents: String = "3173387"
    var page: Int = 0
    var sortField: String = "date"
    var additionalFields: String = "images"
}

extension DocQuery: Mappable {
    public init?(map: Map) {
        mapping(map: map)
    }
    
    mutating public func mapping(map: Map) {
        dupDocsCapSize      <- map["dupDocsCapSize"]
        country             <- map["country"]
        pageSize            <- map["pageSize"]
        groupFrom           <- map["groupFrom"]
        dateEnd             <- map["dateEnd"]
        sortOrder           <- map["sortOrder"]
        groupOption         <- map["groupOption"]
        dateStart           <- map["dateStart"]
        agents              <- map["agents"]
        page                <- map["page"]
        sortField           <- map["sortField"]
        additionalFields    <- map["additionalFields"]
    }
}

public struct DocumentsPage {
    var count: Int = 0
    var documents: [DocumentModel] = []
}

extension DocumentsPage: Mappable {
    
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
        count     <- map["count"]
        documents <- map["documents"]
    }
}

