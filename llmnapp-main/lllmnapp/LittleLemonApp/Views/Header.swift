
import SwiftUI

struct Header: View {
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            HStack {
                
                    Image("logo").resizable().aspectRatio(contentMode: .fit)
                    HStack {
                        Spacer()
                        if isLoggedIn {
                            NavigationLink(destination: UserProfile()) {
                                Image("profile-image-placeholder")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(maxHeight: 100)
                                    .padding(.trailing)
                            }
                        }
                    
                }
            }
        }
        .frame(maxHeight: 100)
        .padding(.bottom)
        .onAppear() {
            if UserDefaults.standard.bool(forKey: key_IsLoggedIn) {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
