//
//  ContentView.swift
//  weatherApp_proj
//
//  Created by Adam Toons on 31/07/2023.
//

import SwiftUI

//
//  ContentView.swift
//  weatherApp_proj
//
//  Created by Adam Toons on 31/07/2023.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .currently

    enum Tab: Hashable {
        case currently
        case today
        case weekly
        
        var title: String {
            switch self {
            case .currently:
                return "Currently"
            case .today:
                return "Today"
            case .weekly:
                return "Weekly"
            }
        }
        
        var icon: String {
            switch self {
            case .currently:
                return "sun.max.fill"
            case .today:
                return "calendar"
            case .weekly:
                return "calendar.badge.clock"
            }
        }


    }
    
    let tabs: [Tab] = [.currently, .today, .weekly] //

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                AppBar()

                TabView(selection: $selectedTab) {
                    CurrentlyView()
                        .tag(Tab.currently)
                    TodayView()
                        .tag(Tab.today)
                    WeeklyView()
                        .tag(Tab.weekly)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .navigationBarHidden(true)

                FooterTabBar(selectedTab: $selectedTab, tabs: tabs)
                
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}

struct AppBar: View {
    var body: some View {
        HStack {
            TextField("Search", text: .constant(""))
                .padding(.horizontal, 16)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .foregroundColor(.black)
            Button(action: {
                // Perform geolocation action
            }) {
                Image(systemName: "location.circle.fill")
                    .font(.title)
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
        .padding(.bottom, 8)
        .background(Color.gray)
        .foregroundColor(.white)
    }
}

struct CurrentlyView: View {
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
                .font(.largeTitle)
            Text("Currently")
                .foregroundColor(.black)
        }
    }
}

struct TodayView: View {
    var body: some View {
        VStack {
            Image(systemName: "calendar")
                .font(.largeTitle)
            Text("Today")
                .foregroundColor(.black)
        }
    }
}

struct WeeklyView: View {
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.clock")
                .font(.largeTitle)
            Text("Weekly")
                .foregroundColor(.black)
        }
    }
}

struct FooterTabBar: View {
    @Binding var selectedTab: ContentView.Tab
    let tabs: [ContentView.Tab] // Receive the tabs array.

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in // Use the tabs array for ForEach.
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack {
                        Image(systemName: tab.icon)
                            .font(.title)
                        Text(tab.title)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(selectedTab == tab ? .white : .gray)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(selectedTab == tab ? Color.gray : Color.clear)
                }
            }
        }
        .frame(height: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
