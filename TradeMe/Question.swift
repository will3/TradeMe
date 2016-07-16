//
//  Question.swift
//  TradeMe
//
//  Created by will3 on 16/07/16.
//  Copyright © 2016 will3. All rights reserved.
//

import Foundation
import ObjectMapper

class Question : Mappable {
    required init?(_ map: Map) { }
    init() { }
    func mapping(map: Map) {
        listingId <- map["ListingId"]
        listingQuestionId <- map["ListingQuestionId"]
        comment <- map["Comment"]
        commentDate <- map["CommentDate"]
        answer <- map["Answer"]
        answerDate <- map["AnswerDate"]
        isSellerComment <- map["IsSellerComment"]
    }
    
    var listingId = 0
    var listingQuestionId = 0
    var comment = ""
    var commentDate: NSDate?
    var answer = ""
    var answerDate: NSDate?
    var isSellerComment = false
    
    // Member not implemented
    // var AskingMember: Member?
}