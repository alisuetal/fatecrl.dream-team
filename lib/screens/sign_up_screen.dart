import 'dart:math';

import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/components/textfield_widget.dart';
import 'package:dream_team/models/user.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _submitSignUp() async {
      final bool isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();

      final bool vEmail = await User.vEmail("email");
      if (vEmail) {
        print("Email já cadastrado");
        return;
      }

      final User newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        birthday: DateTime.now(),
      );

      final bool signUp = await newUser.signUp();
      if (!signUp) {
        print("Erro ao cadastrar, tente novamente mais tarde");
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.completeSignUp);
    }

    return ScreenHolderWidget(
      content: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/svg/background.svg",
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: "Cadastro",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              controller: _nameController,
                              hint: "Nome:",
                              validator: (name) {
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
                              },
                              keyboardtype: TextInputType.name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              controller: _emailController,
                              hint: "E-mail:",
                              validator: (email) {
                                final emailv = RegExp(
                                    "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
                                if (email.isEmpty) {
                                  return "Escreva seu email";
                                }
                                if (!email.contains(emailv)) {
                                  return "Email inválido";
                                }
                                return "";
                              },
                              keyboardtype: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              controller: _confirmEmailController,
                              hint: "Confirmar e-mail:",
                              validator: (email) {
                                if (_emailController.text != email) {
                                  return "Os emails não coincidem";
                                }
                                return "";
                              },
                              keyboardtype: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              hint: "Senha:",
                              obscure: true,
                              controller: _passwordController,
                              validator: (password) {
                                final upperLower =
                                    RegExp(r"(?=.*[a-z])(?=.*[A-Z])");
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
                                return "";
                              },
                              keyboardtype: TextInputType.visiblePassword,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              obscure: true,
                              controller: _confirmPasswordController,
                              hint: "Confirmar senha:",
                              validator: (password) {
                                if (_passwordController.text != password) {
                                  return "As senhas não coincidem";
                                }
                                return "";
                              },
                              keyboardtype: TextInputType.visiblePassword,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              hint: "Data de nascimento:",
                              validator: (birthDay) {
                                final DateTime dataMinima = DateTime(
                                  DateTime.now().year - 18,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                );
                                if (birthDay.isEmpty) {
                                  return "Digite sua data de nascimento";
                                }
                                return "";
                              },
                              keyboardtype: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        enabled: true,
                        function: () {
                          _submitSignUp();
                        },
                        text: "Enviar",
                        materialIcon: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
