import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/sponsors_league.dart';
import 'package:dream_team/controllers/team.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/models/user.dart';
import 'package:dream_team/utils/validator.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> _submitSignIn(
      UserController userController, BuildContext context) async {
    // final bool isValid = _formKey.currentState!.validate();
    // if (!isValid) {
    //   return false;
    // }
    // _formKey.currentState?.save();
    // final bool signIn = await userController.signIn(
    //     _emailController.text, _passwordController.text);
    final bool signIn =
        await userController.signIn("gabriel1@gmail.com", "doVal13\$\$\$");
    if (signIn) {
      return true;
    }
    showAlertDialog(context, "Erro", "Email ou senha incorretos", false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final sLeague =
        Provider.of<SponsorsLeagueController>(context, listen: false);
    final UserController userController =
        Provider.of<UserController>(context, listen: false);
    final TeamController teamController =
        Provider.of<TeamController>(context, listen: false);

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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppBarWidget(
                            title: "Login",
                            leftWidget: RoundIconWidget(
                              icon: Icons.arrow_back_rounded,
                              function: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              hint: "E-mail:",
                              controller: _emailController,
                              validator: (email) => Validators.email(email),
                              keyboardtype: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextfieldWithLabelWidget(
                              text: null,
                              hint: "Senha:",
                              controller: _passwordController,
                              obscure: true,
                              validator: (password) =>
                                  Validators.password(password),
                              keyboardtype: TextInputType.visiblePassword,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: ButtonWidget(
                              enabled: true,
                              function: () {
                                _submitSignIn(userController, context).then(
                                  ((value) {
                                    if (value) {
                                      sLeague.loudLeagues().then((_) {
                                        teamController.setTatic(
                                            userController.user.tatic!);
                                        teamController
                                            .loadPlayers(
                                                userController.user.email!)
                                            .then((_) => Navigator.of(context)
                                                .pushReplacementNamed(
                                                    AppRoutes.tabsScreen));
                                      });
                                    }
                                  }),
                                );
                              },
                              text: "Enviar",
                              materialIcon: null,
                            ),
                          ),
                        ],
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
