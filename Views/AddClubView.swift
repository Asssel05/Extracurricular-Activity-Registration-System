//
//  AddClubView.swift
//

internal import SwiftUI
import PhotosUI

struct AddClubView: View {

    @EnvironmentObject var clubVM: ClubListViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var place = ""
    @State private var weeklyDay = "Дүйсенбі"
    @State private var startTime = Date()
    @State private var capacity = "10"
    @State private var instructor = ""

    @State private var selectedImage: PhotosPickerItem?
    @State private var clubImageData: Data?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - Image Picker
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    ZStack {
                        if let data = clubImageData,
                           let ui = UIImage(data: data) {
                            Image(uiImage: ui)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 180)
                                .clipped()
                                .cornerRadius(14)
                        } else {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.12))
                                .frame(height: 180)
                                .overlay(
                                    VStack {
                                        Image(systemName: "photo")
                                            .font(.largeTitle)
                                        Text("Сурет жүктеу")
                                            .foregroundColor(.secondary)
                                    }
                                )
                        }
                    }
                }
                .onChange(of: selectedImage) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            clubImageData = data
                        }
                    }
                }

                // MARK: - Form Fields
                VStack(spacing: 16) {

                    Group {
                        TextField("Атауы", text: $title)
                            .textFieldStyle(.roundedBorder)

                        TextField("Сипаттама", text: $description)
                            .textFieldStyle(.roundedBorder)

                        TextField("Өтетін жер", text: $place)
                            .textFieldStyle(.roundedBorder)

                        TextField("Жетекші", text: $instructor)
                            .textFieldStyle(.roundedBorder)
                    }

                    Picker("Күні", selection: $weeklyDay) {
                        ForEach(["Дүйсенбі","Сейсенбі","Сәрсенбі","Бейсенбі","Жұма","Сенбі","Жексенбі"], id: \.self) {
                            Text($0)
                        }
                    }

                    DatePicker("Уақыты", selection: $startTime, displayedComponents: .hourAndMinute)

                    TextField("Сыйымдылық", text: $capacity)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    Button(action: saveClub) {
                        Text("Үйірме қосу")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Жаңа үйірме қосу")
    }

    // MARK: - Save Function
    private func saveClub() {
        let cap = Int(capacity) ?? 10

        let newClub = Club(
            id: UUID().uuidString,
            title: title,
            description: description,
            place: place,
            weeklyDay: weeklyDay,
            startTime: startTime,
            capacity: cap,
            instructor: instructor,
            imageData: clubImageData      // ⬅️ Сурет сақталады!
        )

        clubVM.addClub(newClub)
        dismiss()
    }
}
