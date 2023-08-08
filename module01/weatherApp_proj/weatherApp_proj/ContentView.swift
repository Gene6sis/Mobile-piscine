import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .currently
    @State private var searchText: String = ""
    @State private var searchInput: String = ""


    enum Tab: Hashable {
        case currently
        case today
        case weekly
        
        var title: String {
            switch self {
            case .currently:
                return "currentText"
            case .today:
                return "todayText"
            case .weekly:
                return "weekText"
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
                AppBar(searchText: $searchText, searchInput: $searchInput)
                TabView(selection: $selectedTab) {
                    CurrentlyView(searchText: $searchText)
                        .tag(Tab.currently)
                    TodayView(searchText: $searchText)
                        .tag(Tab.today)
                    WeeklyView(searchText: $searchText)
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
    @Binding var searchText: String
    @Binding var searchInput: String
    
    var body: some View {
        HStack {
            TextField("searchText", text: $searchInput, onCommit: {
                            // Update searchText when the user presses "Enter"
                            searchText = searchInput
                            searchInput = ""
            })
                .padding(.horizontal, 16)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            Button(action: {
                searchText = "Geolocation"
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
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
                .font(.largeTitle)
            Text("currentText")
                .foregroundColor(.black)
            if !searchText.isEmpty {
                Text("\(searchText)")
                    .foregroundColor(.black)
            }
        }
    }
}

struct TodayView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            Image(systemName: "calendar")
                .font(.largeTitle)
            Text("todayText")
                .foregroundColor(.black)
            if !searchText.isEmpty {
                Text("\(searchText)")
                    .foregroundColor(.black)
            }
        }
    }
}

struct WeeklyView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.clock")
                .font(.largeTitle)
            Text("weekText")
                .foregroundColor(.black)
            if !searchText.isEmpty {
                Text("\(searchText)")
                    .foregroundColor(.black)
            }
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
        .frame(height: 50.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
