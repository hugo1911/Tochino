import SwiftUI

struct DismissView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Text("Cerrar")
                    .font(.subheadline) // Tamaño de la fuente más pequeño
                    .foregroundColor(.black)
                    .padding(8) // Padding reducido
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.trailing, 12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    DismissView()
}
