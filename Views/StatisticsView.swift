internal import SwiftUI
import Charts

struct StatisticsView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @EnvironmentObject var enrollmentVM: EnrollmentViewModel

    var totalClubs: Int {
        clubVM.clubs.count
    }

    var totalEnrollments: Int {
        enrollmentVM.enrollments.count
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // MARK: — Summary Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Жалпы статистика")
                        .font(.title3)
                        .bold()

                    summaryRow(
                        icon: "building.2.crop.circle",
                        label: "Үйірмелер саны",
                        value: "\(totalClubs)"
                    )

                    summaryRow(
                        icon: "person.3.fill",
                        label: "Тіркелген оқушылар",
                        value: "\(totalEnrollments)"
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
                .padding(.horizontal)



                // MARK: — Pie Chart
                if !clubVM.clubs.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Үйірмелер үлесі (Pie Chart)")
                            .font(.title3)
                            .bold()

                        Chart {
                            ForEach(clubVM.clubs) { club in
                                let enrolled = enrollmentVM.countForClub(club.id)

                                SectorMark(
                                    angle: .value("Қатысушылар", max(enrolled, 1)),
                                    innerRadius: .ratio(0.4),
                                    angularInset: 2
                                )
                                .foregroundStyle(by: .value("Үйірме", club.title))
                            }
                        }
                        .frame(height: 260)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
                    .padding(.horizontal)
                }


                // MARK: — Clubs Statistics List
                VStack(alignment: .leading, spacing: 16) {
                    Text("Үйірмелер бойынша")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)

                    ForEach(clubVM.clubs) { club in
                        clubStatisticCard(club: club)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Статистика")
        .background(Color(.systemGroupedBackground))
    }


    // MARK: — Summary Row Component
    func summaryRow(icon: String, label: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.title2)
                .frame(width: 32)

            Text(label)
                .font(.body)

            Spacer()

            Text(value)
                .bold()
                .font(.body)
        }
    }


    // MARK: — Club Statistic Card Component
    func clubStatisticCard(club: Club) -> some View {
        let enrolled = enrollmentVM.countForClub(club.id)
        let capacity = club.capacity
        let percent = capacity == 0 ? 0 : Int((Double(enrolled) / Double(capacity)) * 100)

        return VStack(alignment: .leading, spacing: 10) {

            Text(club.title)
                .font(.headline)

            Text("Қатысушылар: \(enrolled) / \(capacity)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ProgressView(value: Double(enrolled), total: Double(capacity))
                .tint(percent >= 80 ? .green : .blue)

            Text("Толықтығы: \(percent)%")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
}
