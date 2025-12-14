internal import SwiftUI

@main
struct ExtracurricularActivityAppApp: App {

    init() {
        NavigationAppearance.setup()   // ← ГЛОБАЛ СТИЛЬ ҚОСЫЛАДЫ
    }

    @StateObject private var authVM = AuthViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @StateObject private var enrollmentVM = EnrollmentViewModel()
    @StateObject private var adminAuth = AdminAuthViewModel()

    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
                .environmentObject(clubListVM)
                .environmentObject(enrollmentVM)
                .environmentObject(adminAuth)
        }
    }
}

