import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

/**
 Our CreateAccScreen is depending on this class,
 therefore it extends @ObservableObject and eventually @Published variables
**/

class DatabaseConfig: ObservableObject {
    
    var db = Firestore.firestore() // Creating our first instance of our database
    var auth = Auth.auth() // Creating our first instance of our authentication
    var USER_DATA_COLLECTION = "users" // the name of our collection in firestore -> to reduce risks of spelling misstakes
    var dbListener: ListenerRegistration? // Represents our listener
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    
    
    init() {
        auth.addStateDidChangeListener { auth, user in
            if let user = user { // if a user exists -> add current user to 'currentUser' -> start listening
                print("A user has logged in with email: \(user.email ?? "No Email")")
                self.currentUser = user
               // isLoggedIn = true
                //self.startListeningToDb()
            } else { // If user does not exist (logged out) -> remove listener -> clear data
                self.dbListener?.remove()
                self.dbListener = nil
                self.currentUserData = nil
                self.currentUser = nil
            //    isLoggedIn = false
                print("User has logged out!")
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
    /*
    func startListeningToDb() {
        
        guard let user = currentUser else {return} // checks if there even is a user, otherwise it won't listen
        
        // Listens for changes in our collections documents that belongs to the current user
        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener{
            snapshot, error in
            
            // If there is any error, print it
            if let error = error {
                print("Error occured brother: \(error.localizedDescription)")
                return
            }
            // Check if there is any new information from the snapshot
            guard let documentSnapshot = snapshot else {return}
            
            // trying to convert the data from snapshot into our UserData
            let result = Result {
                try documentSnapshot.data(as: UserData.self)
            }
            
            switch result {
                // IF SUCCESS
            case .success(let userData):
                self.currentUserData = userData
                // IF ERROR
            case .failure(let error):
                print("brother, error occured: \(error.localizedDescription)")
            }
        }
    }
    */
    func isUserLoggedIn() -> Bool {
        var isLoggedIn = false

        // Setting up our listener for changes in the user's authentication
      

        return isLoggedIn
    }

    

}



