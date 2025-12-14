//
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//
internal import SwiftUI

struct ClubListView: View {

    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(clubVM.clubs, id: \.id) { club in
                    NavigationLink(destination: ClubDetailView(club: club)) {

                        VStack(alignment: .leading, spacing: 4) {

                            Text(club.title)
                                .font(.headline)

                            Text("\(club.place) • \(club.weeklyDay)")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text("Қатысушылар: \(enrollmentVM.countForClub(club.id)) / \(club.capacity)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Үйірмелер")
        }
    }
}
