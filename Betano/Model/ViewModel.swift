//
//  SportModel.swift
//  Betano
//
//  Created by Pantos, Thomas on 28/4/23.
//

import Foundation

class SportsViewModel: ObservableObject {
    @Published var sports: [Sport] = []
    @Published var matches: [Match] = []
    
    
    
    
    
        func fetchSports() {
            fetchSports1 { [weak self] sports, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let sports = sports {
                        self.sports = sports
                        
                        print("success")
                        
                    } else if let error = error {
    
                        print(error)
                    }
    
                }
            }
        }
    
}
