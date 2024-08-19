//
//  Login.swift
//  Tochino
//
//  Created by Hugo Manzano on 18/07/24.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable { //enum para mostrar ambas vistas de reg y log
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        VStack{
            Image("TOCHINO")
                .resizable()
                .frame(width: 200, height: 200)
            VStack{
                Button { //este boton llama al caso login
                    authenticationSheetView = .login
                } label: {
                    Label("Entra con tu correo", systemImage: "envelope.fill")
                }
                .tint(.black)
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            Spacer().frame(height:200)
            HStack{
                Button{ //este boton llama al caso register
                    authenticationSheetView = .register
                } label: {
                    Text("¿No tienes cuenta?")
                    Text("Regístrate")
                        .underline()
                }
                .tint(.black)
            }
            Spacer().frame(height: 30)
        Text("Powered by Manzanita ")
            Spacer().frame(height: 30)
        }.sheet(item: $authenticationSheetView) { sheet in
            switch sheet {
            case .register:
                RegisterEmailView(authenticationViewModel: authenticationViewModel)
            case .login:
                LoginEmailView(authenticationViewModel: authenticationViewModel)
            }
            //se ocupa para lanzar las vistas
        }
    }
}

#Preview {
    AuthenticationView(authenticationViewModel: AuthenticationViewModel())
    
}
