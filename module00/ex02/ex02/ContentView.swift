import SwiftUI

var result: String = "0"
var calcul: String = "0"

struct ContentView: View {
    
    // Gestion de la taille mode paysage ou portrait avec padding different
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var verticalPadding: CGFloat {
        if verticalSizeClass == .regular && horizontalSizeClass == .compact {
            // Cas de l'iPhone en orientation portrait
            return 60
        } else {
            // Autres cas (orientation paysage, iPad, etc.)
            return 30
        }
    }

    
    var body: some View {
        VStack {
            Text("Calculatrice")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, verticalPadding) // Déplace le texte plus bas
                            .padding(.bottom, 10) // Ajoute du rembourrage en bas
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
            Text(calcul)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10) // Déplace le texte plus bas
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
            Text(result)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            HStack {
                CalculatorButton(text: "7", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "8", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "9", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "C", color: .gray, size: 70)
                CalculatorButton(text: "AC", color: .gray, size: 70)
            }
            .padding(.horizontal)
            
            HStack {
                CalculatorButton(text: "4", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "5", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "6", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "+", color: .orange.opacity(0.8), size: 70)
                CalculatorButton(text: "-", color: .orange.opacity(0.8), size: 70)
            }
            .padding(.horizontal)
            
            HStack {
                CalculatorButton(text: "1", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "2", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "3", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "x", color: .orange.opacity(0.8), size: 70)
                CalculatorButton(text: "/", color: .orange.opacity(0.8), size: 70)
            }
            .padding(.horizontal)
            
            HStack {
                CalculatorButton(text: "0", color: .gray.opacity(0.3), size: 140)
                CalculatorButton(text: ",", color: .gray.opacity(0.3), size: 70)
                CalculatorButton(text: "=", color: .orange, size: 140)
            }
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.top)
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalculatorButton: View {
    var text: String
    var color: Color
    var size: CGFloat
    
    var body: some View {
        Button(action: {
            buttonTapped()
        }) {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: size, height: 50)
                .background(color)
                .cornerRadius(40)
        }
    }
    
    func buttonTapped() {
        print("Button tapped: \(text)")
        result = result + text
        // Ajoutez votre logique pour chaque bouton ici
    }
}
