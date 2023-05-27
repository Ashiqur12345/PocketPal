import SwiftUI

struct EntryInputView: View {
    
    @ObservedObject var viewModel: EntryInputViewModel
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Mandatory"){
                    TextField("Extry Title", text: $viewModel.entryTitle)
                    TextField("Price", value: $viewModel.entryPrice, format: .currency(code: "BDT"))
                }
                Section("Expense / Income?"){
                    Toggle(.init("Expense/Income? Answer: \(viewModel.entryIsExprense ? "**Expense**" : "**Income**")"), isOn: $viewModel.entryIsExprense)
                }
                
                Section("Date"){
                    DatePicker("Entry Date", selection: $viewModel.entryDate, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("More About this Entry"){
                    TextField("Address", text: $viewModel.entryDetails, axis: .vertical)
                                .lineLimit(3, reservesSpace: true)
                }
                
                Section("Add Tags"){
                    HStack{
                        Spacer()
                        Text("Tag List Here")
                        Spacer()
                    }
                }
                
                Section{
                    Button{
                        
                    } label: {
                        Text("Save changes")
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                    }
                    
                    Button{
                    } label: {
                        Text("Cancel")
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                    }
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button{
                } label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                }
            }
            
            ToolbarItem{
                Button{
                    
                } label: {
                    Text("Save changes")
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                }
            }
        }
//        .navigationBarBackButtonHidden(true)
    }
    
}

struct EntryInputView_Previews: PreviewProvider {
    static var previews: some View {
        EntryInputView(viewModel: EntryInputViewModel(context: PersistenceController.preview.viewContext))
    }
}
