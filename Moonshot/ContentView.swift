//
//  ContentView.swift
//  Moonshot
//
//  Created by Raymond Chen on 2/23/22.
//

import SwiftUI

struct ContentView: View {
    
    struct ContentScrollView: View {
        let astronauts: [String: Astronaut]
        let missions: [Mission]
        let columns: [GridItem]
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label : {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height:  100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                            
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
    
    struct GridLayout: View {
        let astronauts: [String: Astronaut]
        let missions: [Mission]
        let columns =  [
            GridItem(.adaptive(minimum: 150))
        ]
        
        var body: some View {
            ContentScrollView(astronauts: astronauts, missions: missions, columns: columns)
        }
    }
    
    struct ListLayout: View {
        let astronauts: [String: Astronaut]
        let missions: [Mission]
        let columns =  [
            GridItem(.adaptive(minimum: .infinity))
        ]
        
        var body: some View {
            ContentScrollView(astronauts: astronauts, missions: missions, columns: columns)
        }
    }
    
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingGrid = true
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle(showingGrid ? "Grid View" : "List View", isOn: $showingGrid)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
