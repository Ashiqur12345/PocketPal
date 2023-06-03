import SwiftUI

struct EntryView: View {
    @ObservedObject var viewModel: EntryViewModel
    
    var body: some View {
        VStack{
            Text(viewModel.title).font(.title).bold()
            Text(viewModel.time.formatted(date: .abbreviated, time: .shortened))
        
            Group{
                viewModel.isExpense ? Image(systemName: "rectangle.stack.badge.minus.fill") : Image(systemName: "rectangle.stack.badge.plus.fill")
            }
            .symbolRenderingMode(.multicolor)
            .font(.title)
            Text(String(viewModel.price)).font(.title).bold()
        }
        .navigationTitle(viewModel.title)
    }
    
    var listView: some View{
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                Text(viewModel.title).font(.title).bold()
                Text(viewModel.time.formatted(date: .abbreviated, time: .shortened))
            }
            Spacer()
            VStack(alignment: .trailing){
                Group{
                    viewModel.isExpense ? Image(systemName: "rectangle.stack.badge.minus.fill") : Image(systemName: "rectangle.stack.badge.plus.fill")
                }
                .symbolRenderingMode(.multicolor)
                .font(.title)
                Text(String(viewModel.price)).font(.title).bold()
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(viewModel: EntryViewModel(entry: Entry(context: PersistenceController.preview.viewContext)))
    }
}
