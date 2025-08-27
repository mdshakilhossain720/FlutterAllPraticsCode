mixin Logger {
  void log(String message) {
    print("[LOG] $message");
  }
}

mixin Validator {
  bool isValidEmail(String email) {
    return email.contains("@") && email.contains(".");
  }
}

class UserService with Logger, Validator {
  void createUser(String email) {
    if (isValidEmail(email)) {
      log("User created with email: $email");
    } else {
      log("Invalid email: $email");
    }
  }
}

void main() {
  var service = UserService();
  service.createUser("test@example.com");
  service.createUser("wrongEmail");
}
