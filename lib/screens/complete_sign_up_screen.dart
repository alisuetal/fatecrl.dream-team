import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/dropdown_widget.dart';
import 'package:dream_team/components/round_icon_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/sponsors_league.dart';
import 'package:dream_team/models/sponsors_league.dart';
import 'package:dream_team/models/user.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/screens/utils/validator.dart';
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
    super.initState();
    SponsorsLeagueControler leagueControler = SponsorsLeagueControler();
    leagueControler.loudLeagues().then((_) {
      setState(() {
        _leagues = leagueControler.getLeague();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserControler userControler = Provider.of<UserControler>(context);

    Future<bool> submitCompleteSignUp(UserControler userControler) async {
      final bool isValid = _formKey.currentState!.validate();
      if (!isValid) {
        print("a");
        return false;
      }
      _formKey.currentState?.save();

      User user = userControler.user;
      User finalUser = User(
        name: user.name,
        email: user.email,
        birthday: user.birthday,
        leonita: 0,
        ametista: 0,
        password: user.password,
        nickname: _nickname.text,
        point: 0,
        sponsorsLeague: leagueId,
      );

      userControler.setUser(finalUser);

      final bool signUp = await userControler.signUp();

      if (signUp) {
        return true;
      }
      return false;
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
                            submitCompleteSignUp(userControler).then((sucsses) {
                              if (sucsses) {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.team);
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
                                    color: Color(0xff888888),
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
