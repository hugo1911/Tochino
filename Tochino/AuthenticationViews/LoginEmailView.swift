import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var textFieldEmail: String = ""
    @State private var textFieldPassword: String = ""
    
    var body: some View {
        ZStack{
            Color.blue
                .edgesIgnoringSafeArea(.all) // Asegura que el color azul cubra toda la pantalla
            VStack {
                DismissView()
                    .padding(.top, 8)
                Image("TOCHINO")
                    .resizable()
                    .frame(width: 150, height: 150)
                Group {
                    Text("👋Saludos bienvenido a")
                    Text("Tochino")
                        .bold()
                        .underline()
                }
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .foregroundColor(.primary) // Cambiado .tint a .foregroundColor
                
                Group {
                    Text("Inicia sesión de nuevo para acceder")
                        .foregroundColor(.secondary) // Cambiado .tint a .foregroundColor
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                    
                    TextField("Ingresa tu correo", text: $textFieldEmail) // Añadido el enlace de texto
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 8)
                    
                    SecureField("Ingresa tu contraseña", text: $textFieldPassword) //
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 8)
                    Button("Inicia Sesión"){
                        authenticationViewModel.login(email: textFieldEmail, password: textFieldPassword)
                    }
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(.orange)
                    .cornerRadius(15)
                    if let messageError = authenticationViewModel.messageError{
                        Text(messageError)
                            .bold()
                            .font(.body)
                            .foregroundStyle(.red)
                            .padding(.top, 20)
                    }
                }
                .padding(.top, 20) // Añadido padding para separar el grupo del título
            }
            .padding() // Padding general para la vista
        }
    }
}

#Preview {
    LoginEmailView(authenticationViewModel: AuthenticationViewModel())
}
