internal import SwiftUI
import PhotosUI

struct EditClubView: View {
    @EnvironmentObject var clubVM: ClubListViewModel
    @Environment(\.dismiss) var dismiss

    @State var club: Club
    @State private var selectedImage: PhotosPickerItem?
    @State private var newImageData: Data?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // 🟦 Фото өзгерту
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    ZStack {
                        if let data = newImageData ?? club.imageData,
                           let ui = UIImage(data: data) {

                            Image(uiImage: ui)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 180)
                                .clipped()
                                .cornerRadius(14)

                        } else {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 180)
                                .overlay(Text("Сурет жүктеу"))
                        }
                    }
                }
                .onChange(of: selectedImage) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            newImageData = data
                        }
                    }
                }

                TextField("Атауы", text: $club.title).textFieldStyle(.roundedBorder)
                TextField("Сипаттамасы", text: $club.description).textFieldStyle(.roundedBorder)
                TextField("Өтетін орын", text: $club.place).textFieldStyle(.roundedBorder)
                TextField("Жетекші", text: $club.instructor).textFieldStyle(.roundedBorder)

                DatePicker("Уақыт", selection: $club.startTime, displayedComponents: .hourAndMinute)

                TextField("Сыйымдылық", value: $club.capacity, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)

                Button("Өзгерістерді сақтау") {

                    // 🔥 Егер жаңа сурет таңдалса — жаңартамыз
                    if let newImg = newImageData {
                        club.imageData = newImg
                    }

                    clubVM.updateClub(club)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Өңдеу")
    }
}
