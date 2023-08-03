

import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView() { Text("Loading Image...") }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .frame(minHeight: 200)
            Text(dish.title ?? "")
                .bold()
                .font(.subTitleFont())
                .foregroundColor(.primaryColor1)
            Spacer(minLength: 55)
            Text(dish.descriptionDish ?? "")
                .font(.regularText())
            Spacer(minLength: 10)
            Text("$" + (dish.price ?? ""))
                .font(.highlightText())
                .foregroundColor(.primaryColor1)
                .monospaced()
            Spacer()
        }
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.createDishExampleForDesigner())
    }
}
