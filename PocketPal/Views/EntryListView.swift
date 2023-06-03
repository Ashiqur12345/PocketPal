import SwiftUI

struct EntryListView: View {
    @ObservedObject var viewModel: EntryListViewModel
    
    var body: some View {
        VStack{
            NavigationStack{
                List(viewModel.listItems){ entryViewModel in
                    NavigationLink{
                        EntryView(viewModel: entryViewModel)
                    } label: {
                        EntryView(viewModel: entryViewModel).listView
                    }
                }
            }
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(viewModel: EntryListViewModel(context: PersistenceController.preview.viewContext, dateRange: .init(start: .now, duration: 100)))
    }
}
