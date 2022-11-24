import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/leonitas_market_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/controllers/custom_league.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/amount_with_label_widget.dart';
import '../components/round_icon_widget.dart';
import '../components/textfield_with_label_widget.dart';

class CreateLeagueScreen extends HookWidget {
  const CreateLeagueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: "");
    final userLenght = useState<int>(0),
        rounds = useState<int>(0),
        createPrice = useState<int>(0);
    final isPrivate = useState(false);
    final userController = Provider.of<UserController>(context, listen: false);
    final user = userController.user;
    final customLeagueController = Provider.of<CustomLeagueController>(context);

    Future<bool> createLeague() async {
      if (nameController.text.isEmpty ||
          createPrice.value == 0 ||
          nameController.text.length < 5) {
        showAlertDialog(context, "Erro", "Preencha todos os campos", false);
        return false;
      }
      if (user.leonita! < createPrice.value) {
        showAlertDialog(context, "Erro", "Leonitas insuficientes", false);
        return false;
      }
      final leonita =
          await userController.upDateLeonita(user.leonita! - createPrice.value);
      if (!leonita) {
        showAlertDialog(context, "Erro", "Tente novamente mais tarde", false);
        return false;
      }
      final create = await customLeagueController.createLeague(
        name: nameController.text,
        rounds: rounds.value,
        userLength: rounds.value,
        private: isPrivate.value,
        value: createPrice.value,
        email: user.email!,
      );
      if (!create) {
        showAlertDialog(context, "Erro", "Tente novamente mais tarde", false);
        return false;
      }
      return true;
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
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: "Criar liga",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                      rightWidget: LeonitasMarketWidget(
                          leonitas: userController.user.leonita!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextfieldWithLabelWidget(
                        text: null,
                        hint: "Nome da liga",
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AmountWithLabelWidget(
                        hint: "Quantidade de participantes",
                        amount: userLenght.value,
                        onDecrease: () {
                          if (userLenght.value != 0) {
                            userLenght.value -= 8;
                            createPrice.value -= 100;
                          }
                        },
                        onIncrease: () {
                          if (userLenght.value != 64) {
                            userLenght.value += 8;
                            createPrice.value += 100;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AmountWithLabelWidget(
                        hint: "Quantidade de rodadas",
                        amount: rounds.value,
                        onDecrease: () {
                          if (rounds.value != 0) {
                            rounds.value -= 6;
                            createPrice.value -= 200;
                          }
                        },
                        onIncrease: () {
                          if (rounds.value != 36) {
                            rounds.value += 6;
                            createPrice.value += 200;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: isPrivate.value,
                            onChanged: (_) =>
                                isPrivate.value = !isPrivate.value,
                          ),
                          Text(
                            "Privado",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: "Criar \$${createPrice.value}",
                        function: () => createLeague().then((response) {
                          if (response) {
                            Navigator.of(context).pop();
                          }
                        }),
                        enabled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 160,
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
