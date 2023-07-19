import SwiftUI

struct ContentView: View {
    @State private var buttonPressedNb = 0

    var buttonText : String {
        if buttonPressedNb % 2 == 1 {
            return "A simple text"
        } else {
            return "Hello World !"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(buttonText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                buttonPressedNb += 1
            }) {
                Text("Click :)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
