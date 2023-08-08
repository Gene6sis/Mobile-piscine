import SwiftUI
import Foundation
import Expression

struct ContentView: View {
    @State private var calcul: String = "0"
    @State private var result: String = "0"
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
                .padding(.top, 10)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1) // Limite le texte à une seule ligne
                .truncationMode(.head)
                .minimumScaleFactor(1)
            Spacer()
            Text(result)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            HStack {
                CalculatorButton(text: "7", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "8", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "9", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "C", color: .gray, size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "AC", color: .gray, size: 70, calcul: $calcul, result: $result)
            }
            .padding(.horizontal)
            
            HStack {
                CalculatorButton(text: "4", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "5", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "6", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "+", color: .orange.opacity(0.8), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "-", color: .orange.opacity(0.8), size: 70, calcul: $calcul, result: $result)
            }
            .padding(.horizontal)
            
            HStack {
                CalculatorButton(text: "1", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "2", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "3", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "*", color: .orange.opacity(0.8), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "/", color: .orange.opacity(0.8), size: 70, calcul: $calcul, result: $result)
            }
            .padding(.horizontal)
            
            HStack {
                CalculatorButton(text: "0", color: .gray.opacity(0.3), size: 140, calcul: $calcul, result: $result)
                CalculatorButton(text: ".", color: .gray.opacity(0.3), size: 70, calcul: $calcul, result: $result)
                CalculatorButton(text: "=", color: .orange, size: 140, calcul: $calcul, result: $result)
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
    @Binding var calcul: String
    @Binding var result: String
    
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
        do {
            switch text {
            case "AC":
                calcul = "0"
                result = "0"
            case "C":
                calcul.removeLast()
                if calcul.count == 0 {
                    calcul = "0"
                }
            case "*", "/", "." :
                calcul += text
            case "-", "+" :
                if calcul == "0" {
                    calcul = text
                } else {
                    calcul += text
                }
            case "=":
                let expression = Expression(calcul)
                let res = try expression.evaluate()
                if res.isInfinite || res.isNaN {
                    result = "Error"
                } else {
                    result = String(format: "%f", res)
                }
            default:
                if calcul == "0" {
                    calcul = text
                } else if countDigitsFromEnd(calcul) < 9 {
                    calcul += text
                }
            }
        } catch {
            result = "Error"
        }
    }
    
    func countDigitsFromEnd(_ string: String) -> Int {
        var count = 0
        for character in string.reversed() {
            if character.isNumber {
                count += 1
            } else {
                break
            }
        }
        return count
    }

}
