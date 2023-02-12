////
////  AddingEventView.swift
////  Simplify
////
////  Created by Fatma Gazwani on 25/06/1444 AH.
////
//
//import SwiftUI
//import CoreData
//import UserNotifications
//
//struct AddingEventView: View {
//
//    @StateObject var viewModel = ViewModel()
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.managedObjectContext) private var viewContext
//
//    var body: some View {
//
//        VStack{
//            VStack{
//                HStack(alignment: .top){
//                    Spacer()
//                    Button("Add_") {
//                        viewModel.showingDetail = true
//                    }.accessibilityLabel("Addـaـnewـevent")
//                        .sheet(isPresented: $viewModel.showingDetail) {
//                            ScrollView{
//                                VStack {
//
//                                    DatePicker("Please_choose_a_date", selection: $viewModel.dueDate,
//                                               in: viewModel.dateClosedRange)
//                                        .accessibilityLabel("Please_choose_a_date")
//                                        .padding([.leading, .bottom, .trailing])
//                                        .labelsHidden()
//                                        .datePickerStyle(.graphical)
//
//
//                                    VStack(alignment: .leading){
//                                        Text("Event_Name:")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//                                        TextField("Event_Name", text: $viewModel.name)
//                                            .textFieldStyle(.roundedBorder)
//                                            .accessibilityLabel("Enter_event_Name")
//                                    }.padding()
//
//                                    Picker("Pick_a_color_for_the_event_borders", selection: $viewModel.ColorsPickers) {
//                                        ForEach(viewModel.BordersColor.allCases) { thecolor in
//                                            Text(thecolor.title).tag(thecolor)
//                                                .fontWeight(.bold)
//
//                                        }.pickerStyle(.segmented)
//                                    }.padding(.horizontal)
//
//                                    Notification()
//
//                                    Button (action: {
//                                        viewModel.addEvent()
//
//                                    }, label: {
//                                        Text("Add_Event")
//                                            .accessibilityLabel("Add_a_new_event")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//                                            .padding (16.0)
//                                            .background(Color.accentColor)
//                                            .foregroundColor(.white)
//                                            .clipShape(RoundedRectangle (cornerRadius:10.0, style: .continuous))
//                                    }).onTapGesture {
//                                        dismiss()
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.top)
//                        .padding(.horizontal, 24)
//                        .font(.title3)
//                        .foregroundColor(.accentColor)
//                }
//
//
//
//            }.padding()
//        }
//    }
//
//}
//
//
//
//struct AddingEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        let persistentContainer = CoreDataManager.shared.persistentContainer
//        AddingEventView().environment(\.managedObjectContext, persistentContainer.viewContext)
//    }
//}
//
//
