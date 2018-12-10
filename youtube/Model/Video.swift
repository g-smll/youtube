//
//  Video.swift
//  youtube
//
//  Created by 陈纲 on 2018/11/24.
//  Copyright © 2018 陈纲. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}


