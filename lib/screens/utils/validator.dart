class Validators {

  static String name(String name){
    if (name.isEmpty) {
      return "Escreva seu nome";
    }
    if (name.contains(RegExp(r'[0-9]'))) {
      return "O nome não pode conter números";
    }
    if (name.length <= 3) {
      return "O nome precisa ter pelo menos três letras";
    }
    return "";                          
  }

  static String email(String email, String confirmEmail){
    final emailv = RegExp("^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
                                
    if (email.isEmpty) {
      return "Escreva seu email";
    }
    if (!email.contains(emailv)) {
      return "Email inválido";
    }
    if (confirmEmail != email) {
      return "Os emails não coincidem";
    }
    return "";
  }

  static String password(String password, String confirmPassword){
    final upperLower = RegExp(r"(?=.*[a-z])(?=.*[A-Z])");
    if (password.isEmpty) {
      return "Digite uma senha";
    }
    if (password.length <= 8) {
      return "A senha precisa ter pelo menos oito caracteres";
    }
    if (!password.contains(upperLower)) {
      return "A senha precisa uma letra maiuscula e uma minuscula";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "A senha precisa ter um número";
    }
    if(password != confirmPassword){
      return "As senhas não coincidem";
    }
    return "";
  }
}

