//
//  StudentDataManager.swift
//  BLESample
//
//  Created by 蔡佳玲 on 2023/9/10.
//

import UIKit
import FirebaseFirestore

class StudentDataManager {
    
    func createStudent(model:StudentTable, completion: (() -> Void)? = nil) {
        let db = Firestore.firestore()
        
        let studentTable = model
        do {
            let documentReference = try db.collection("studentTable").addDocument(from: studentTable)
            print(documentReference.documentID)
            completion?()
        } catch {
            print(error)
        }
    }
    
    func fetchStudentList() {
        let db = Firestore.firestore()
        db.collection("studentTable").getDocuments { snapshot, error in
            guard let snapshot = snapshot else {return}
            let studentTable = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: StudentTable.self)
            }
            print(studentTable)
        }
    }
    
    func filterStudentList(cardID:Int, completion: @escaping(([StudentTable]) -> Void)) {
        let db = Firestore.firestore()
        db.collection("studentTable").whereField("cardID", isEqualTo: cardID).getDocuments { snapshot, error in
            guard let snapshot = snapshot else {return}
            let studentTable = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: StudentTable.self)
            }
            completion(studentTable)
            print(studentTable)
        }
    }

}
