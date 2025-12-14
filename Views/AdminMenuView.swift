internal import SwiftUI

struct AdminMenuView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var adminAuth: AdminAuthViewModel
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel
    
    @State private var selectedClub: Club?     // sheet үшін
    @State private var searchText = ""         // іздеу үшін
    
    // 🔍 FILTERED LIST
    var filteredClubs: [Club] {
        if searchText.isEmpty { return clubVM.clubs }
        return clubVM.clubs.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.place.lowercased().contains(searchText.lowercased()) ||
            $0.instructor.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                // 🔍 SEARCH FIELD
                TextField("Іздеу…", text: $searchText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                
                // 🔥 MAIN LIST
                List {
                    ForEach(filteredClubs) { club in
                        
                        ZStack(alignment: .leading) {
                            
                            // Invisible NavigationLink (card-қа басса ашылады)
                            NavigationLink(destination: EditClubView(club: club)) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                // 🔥 PHOTO
                                if let data = club.imageData,
                                   let ui = UIImage(data: data) {
                                    Image(uiImage: ui)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 140)
                                        .clipped()
                                        .cornerRadius(14)
                                }
                                
                                Text(club.title)
                                    .font(.headline)
                                
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                    Text(club.place)
                                        .foregroundColor(.secondary)
                                }
                                
                                HStack {
                                    Image(systemName: "calendar")
                                    Text(club.startTime.toReadableDayAndTime())
                                        .foregroundColor(.secondary)
                                }
                                
                                HStack {
                                    Image(systemName: "person.crop.circle")
                                    Text("Жетекші: \(club.instructor)")
                                        .foregroundColor(.secondary)
                                }
                                
                                HStack {
                                    Image(systemName: "person.3.fill")
                                    Text("Тіркелгендер: \(enrollmentVM.countForClub(club.id))")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
                        }
                        .padding(.vertical, 4)
                        
                        // 🔥 SWIPE ACTIONS
                        .swipeActions(edge: .trailing) {
                            
                            Button(role: .destructive) {
                                clubVM.deleteClub(club)
                            } label: {
                                Label("Өшіру", systemImage: "trash")
                            }
                            
                            Button {
                                selectedClub = club
                            } label: {
                                Label("Өзгерту", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                    
                    // 📊 STATISTICS LINK
                    NavigationLink("Статистика") {
                        StatisticsView()
                    }
                    .font(.headline)
                }

                
                // ➕ ADD NEW CLUB BUTTON
                NavigationLink(destination: AddClubView()) {
                    Text("Жаңа үйірме қосу")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                // 🔴 LOGOUT
                Button("Шығу (Админ)") {
                    adminAuth.logout()
                }
                .foregroundColor(.red)
                .padding(.bottom)
            }
            .navigationTitle("Админ панель")
        }
        
        // 🔥 sheet(item:) — ЕҢ ДҰРЫС ӘДІС
        .sheet(item: $selectedClub) { club in
            EditClubView(club: club)
                .environmentObject(clubVM)
        }
    }
}
