//
//  ContentView.swift
//  FriendsCollection
//
//  Created by Johan Guenaoui on 01/10/2020.
//
//  Goal: This view is the main application's view. It initializes the list of friends characters and displays the list ats the application's opening

import SwiftUI

struct ContentView: View {
    @ObservedObject private var _friendsCollection = CharacterDirectory()
    @State private var _showEditForm:Bool = false
    @State private var _friendsList:[Character] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("Friends Collection")
                    .font(.system(.title))
                    .bold()
                Spacer()
                Button(action: {
                    self._showEditForm = true
                }) {
                    Image(systemName: "plus.circle")
                }
                .font(.system(size:32))
                .sheet(isPresented: self.$_showEditForm) {
                    CharacterEditForm(_characterDirectory: _friendsCollection)
                }
            }.padding()
            List{
                ForEach(_friendsCollection.getCharacters(), id: \._id) {value in
                    CharacterPresenter(content:value)
                    Spacer()
                }
                .onAppear(perform: {
                    reload()
                })
                .onReceive(_friendsCollection.objectWillChange, perform: { _ in
                    reload()
                })
            }
        }
    }

    private func reload() {
        _friendsList = _friendsCollection.getCharacters()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}