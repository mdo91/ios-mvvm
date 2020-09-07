//
//  Presenter.swift
//  MasterDetail
//
//  Created by Mdo on 06/09/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation
import UIKit
// to pass it by reference to other viewControllers
class Presenter{
    
    // presenter needs to access the model
    
    private var model = Model<Observable<Date>>()
    
    func addEntry(){
        let dateObservable = Observable(Date())
        model.insert(dateObservable)
        
        
        dateObservable.bind = { _ in
            // update the tableView by sending a notification
            NotificationCenter.default.post(Notification(name: Notification.Name("updateUI")))
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
            
            dateObservable.value = Date()
        }
        
        
        
    }
    
    func removeEntry(at index: Int){
        
        model.remove(at: index)
    }
    
    subscript(index: Int)->String?{
        
        guard let date = model[index] else{
            
            return nil
        }
        
        return date.value.description
    }
    
    var count : Int{
        
        return model.count
    }
    
 
}
