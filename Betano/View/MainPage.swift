//
//  MainPage.swift
//  Betano
//
//  Created by Pantos, Thomas on 28/4/23.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject var viewModel = SportsViewModel()
    @State private var isloggedIn: Bool = false
    @State private var isLiked = false
    @State private var football = Image("soccerball")
    @State var LogoName: String = "Betano"
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    Spacer()
                    soccerList
                    basketList
                    
                    tennisList
                    tableTennis
                    eSports
                    
                    beachVolleyList
                }.background(Color.black)
                
            }
            
            .navigationBarTitle(LogoName)
            .toolbarBackground(Color.yellow, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
          
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("\(Image(systemName: "person.fill"))") {
                                print("Help tapped!")
                            }
                        }
                        
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button() {
                                self.isloggedIn.toggle()
                            } label: {
                                isloggedIn ? Text("Exit"): Text("Login")
                            }
                            
                        }
                    
                }
            
        }
        
        .onAppear {
            viewModel.fetchSports()
        }
      
    }




    var soccerList: some View {
        VStack(alignment: .leading) {
            GroupBox(){
                DisclosureGroup("\(Image(systemName: "soccerball"))Football") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.sports.filter { $0.d == "SOCCER" }) { sport in
                                ForEach(sport.e) { match in


                                    WindowMatch(text1: match.d, text2: match.i, startTime: match.tt, viewModel: viewModel)
                                        


                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    
    var basketList: some View {
        VStack(alignment: .leading) {
            GroupBox(){
                DisclosureGroup("\(Image(systemName: "basketball"))Basketball") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.sports.filter { $0.d == "BASKETBALL" }) { sport in
                                ForEach(sport.e) { match in


                                    WindowMatch(text1: match.d, text2: match.i, startTime: match.tt, viewModel: viewModel)


                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }

    
    var tennisList: some View {
        VStack(alignment: .leading) {
            GroupBox(){
                DisclosureGroup("\(Image(systemName: "tennisball.fill"))Tennis") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.sports.filter { $0.d == "TENNIS" }) { sport in
                                ForEach(sport.e) { match in


                                    WindowMatch(text1: match.d, text2: match.i, startTime: match.tt, viewModel: viewModel)


                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    
    
    var tableTennis: some View {
        VStack(alignment: .leading) {
            GroupBox(){
                DisclosureGroup("\(Image(systemName: "figure.table.tennis"))Ping Pong") {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.sports.filter { $0.d == "TABLE TENNIS" }) { sport in
                                ForEach(sport.e) { match in


                                    WindowMatch(text1: match.d, text2: match.i, startTime: match.tt, viewModel: viewModel)


                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    var eSports: some View {
        VStack(alignment: .leading) {
            GroupBox(){
                DisclosureGroup("\(Image(systemName: "gamecontroller.fill"))Esports") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.sports.filter { $0.d == "ESPORTS" }) { sport in
                                ForEach(sport.e) { match in


                                    WindowMatch(text1: match.d, text2: match.i, startTime: match.tt, viewModel: viewModel)


                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    var beachVolleyList: some View {
        VStack(alignment: .leading) {
            GroupBox(){
                DisclosureGroup("\(Image(systemName: "figure.volleyball"))Beach Volley") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.sports.filter { $0.d == "BEACH VOLLEYBALL" }) { sport in
                                ForEach(sport.e) { match in


                                    WindowMatch(text1: match.d, text2: match.i, startTime: match.tt, viewModel: viewModel)


                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
        
}


        


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

struct ColoredGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
         
            }
            
            configuration.content
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(.blue)) // Set your color here!!
    }
}
