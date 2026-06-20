//
//  ContentView.swift
//  12-app
//
//  Created by mostafa on 16/06/2026.
//

import SwiftUI


// 1. Define your data model
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

struct Item2: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
}

struct ContentView: View {
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                NavigationLink(destination: LocalView()){
                    Text("Local")
                }
                NavigationLink(destination: StorageView()) {
                    Text("Storage")
                }
                //.padding()
            }
            
        }
        
    }
    

    
}


// storage
struct StorageView: View {
    
    
    
    @State private var showingAddView = false
    
    @State private var items: [Item2] = StorageView.loadItems()
    
   
    static func loadItems() -> [Item2] {
        if let data = UserDefaults.standard.data(forKey: "saved_items") {
            if let decoded = try? JSONDecoder().decode([Item2].self, from: data) {
                return decoded
                }
            }
        
    
    //
    return [
        Item2(name: "Apfel", description: "Knackig, süß-säuerlich und reich an Vitaminen."),
        Item2(name: "Banane", description: "Ein praktischer, energiereicher Snack für unterwegs.")
    ]
        
    }
    
    func saveItems(){
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "saved_items")
        }
    }
    
    private func deleteItems(at offsets: IndexSet){
        items.remove(atOffsets: offsets)
        saveItems()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: Details(item: item)){
                            Text(item.name)
                                //.font(.headline)
                                //.padding(.vertical, 8)
                        }
                   }
                    // delete
                    .onDelete(perform: deleteItems)
                    /*.onDelete { indexSet in
                                        items.remove(atOffsets: indexSet)
                                    }*/
            }
                .navigationTitle("Meine Storage Liste")
                // button add-item
                .navigationBarItems(trailing:
                
                Button(action: {
                    showingAddView = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
                )
                
                // display as sheet
                .sheet(isPresented: $showingAddView){
                    AddStorageItemView(items: $items,
                                       onSave: saveItems
                    )
                }
                //
                .onAppear{
                    self.items = StorageView.loadItems()
                }
            }
            //.padding()
        }
        
    }
    
    
    
    
    
}
struct AddStorageItemView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var items: [Item2]
    var onSave: () -> Void
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Frucht-Details") ) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("New Item")
            .navigationBarItems(leading:
                                    Button("Cancel"){
                presentationMode.wrappedValue.dismiss()
            }
            , trailing:
                                    Button("Save") {
                let newItem = Item2(name: name, description: description)
                items.append(newItem)
                onSave()
                
                // close
                presentationMode.wrappedValue.dismiss()
            }
                .disabled(name.isEmpty)
            )
            
        }
    }
}


struct Details: View {
    let item: Item2
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.name)
                .font(.largeTitle)
                .bold()
            Text(item.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle(item.name)
    }
}



// local


struct LocalView: View {
    
    @State private var items = [
        /*Item(name: "Apple", description: "A crunchy red fruit."),
         Item(name: "Banana", description: "A long yellow fruit."),
         Item(name: "Cherry", description: "A small round red fruit."),
         */
        Item(name: "Apfel", description: "Knackig, süß-säuerlich und reich an Vitaminen."),
        Item(name: "Banane", description: "Ein praktischer, energiereicher Snack für unterwegs."),
        Item(name: "Erdbeere", description: "Süße Sommerbeere, perfekt für Desserts geeignet."),
        /*Item(name: "Blaubeere", description: "Kleine, dunkelblaue Frucht voller Antioxidantien."),
        Item(name: "Himbeere", description: "Zarte, samtige Beere mit einem intensiv süßen Aroma."),
        Item(name: "Mango", description: "Exotische, saftige Steinfrucht mit sattgelbem Fruchtfleisch."),
        Item(name: "Ananas", description: "Tropische Frucht mit einer süß-sauren, erfrischenden Note."),
        Item(name: "Orange", description: "Zitrusfrucht mit viel Saft und einem hohen Vitamin-C-Gehalt."),
        Item(name: "Zitrone", description: "Sehr saure Zitrusfrucht, ideal zum Verfeinern von Speisen."),
        Item(name: "Limette", description: "Kleine grüne Zitrusfrucht mit einem spritzigen Aroma."),
        Item(name: "Weintraube", description: "Kleine, saftige Beeren, die ideal zum Snacken sind."),
        Item(name: "Wassermelone", description: "Sehr wasserhaltig und die perfekte Abkühlung im Sommer."),
        Item(name: "Pfirsich", description: "Samtige Haut und ein süßes, sehr saftiges Fruchtfleisch."),
        Item(name: "Kirsche", description: "Kleine, tiefrote Steinfrucht mit einem süßen Kern."),
        Item(name: "Pflaume", description: "Dunkellila Frucht, die sich super für Kuchen eignet."),
        Item(name: "Kiwi", description: "Grünes Fruchtfleisch mit kleinen, essbaren schwarzen Samen."),
        Item(name: "Avocado", description: "Cremige, milde Frucht mit vielen gesunden Fetten."),
        Item(name: "Granatapfel", description: "Gefüllt mit roten, saftigen und leicht herben Kernen."),
        Item(name: "Feige", description: "Süße, weiche Frucht mit einer einzigartigen Textur."),
        Item(name: "Birne", description: "Heimische Frucht mit einer weichen, süßen Konsistenz.")*/
    ]
    
    @State private var showingAddView = false
    
   
    
    var body: some View {
        NavigationView {
            VStack {
            /*Button(action: {
                showingAddView = true
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                Text("Add")
            })*/
            
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: LocalDetails(item: item)){
                            Text(item.name)
                                //.font(.headline)
                                //.padding(.vertical, 8)
                        }
                   }
                    // delete
                    //.onDelete(perform: deleteItems)
                    .onDelete { indexSet in
                                        items.remove(atOffsets: indexSet)
                                    }
            }
                .navigationTitle("Meine Lokal Liste")
                // button add-item
                .navigationBarItems(trailing:
                
                Button(action: {
                    showingAddView = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
                )
                
                // display as sheet
                .sheet(isPresented: $showingAddView){
                    AddLocalItemView(items: $items)
                }
            }
            //.padding()
        }
        
    }
    
    
    
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
}
struct AddLocalItemView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var items: [Item]
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Frucht-Details") ) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("New Item")
            .navigationBarItems(leading:
                                    Button("Cancel"){
                presentationMode.wrappedValue.dismiss()
            }
            , trailing:
                                    Button("Save") {
                let newItem = Item(name: name, description: description)
                items.append(newItem)
                
                // close
                presentationMode.wrappedValue.dismiss()
            }
                .disabled(name.isEmpty)
            )
            
        }
    }
}

struct LocalDetails: View {
    let item: Item
    var body: some View {
        VStack(spacing: 20) {
            Text(item.name)
                .font(.largeTitle)
                .bold()
            Text(item.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle(item.name)
    }
}

struct Test: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("Hallo")
            Button {
                print("clicked")
            } label: {
                Text("click")
                //font(.title3)
                    .padding()
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .foregroundColor(.green)
                    .backgroundStyle(.red)
            }
            //.foregroundColor(.green)
            
            Button(action: {
                print("Button tapped!")
            }) {
                Text("iOS Bordered")
                    .padding()
                    .foregroundColor(.green)
                
            }
            .buttonStyle(.bordered) // Adds native border
            .buttonBorderShape(.capsule) // Styles the shape
            .tint(.red) // Changes the border and text color
            
            
            
            
            
            
            Image(systemName: "house")
                .imageScale(.large)
                .foregroundColor(.blue)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
