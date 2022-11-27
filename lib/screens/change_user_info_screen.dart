import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/round_icon_widget.dart';

class ChangeUserInfoScreen extends HookWidget {
  ChangeUserInfoScreen({Key? key}) : super(key: key);

  final _fieldValueController = TextEditingController();
  final _confirmFieldValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserController userController =
        Provider.of<UserController>(context, listen: true);
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    final visibility = useState<bool>(arguments[1] as bool);

    Future<void> changeInfo(
      int? price,
      String field,
      String fieldValue,
      String confirmFieldValue,
    ) async {
      switch (field) {
        case "Apelido":
          if (userController.user.leonita! < price!) {
            showAlertDialog(
              context,
              "Erro!",
              "Leonitas insuficientes",
              false,
            );
          } else {
            if ((await userController.changeNickname(
              userController.user.email!,
              fieldValue,
            ))) {
              showAlertDialog(
                context,
                "Sucesso!",
                "Apelido alterado com sucesso",
                true,
              ).then((_) => Navigator.of(context).pop());
            }
          }
          break;
        case "E-mail":
          if (fieldValue != confirmFieldValue) {
            showAlertDialog(
              context,
              "Erro!",
              "Campos não coincidem",
              false,
            );
          } else {
            if ((await userController.changeEmail(
              userController.user.email!,
              fieldValue,
            ))) {
              showAlertDialog(
                context,
                "Sucesso!",
                "E-mail alterado com sucesso",
                true,
              ).then((_) => Navigator.of(context).pop());
            }
          }
          break;
        case "Senha":
          if (fieldValue != confirmFieldValue) {
            showAlertDialog(
              context,
              "Erro!",
              "Campos não coincidem",
              false,
            );
          } else {
            if ((await userController.changePassword(
              userController.user.email!,
              fieldValue,
            ))) {
              showAlertDialog(
                context,
                "Sucesso!",
                "Senha alterada com sucesso",
                true,
              ).then((_) => Navigator.of(context).pop());
            }
          }
          break;
      }
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
                      title: "Alterar ${arguments[0]}",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        arguments[0],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              !visibility.value
                                  ? arguments[3]
                                  : arguments[3]
                                      .toString()
                                      .split('')
                                      .map((e) => "*")
                                      .join(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                          ),
                          if (arguments[1])
                            GestureDetector(
                              onTap: () => visibility.value = !visibility.value,
                              child: Icon(
                                !visibility.value
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                              ),
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextfieldWithLabelWidget(
                        obscure: arguments[1],
                        controller: _fieldValueController,
                        hint:
                            "Alterar ${arguments[0].toString().toLowerCase()}",
                      ),
                    ),
                    if (arguments[2])
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextfieldWidget(
                          obscure: arguments[1],
                          controller: _confirmFieldValueController,
                          hint:
                              "Confirmar ${arguments[0].toString().toLowerCase()}",
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: "Alterar",
                        function: () => changeInfo(
                          arguments.length == 5 ? arguments[4] : null,
                          arguments[0],
                          _fieldValueController.text,
                          _confirmFieldValueController.text,
                        ),
                        enabled: true,
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
