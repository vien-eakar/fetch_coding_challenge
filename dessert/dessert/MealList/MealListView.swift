//
//  MealListView.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject var mealViewModel = MealViewModel(fetchController: FetchController())
    
    @State var alphabetical: Bool = true
    @State var favorited = [String]()
    
    var body: some View {
        NavigationStack {
            switch mealViewModel.status {
                case .success:
                    List{
                        ForEach(mealViewModel.listMeals) { meal in
                            NavigationLink {
                                MealDetailView(favorited: favorited.contains(meal.mealId), favoritedList: $favorited, mealId: meal.mealId)
                            } label: {
                                HStack {
                                    AsyncImage(url: meal.mealImage) { img in
                                        img.resizable()
                                            .scaledToFit()
                                    }placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                    .clipShape(.rect(cornerSize: CGSize(width: 5, height: 5)))
                                    
                                    Text(meal.mealName)
                                        .padding(.leading)
                                    if favorited.contains(meal.mealId) {
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Dessert")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                withAnimation {
                                    self.alphabetical.toggle()
                                    self.mealViewModel.sortList(alphabetical: self.alphabetical)
                                }
                            } label: {
                                Image(systemName: self.alphabetical ? "textformat" : "film")
                                    .symbolEffect(.bounce, value: self.alphabetical)
                            }

                        }
                    }
                default:
                    ProgressView()
            }
        }.task {
            await mealViewModel.fetchMeal(category: "Dessert")
        }
        .onAppear {
            if let ids = UserDefaults.standard.string(forKey: "favorite") {
                favorited = ids.components(separatedBy: ",")
            }
        }
    }
}

#Preview {
        MealListView()
}
