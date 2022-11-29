import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/sponsors_league.dart';
import 'package:dream_team/controllers/team.dart';
import 'package:dream_team/models/user.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/utils/validator.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/dropdown_with_label_widget.dart';

class CompleteSignUpScreen extends StatefulWidget {
  const CompleteSignUpScreen({Key? key}) : super(key: key);

  @override
  State<CompleteSignUpScreen> createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nickname = TextEditingController();
  int leagueId = 1;

  Map<int, String> _leagues = {};

  @override
  void initState() {
    // TODO: implement initState
    SponsorsLeagueController leagueControler = SponsorsLeagueController();
    leagueControler.loudLeagues().then((_) {
      setState(() {
        _leagues = leagueControler.getLeague();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Provider.of<UserController>(context);
    final TeamController teamController = Provider.of<TeamController>(context);
    final sponsorLeagueController =
        Provider.of<SponsorsLeagueController>(context, listen: false);

    Future<bool> submitCompleteSignUp(UserController userControler) async {
      final bool isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return false;
      }
      _formKey.currentState?.save();

      User user = userControler.user;
      User finalUser = User(
        name: user.name,
        email: user.email,
        birthday: user.birthday,
        leonita: 2000,
        ametista: 0,
        password: user.password,
        nickname: _nickname.text,
        point: 0,
        tatic: 0,
        sponsorsLeague: leagueId,
      );

      userControler.setUser(finalUser);

      await sponsorLeagueController.loudLeagues();

      await teamController.loadPlayers(userController.user.email!);

      final bool signUp = await userControler.signUp();

      if (signUp) {
        teamController.setTatic(0);
        return true;
      }
      showAlertDialog(context, "Erro", "Ocorreu um erro de conexão", false);
      return false;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppBarWidget(title: "Quase lá!", leftWidget: null),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextfieldWithLabelWidget(
                          text: null,
                          hint: "Apelido",
                          controller: _nickname,
                          validator: (nickname) =>
                              Validators.nickname(nickname),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: DropDownWithLabelWidget(
                          anchor: (value) {
                            setState(() {
                              leagueId = value;
                            });
                          },
                          items: _leagues,
                          value: leagueId,
                          hint: "Liga do coração",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ButtonWidget(
                          enabled: true,
                          function: () {
                            submitCompleteSignUp(userController)
                                .then((sucsses) {
                              if (sucsses) {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.tabsScreen);
                              }
                            });
                          },
                          text: "Enviar",
                          materialIcon: null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Essas informações poderão ser alterações mais tarde.",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: const Color(0xff888888),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
