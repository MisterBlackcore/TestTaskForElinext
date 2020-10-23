import Foundation

class AuthService {
    
    static let shared = AuthService()
    private init () {}
    
    //MARK: - Flow Functions
    
    func authorisationIsSuccessful(email: String, password: String) -> Bool {
        let emailIsValid = checkEmail(email: email.replacingOccurrences(of: " ", with: ""))
        let passwordIsValid = checkPassword(password: password.replacingOccurrences(of: " ", with: ""))
        if !emailIsValid || !passwordIsValid {
            return false
        } else {
            return true
        }
    }
    
    private func checkEmail(email:String) -> Bool {
        var emailIsValid = false
        for charachter in email {
            if charachter == "@" {
                emailIsValid.toggle()
            }
        }
        return emailIsValid
    }
    
    private func checkPassword(password: String) -> Bool {
        if password.isEmpty == true {
            return false
        } else {
            return true
        }
    }
}
