//
//  MealDetailView.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import SwiftUI

struct MealDetailView: View {
    
    @StateObject var mealDetailViewModel = MealDetailViewModel(fetchController: FetchController())
    @State var favorited: Bool = false
    @Binding var favoritedList: [String]
    
    let mealId: String
    
    var body: some View {
        GeometryReader { geo in
            switch mealDetailViewModel.status {
                case .success :
                    ScrollView {
                        VStack (alignment: .leading) {
                            AsyncImage(url: mealDetailViewModel.mealDetail.mealImage) { image in
                                image.resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                ProgressView()
                            }.frame(width: geo.size.width)
                                .clipShape(.rect(cornerSize: CGSize(width: 10, height: 10)))
                            HStack {
                                Text("Favorited : ")
                                Button {
                                    favorited.toggle()
                                    if favorited {
                                        favoritedList.append(mealId)
                                    } else {
                                        favoritedList.removeAll {$0 == mealId}
                                    }
                                    UserDefaults.standard.setValue(favoritedList.joined(separator: ","), forKey: "favorite")
                                } label: {
                                    Image(systemName: favorited ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.red)
                                }

                            }
                            Text("Instructions".capitalized)
                                .font(.title)
                                .bold()
                            Text(mealDetailViewModel.mealDetail.instructions)
                                .padding(.bottom)
                            
                            Text("Ingredients/measurements".capitalized)
                                .font(.title)
                                .bold()
                            // show all Ingredients/measurements
                            VStack(alignment: .leading) {
                                ForEach( 0..<self.mealDetailViewModel.mealDetail.ingredients.count, id: \.self) { idx in
                                    HStack{
                                        Text(self.mealDetailViewModel.mealDetail.ingredients[idx])
                                            .bold()
                                        Text(":")
                                        Text(self.mealDetailViewModel.mealDetail.measures[idx])
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle(self.mealDetailViewModel.mealDetail.mealName)
                default:
                    ProgressView()
            }
            
        }.task {
            await mealDetailViewModel.fetchData(mealId: mealId)
        }
        .padding()
        
    }
}

#Preview {
    
    MealDetailView(favoritedList: .constant([]), mealId: "52961")
    
}
