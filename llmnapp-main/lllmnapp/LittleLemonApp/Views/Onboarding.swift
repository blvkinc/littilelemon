

import SwiftUI

struct Onboarding: View {
    @StateObject private var viewModel = ViewModel()
    
    @State var name = ""
    @State var email = ""
    
    
    @State var isKeyboardVisible = false
    @State var contentOffset: CGSize = .zero
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Header()
                    Hero()
                        .padding()
                        .background(Color.primaryColor1)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                    VStack {

                        NavigationLink(destination: EmptyView()) { }.navigationDestination(isPresented: $isLoggedIn) {
                            Home()
                        }
                        Text("Name *")
                            .onboardingTextStyle()
                        TextField("First Name", text: $name)
                        Text("E-mail *")
                            .onboardingTextStyle()
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()
                    
                    if viewModel.isErrorMessageVisible {
                        withAnimation() {
                            Text(viewModel.errorMessageText)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    
                    Button("Register") {
                        if viewModel.validateUserInput(name: name, email: email) {
                            UserDefaults.standard.set(name, forKey: key_Name)
                            UserDefaults.standard.set(email, forKey: key_Email)
                            UserDefaults.standard.set(true, forKey: key_IsLoggedIn)
                            UserDefaults.standard.set(true, forKey: key_OrderStatuses)
                            UserDefaults.standard.set(true, forKey: key_PasswordCh)
                            UserDefaults.standard.set(true, forKey: key_SpecialOffers)
                            UserDefaults.standard.set(true, forKey: key_NewsLetter)
                            name = ""
                            email = ""
                            isLoggedIn = true
                        }
                    }
                    .buttonStyle(ButtonStyleYellowColorWide())
                    
                    
                    Spacer()
                }
                .offset(y: contentOffset.height)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    withAnimation {
                        let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let keyboardHeight = keyboardRect.height
                        self.isKeyboardVisible = true
                        self.contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                    }
                    
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        self.isKeyboardVisible = false
                        self.contentOffset = .zero
                    }
                }
            }
            .onAppear() {
                if UserDefaults.standard.bool(forKey: key_IsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
        .navigationBarBackButtonHidden()
        
        
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
