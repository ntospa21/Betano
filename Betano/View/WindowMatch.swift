//
//  WindowMatch.swift
//  Betano
//
//  Created by Pantos, Thomas on 29/4/23.
//

import SwiftUI


enum ColorSchemeOption: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
}


struct WindowMatch: View {
    let text1: String
    let text2: String
    let startTime: Int
    @ObservedObject var viewModel = SportsViewModel()
    @State private var remainingTime = 60
    @State  var isLiked = false
    @Environment(\.colorScheme) var colorScheme
    
    
    var boy: some View {
        Text(colorScheme == .dark ? "In dark mode" : "In light mode")
        
    }

    var body: some View {
        VStack {
            HStack {
                
                
             
                CountdownTimerView(targetTimestamp: TimeInterval(startTime))
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                     
                    
                
            }
            HStack(alignment: .center) {
                Button(action: {
                        toggleLiked()
                    
                    print("the match \(text1.split(separator: "-")) is \(isLiked)")
                }, label: {
                    Image(systemName: self.isLiked == true ? "star.fill" : "star")
                })
                
            }
            
            VStack {
                let components = text1.split(separator: "-")
                Text(String(components[0]))
                    .fixedSize()
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        Spacer()
                           Text(String(components[1]))
                    .fixedSize()
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                Spacer()
            }

        }
        .frame(width: 200, height: 80)
        .padding()
        .background(colorScheme == .dark ? Color.white : Color.black)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 3, y: 3)
        
        
    }
    
    private func getSizeForText(text1: String) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let textWidth = text1.widthOfString(usingFont: UIFont.systemFont(ofSize: 24))
        if textWidth > screenWidth - 100 {
            return 16
        } else {
            return 24
        }
    }

    
    func convertUnixTimestampToEET(unixTimestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EET")
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        return dateFormatter.string(from: date)
        
    }
    func toggleLiked() {
        self.isLiked.toggle()
        
        if let index = viewModel.sports.firstIndex(where: { $0.d == "SOCCER" }),
           let matchIndex = viewModel.sports[index].e.firstIndex(where: { $0.i == self.text2 }) {
            
            let match = viewModel.sports[index].e.remove(at: matchIndex)
            print("first matchIndex: \(matchIndex)")
            if self.isLiked {
                // Move the item to the first position of the list
                viewModel.sports[index].e.insert(match, at: 0)
                print(matchIndex)
            } else {
                // Move the item back to its original position
                var originalIndex = matchIndex
                for i in 0..<viewModel.sports[index].e.count {
                    if !viewModel.sports[index].e[i].isLiked && i > matchIndex {
                        originalIndex += 1
                    }
                }
                viewModel.sports[index].e.insert(match, at: originalIndex)
                print(originalIndex)
            }
        }
    }








}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}




struct WindowMatch_Previews: PreviewProvider {
    static var previews: some View {
        WindowMatch(text1: "Dummy Data", text2: "check", startTime: 1680860640, isLiked: true)
    }
}
