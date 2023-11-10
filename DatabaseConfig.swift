import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct UserDetails: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var score: Int
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
                    if let name = data["name"] as? String, let scores = data["scores"] as? [String: Int] {
                        var totalScore = 0
                        for (_, score) in scores {
                            totalScore += score
                        }
                        let userDetails = UserDetails(name: name, score: totalScore)
                        userList.append(userDetails)
                    }
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
    
    func registerUser(name: String, email: String, password: String) -> Bool {
        
        var success = false // A variable to keep track if create account was successfull or not
        
        // Using Firebase Authentication's createUser func to store new user with the provided email and password
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            // IF ERROR
            if let error = error { // If we catch an error, set success to false, print error
                print("an error occured: \(error.localizedDescription)")
                success = false
                return
            }
            // IF SUCCESS
            if let authResult = authResult {
                let newUserData = UserData(name: name, email: email, password: password) // newUserData receive the provided email and password
                
                do { // Store user in database
                    try self.db.collection(self.USER_DATA_COLLECTION).document(authResult.user.uid).setData(from: newUserData)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
                success = true
            }
        }
        return success
    }

    func logInUser(email: String, password: String) -> Bool {
        
        var success = false
        
        // Try to sign in the user with the provided email and password
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            
            // IF ERROR
            if let error = error {
                print("Error logging in!")
                print(error)
                success = false
            }
            // IF SUCCESS - check if there is any data in authDataResult, if there is, it means log in was successfull.
            if let _ = authDataResult {
                print("Successfully logged in!")
                success = true
            }
        }
        return success // return the value of success
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



