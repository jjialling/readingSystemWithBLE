//
//  StudentTable.swift
//  BLESample
//
//  Created by 蔡佳玲 on 2023/9/10.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct StudentTable: Codable, Identifiable {
    @DocumentID var id: String?
    let cardID: Int
    let name: String
    let studentID: Int
    let seatNumber: Int
    let gender: String
    let birth: String
    let classroom: String
}
