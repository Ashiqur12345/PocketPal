import SwiftUI

struct EntryInputView: View {
    
    @ObservedObject var viewModel: EntryInputViewModel
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        VStack{
            Form{
                Section("Mandatory"){
                    TextField("Extry Title", text: $viewModel.entryTitle)
                    TextField("Price", value: $viewModel.entryPrice, format: .number)
                }
                Section("Expense / Income?"){
                    Toggle(.init("Expense/Income? Answer: **\(viewModel.entryIsExprense ? "Expense" : "Income")**"), isOn: $viewModel.entryIsExprense)
                }
                
                Section("Date"){
                    DatePicker("Entry Date", selection: $viewModel.entryTime, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("More About this Entry"){
                    TextField("Details", text: $viewModel.entryDetails, axis: .vertical)
                                .lineLimit(3, reservesSpace: true)
                }
                
                Section("Add Tags"){
                    HStack{
                        Spacer()
                        Text("Tag List Here")
                        Spacer()
                    }
                }
            }
            
            Section{
                Text(viewModel.errorMessage).foregroundColor(.red)
            }
            Section{
                Button{
                    viewModel.submitForm()
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(minWidth: 150)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 20).fill(.green)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Button{
                    viewModel.cancel()
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .frame(minWidth: 150)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 20).fill(.red.opacity(0.8))
                        )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(presentation.wrappedValue.isPresented)
    }
}

struct EntryInputView_Previews: PreviewProvider {
    static var previews: some View {
        EntryInputView(viewModel: EntryInputViewModel(context: PersistenceController.preview.viewContext))
    }
}
