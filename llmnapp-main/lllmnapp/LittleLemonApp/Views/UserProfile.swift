

import SwiftUI

struct UserProfile: View {
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var name = ""
    @State private var email = ""
    
    
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
            VStack(spacing: 5) {
                VStack {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                }
                
                VStack{
                    Text("Name")
                        .onboardingTextStyle()
                    TextField("Name", text: $name)
                }
                
                    
                
                
                VStack {
                    Text("Email")
                        .onboardingTextStyle()
                    TextField("Your email", text: $email)
                        .keyboardType(.emailAddress)
                }
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding()
            
            Text("Email notifications")
                .font(.regularText())
                .foregroundColor(.primaryColor1)
            VStack {
                Toggle("Order statuses", isOn: $orderStatuses)
                Toggle("Password changes", isOn: $passwordChanges)
                Toggle("Special offers", isOn: $specialOffers)
                Toggle("Newsletter", isOn: $newsletter)
            }
            .padding()
            .font(Font.leadText())
            .foregroundColor(.primaryColor1)
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: key_IsLoggedIn)
                UserDefaults.standard.set("", forKey: key_Name)
                UserDefaults.standard.set("", forKey: key_Email)
                UserDefaults.standard.set(false, forKey: key_OrderStatuses)
                UserDefaults.standard.set(false, forKey: key_PasswordCh)
                UserDefaults.standard.set(false, forKey: key_SpecialOffers)
                UserDefaults.standard.set(false, forKey: key_NewsLetter)
                isLoggedOut = true
            }
            .buttonStyle(ButtonStyleYellowColorWide())
            Spacer(minLength: 20)
            HStack {
                Button("Discard Changes") {
                    name = viewModel.name
                    email = viewModel.email
                    
                    orderStatuses = viewModel.orderStatuses
                    passwordChanges = viewModel.passwordChanges
                    specialOffers = viewModel.specialOffers
                    newsletter = viewModel.newsletter
                    self.presentation.wrappedValue.dismiss()
                }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
                Button("Save changes") {
                    if viewModel.validateUserInput(name: name, email: email) {
                        UserDefaults.standard.set(name, forKey: key_Name)
                        UserDefaults.standard.set(email, forKey: key_Email)
                        UserDefaults.standard.set(orderStatuses, forKey: key_OrderStatuses)
                        UserDefaults.standard.set(passwordChanges, forKey: key_PasswordCh)
                        UserDefaults.standard.set(specialOffers, forKey: key_SpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: key_NewsLetter)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                    .buttonStyle(ButtonStylePrimaryColor1())
            }
            if viewModel.isErrorMessageVisible {
                withAnimation() {
                    Text(viewModel.errorMessageText)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            
        }
        .onAppear {
            name = viewModel.name
            email = viewModel.email
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
