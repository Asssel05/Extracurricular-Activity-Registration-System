internal import SwiftUI
import UserNotifications

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            print("Notifications allowed")
        } else {
            print("Notifications denied")
        }
    }
}

enum UserRole: Hashable {
    case parent
    case admin
}

struct RootView: View {

    // ✔️ ГЛОБАЛЬ МОДЕЛДЕР
    @StateObject var clubVM = ClubListViewModel()
    @StateObject var enrollmentVM = EnrollmentViewModel()
    @StateObject var authVM = AuthViewModel()
    @StateObject var adminAuth = AdminAuthViewModel()

    @State private var path: [UserRole] = []

    var body: some View {
        NavigationStack(path: $path) {
            
            RoleSelectionView(path: $path)
                .navigationDestination(for: UserRole.self) { role in

                    switch role {

                    case .parent:
                        if authVM.isLoggedIn {
                            MainTabView()
                        } else {
                            LoginView()
                                .onChange(of: authVM.isLoggedIn) { logged in
                                    if logged { path.removeAll() }
                                }
                        }

                    case .admin:
                        if adminAuth.isAdminLoggedIn {
                            AdminMenuProtectedView()
                        } else {
                            AdminLoginView()
                                .onChange(of: adminAuth.isAdminLoggedIn) { logged in
                                    if logged { path.removeAll() }
                                }
                        }
                    }
                }
        }
        // ✔️ Барлық view-ларға модельдерді тарату
        .environmentObject(clubVM)
        .environmentObject(enrollmentVM)
        .environmentObject(authVM)
        .environmentObject(adminAuth)
        .onAppear { requestNotificationPermission() }
    }
}

// ------------------------------------------------
struct RoleSelectionView: View {
    @Binding var path: [UserRole]

    // ⭐ 1. ФОНДЫҚ ГРАДИЕНТТІ АНЫҚТАУ (Құрылым ішінде)
    let gradientBackground = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.8, green: 0.9, blue: 1.0), // Ашық көк (жоғары)
            Color(red: 0.4, green: 0.7, blue: 0.9)  // Қою көк (төмен)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        // ⭐ 2. ZStack арқылы Фонды Мәтіннің астына қою
        ZStack {
            
            // ФОНДЫҚ ГРАДИЕНТ
            gradientBackground
                .edgesIgnoringSafeArea(.all) // Бүкіл экранды қамту
                .opacity(0.95)

            // НЕГІЗГІ VSTACK (Барлық UI элементтерді орналастыру)
            VStack(spacing: 35) {
                
                // ⭐ 3. ЛОГОТИП (E-mektep)
                VStack(spacing: 8) {
                    // Логотип иконасы (SF Symbol)
                    Image(systemName: "e.square.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 0.1, green: 0.5, blue: 0.9))
                    // Логотип мәтіні
                    Text("E-mektep")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.1, green: 0.5, blue: 0.9))
                }
                // .padding(.top, 0)
                
                // ⭐ 4. ТАҚЫРЫП МӘТІНІ (Үлкенірек және қалың)
                Text("Жүйеге қалай кіресіз?")
                    .font(.largeTitle) // Үлкенірек шрифт
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20) // Жоғарғы орынды реттеу

                // ТҮЙМЕЛЕРДІ ОРНАЛАСТЫРУ БЛОГЫ
                VStack(spacing: 20) {
                    
                    // А. АТА-АНА ТҮЙМЕСІ
                    Button {
                        path.append(.parent)
                    } label: {
                        HStack {
                            // ИКОНА: Ата-ана / Отбасы
                            Image(systemName: "figure.2.dress.line.leaning.bwd")
                                .font(.title3)
                            Text("Ата-ана ретінде кіру")
                        }
                    }
                    .buttonStyle(DSPrimaryButton())

                    // Б. ҰСТАЗ / АДМИН ТҮЙМЕСІ
                    Button {
                        path.append(.admin)
                    } label: {
                        HStack {
                            // ИКОНА: Кітап / Оқытушы
                            Image(systemName: "book.closed")
                                .font(.title3)
                            Text("Ұстаз / Админ ретінде кіру")
                        }
                    }
                    .buttonStyle(DSSecondaryButton())
                }
                .padding(.horizontal, 25) // Түймелерге горизонталь орын қосу

                Spacer()
            }
        }
        // ⭐ 5. Навигациялық тақырыптарды жасыру
        // Бұл суреттегі таза, толық экранды дизайнға қол жеткізу үшін қажет
        .navigationBarHidden(true)
    }
}
