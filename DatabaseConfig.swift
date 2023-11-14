import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct UserDetails: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var score: Int
    var selectedIcon: String
}

class DatabaseConfig: ObservableObject {
    
    var db = Firestore.firestore() // Creating our first instance of our database
    var auth = Auth.auth() // Creating our first instance of our authentication
    var USER_DATA_COLLECTION = "users" // the name of our collection in firestore -> to reduce risks of spelling misstakes
    var dbListener: ListenerRegistration? // Represents our listener
    var isInitialPrint = true
    @Published var users: [UserDetails] = []
    @Published var userName: String = ""
    @Published var didFetchData: Bool = false
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    @Published var historiaValue: Int = 0
    @Published var sportValue: Int = 0
    @Published var geografiValue: Int = 0
    @Published var teknikValue: Int = 0
    @Published var selectedIcon: String = ""
    @Published var alertMessage = ""
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    init() {
        auth.addStateDidChangeListener { auth, user in
            if let user = user {
                if self.isInitialPrint {
                    print("A user has logged in with email: \(user.email ?? "No Email")")
                    self.isInitialPrint = false
                }
                self.currentUser = user
                // isLoggedIn = true
                //self.startListeningToDb()
            } else {
                if self.isInitialPrint {
                    print("User has logged out!")
                    self.isInitialPrint = false
                }
                self.dbListener?.remove()
                self.dbListener = nil
                self.currentUserData = nil
                self.currentUser = nil
                // isLoggedIn = false
            }
        }
    }
    
    func updateScoreInFirestore(categoryName: String, score: Int, userId: String) {
        let scoreDataRef = db.collection("users").document(userId)
        scoreDataRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var categoryScores = document.data()?["scores"] as? [String: Int] ?? CategoryScore().scores
                if let currentScore = categoryScores[categoryName] {
                    categoryScores[categoryName] = currentScore + score
                }
                scoreDataRef.updateData([
                    "scores": categoryScores
                ]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated!")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func fetchCurrentUserDetails() {
        if let user = currentUser {
            let uid = user.uid
            let docRef = db.collection(USER_DATA_COLLECTION).document(uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let data = document.data(){
                        if let name = data["name"] as? String {
                            DispatchQueue.main.async {
                                self.userName = name
                                self.didFetchData = true
                            }
                        }
                    }
                } else {
                    print("Dokumentet existerar inte")
                }
            }
        }
    }
    
    func fetchUsersDetails() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var userList: [UserDetails] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "No Name"
                    
                    // Fetching the selectedIcon, defaulting to an empty string if not present
                    let selectedIcon = data["selectedIcon"] as? String ?? ""
                    
                    // Fetching the scores dictionary, defaulting to an empty dictionary if not present
                    let scores = data["scores"] as? [String: Int] ?? [:]
                    
                    var totalScore = 0
                    for (_, score) in scores {
                        totalScore += score
                    }
                    
