//
//  Model.swift
//  MasterDetail
//
//  Created by Mdo on 06/09/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import Foundation


struct Model<T> {
    private var object = [T]()
    
    mutating func insert(_ element:T){
        
        object.insert(element, at: 0)
        
    }
    
    mutating func remove(at index: Int){
        
        guard object.indices.contains(index)else{
            
            return
        }
        
        object.remove(at: index)
    }
    
    // accessing the elemets of the array by index
    
    subscript(index:Int) ->T?{
        
        return object.indices.contains(index) ? object[index] : nil
    }
    
    var count:Int{
        return object.count
    }
    

    
    
}
