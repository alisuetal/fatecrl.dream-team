import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/form_calendar_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/models/user.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/utils/validator.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserController userController = Provider.of<UserController>(context);

    Future<bool> submitSignUp(UserController userController) async {
      final bool isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return false;
      }
      _formKey.currentState?.save();

      final bool chekExistEmail =
          await userController.checkExistEmail(_emailController.text);
      if (!chekExistEmail) {
        showAlertDialog(context, "Erro", "e-mail já cadastrado", false);
        return false;
      }

      final User newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        birthday: _selectedDate,
      );
      userController.setUser(newUser);
      return true;
    }

    return ScreenHolderWidget(
      content: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/svg/background.svg",
            fit: BoxFit.cover,
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
                              validator: (name) => Validators.name(name),
                              keyboardtype: TextInputType.name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              controller: _emailController,
                              hint: "E-mail:",
                              validator: (email) => Validators.email(email,
                                  confirmEmail: _confirmEmailController.text),
                              keyboardtype: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              controller: _confirmEmailController,
                              hint: "Confirmar e-mail:",
                              validator: (confirmEmail) => Validators.email(
                                  _emailController.text,
                                  confirmEmail: confirmEmail),
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
                              validator: (password) => Validators.password(
                                  password,
                                  confirmPassword:
                                      _confirmPasswordController.text),
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
                              validator: (confirmPassword) =>
                                  Validators.password(_passwordController.text,
                                      confirmPassword: confirmPassword),
                              keyboardtype: TextInputType.visiblePassword,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: FormCalendarWidget(
                              selectedDate: _selectedDate,
                              onDateChanged: (newDate) {
                                setState(() {
                                  _selectedDate = newDate;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        enabled: true,
                        function: () =>
                            submitSignUp(userController).then((result) {
                          if (result) {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.completeSignUp);
                          }
                        }),
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
