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
    func moveMatchToFirstPlace(_ match: Match) {
        guard let index = sports.firstIndex(where: { $0.d == "SOCCER" }) else {
            return
        }
        if let matchIndex = sports[index].e.firstIndex(where: { $0 == match }) {
            sports[index].e.remove(at: matchIndex)
            sports[index].e.insert(match, at: 0)
        }
    }
    func moveLikedMatchToFront(match: Match) {

        guard match.isLiked else { return } // don't move if match isn't liked
        if let index = sports.firstIndex(where: { $0.d == match.d }), // find the index of the sport
            let matchIndex = sports[index].e.firstIndex(where: { $0.id == match.id }) // find the index of the match
        {
            let movedMatch = sports[index].e.remove(at: matchIndex) // remove the match from the sport's matches array
            sports[index].e.insert(movedMatch, at: 0) // insert the match at the front of the sport's matches array
        }
    }
    
}
