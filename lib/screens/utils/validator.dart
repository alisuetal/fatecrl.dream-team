class Validators {
  static name(String name) {
    if (name.isEmpty) {
      return "Escreva seu nome";
    }
    if (name.contains(RegExp(r'[0-9]'))) {
      return "O nome não pode conter números";
    }
    if (name.length <= 3) {
      return "O nome precisa ter pelo menos três letras";
    }
    return null;
  }

  static email(String email, {confirmEmail}) {
    final emailv = RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");

    if (email.isEmpty) {
      return "Escreva seu email";
    }
    if (!email.contains(emailv)) {
      return "Email inválido";
    }
    final vConfirmEmail = confirmEmail.toString().isEmpty;
    if (vConfirmEmail && confirmEmail != email) {
      return "Os emails não coincidem";
    }
    return null;
  }

  static password(String password, {confirmPassword}) {
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
    final vConfirmPassword = password.toString().isEmpty;
    if (vConfirmPassword && password != confirmPassword) {
      return "As senhas não coincidem";
    }
    return null;
  }

  static nickname(String nickname) {
    if (nickname.isEmpty) {
      return "Digite seu apelido";
    }
    if (nickname.length > 13) {
      return "O apelido não pode ter mais de 13 caracteres";
    }
    RegExp apelidov = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (nickname.contains(apelidov)) {
      return "O apelido não pode conter caracteres especiais";
    }
    return null;
  }
}