                    let userDetails = UserDetails(name: name, score: totalScore, selectedIcon: selectedIcon)
                    userList.append(userDetails)
                }
                DispatchQueue.main.async {
                    self.users = userList
                    self.didFetchData = true
                }
            }
        }
    }
    
    func fetchProfileUserData() {
        if let user = currentUser {
            let uid = user.uid
            let docRef = db.collection(USER_DATA_COLLECTION).document(uid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let data = document.data() {
                        if let selectedIcon = data["selectedIcon"] as? String {
                            DispatchQueue.main.async {
                                self.selectedIcon = selectedIcon
                                print("Get icon \(selectedIcon)")
                            }
                        }

                        if let scores = data["scores"] as? [String: Int] {
                            DispatchQueue.main.async {
                                self.historiaValue = scores["Historia"] ?? 0
                                self.teknikValue = scores["Teknik"] ?? 0
                                self.sportValue = scores["Sport"] ?? 0
                                self.geografiValue = scores["Geografi"] ?? 0
                                self.didFetchData = true
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.historiaValue = 0
                                self.teknikValue = 0
                                self.sportValue = 0
                                self.geografiValue = 0
                                self.didFetchData = true
                            }
                        }
                    }
                }
            }
        }
    }

    func registerUser(name: String, email: String, password: String, selectedIcon: String, completion: @escaping (Bool, String) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    // Kontrollera specifika felkoder
                    if error.domain == AuthErrorCode.errorDomain {
                        switch error.code {
                        case AuthErrorCode.emailAlreadyInUse.rawValue:
                            completion(false, "E-postadressen används redan av ett annat konto.")
                            self.alertMessage = "E-postadressen används redan av ett annat konto."
                        case AuthErrorCode.weakPassword.rawValue:
                            completion(false, "Lösenordet måste vara minst 6 tecken långt")
                            self.alertMessage = "Lösenordet måste vara minst 6 tecken långt"
                        default:
                            completion(false, "\(error.localizedDescription)")
                            self.alertMessage = "\(error.localizedDescription)"
                        }
                    }
                }
                return
            }

            // Hantera användarregistrering
            if let authResult = authResult {
                let newUserData = UserData(name: name, email: email, password: password, selectedIcon: selectedIcon)
                do {
                    try self.db.collection(self.USER_DATA_COLLECTION).document(authResult.user.uid).setData(from: newUserData)
                    DispatchQueue.main.async {
                        completion(true, "Konto skapat framgångsrikt.")
                    }
                } catch let databaseError {
                    DispatchQueue.main.async {
                        completion(false, "Databasfel: \(databaseError.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func validateCreateScreenFields() -> Bool {
        if name.isEmpty && email.isEmpty && password.isEmpty && confirmPassword.isEmpty && selectedIcon.isEmpty {
            alertMessage = "Vänligen fyll i alla fält"
            return false
        }
        if name.isEmpty {
            alertMessage = "Ange ditt namn"
            return false
        }
        if email.isEmpty {
            alertMessage = "Ange din e-postadress"
            return false
        }
        if password.isEmpty {
            alertMessage = "Ange ditt lösenord"
            return false
        }
        if confirmPassword.isEmpty {
            alertMessage = "Bekräfta ditt lösenord"
            return false
        }
        if confirmPassword != password {
            alertMessage = "Lösenordet matchar inte"
            return false
        }
        if selectedIcon.isEmpty {
            alertMessage = "Välj en ikon"
            return false
        }
        return true
    }
    
    func validateLogInFields() -> Bool {
        if email.isEmpty && password.isEmpty {
            alertMessage = "Vänligen fyll i alla fält"
            return false
        }
        if email.isEmpty {
            alertMessage = "Ange din e-postadress"
            return false
        }
        if password.isEmpty {
            alertMessage = "Ange ditt lösenord"
            return false
        }
        return true
    }

    func logInUser(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { [weak self] authDataResult, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    DispatchQueue.main.async {
                        let errorMessage = error.userInfo[NSLocalizedDescriptionKey] as? String ?? ""
                                        if errorMessage.contains("INVALID_LOGIN_CREDENTIALS") {
                                            // Hantera specifikt fel för ogiltiga inloggningsuppgifter
                                            completion(false, "Inloggningsuppgifterna är ogiltiga. Kontrollera din e-post och lösenord och försök igen.")
                                            self.alertMessage = "Inloggningsuppgifterna är ogiltiga. Kontrollera din e-post och lösenord och försök igen."
                                        }
                        if error.domain == AuthErrorCode.errorDomain && error.code == AuthErrorCode.userNotFound.rawValue {
                            completion(false, "Användaren existerar inte.")
                            self.alertMessage = "Användaren existerar inte."
                        }; if error.domain == AuthErrorCode.errorDomain && error.code == AuthErrorCode.wrongPassword.rawValue || error.code == AuthErrorCode.invalidEmail.rawValue {
                            completion(false, "Fel e-post eller lösenord. Försök igen.")
                            self.alertMessage = "Fel lösenord. Försök igen."
                        } else {
                            completion(false, "Ett oväntat fel inträffade: \(error.localizedDescription)")
                            self.alertMessage = "Ett oväntat fel inträffade: \(error.localizedDescription)"
                            print(error)
                        }
                    }
                    return
                }
                if authDataResult != nil {
                    completion(true, "Inloggning lyckades.")
                }
            }
        }
    }
    
    func handleLogOut() {
        do {
            try auth.signOut()
            print("Logged out user")
            DispatchQueue.main.async { [weak self] in
                self?.didFetchData = false
                print(self?.didFetchData ?? false)
            }
            // Återställ eventuella nödvändiga variabler eller tillstånd här
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}



