//
//  ClubDetailView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//
internal import SwiftUI

struct ClubDetailView: View {

    let club: Club
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Атауы
                Text(club.title)
                    .font(.largeTitle.bold())

                // Орын және күні
                Text("\(club.place) • \(club.weeklyDay)")
                    .font(.headline)
                    .foregroundColor(.gray)

                // Сипаттамасы
                Text(club.description)
                    .font(.body)

                // Қатысушылар саны
                Text("Қатысушылар: \(enrollmentVM.countForClub(club.id)) / \(club.capacity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Тіркелу батырмасы (мысалы)
                Button(action: {
                    if let email = authVM.currentUserEmail {
                        enrollmentVM.enroll(userId: email, clubId: club.id)
                    }
                }) {
                    Text("Тіркелу")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

            .padding()
        }
        .navigationTitle(club.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
}
