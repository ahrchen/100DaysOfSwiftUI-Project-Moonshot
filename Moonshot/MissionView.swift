//
//  MissionView.swift
//  Moonshot
//
//  Created by Raymond Chen on 2/25/22.
//

import SwiftUI

struct MissionView: View {
    
    struct AstronautScrollView: View {
        let crew: [CrewMember]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id:\.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaunt)
                        } label: {
                            HStack {
                                Image(crewMember.astronaunt.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                .white,
                                                lineWidth: 1
                                            )
                                    )
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaunt.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct MySpacer: View {
        var body: some View {
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding(.vertical)
        }
    }
    
    struct CrewMember {
        let role: String
        let astronaunt: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    Text(mission.formattedLongLaunchDate)
                    
                    MySpacer()
                   
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
                    
                    MySpacer()
                    
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .font(.title.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                  
                    AstronautScrollView(crew: crew)
                    
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaunt: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission:  missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
