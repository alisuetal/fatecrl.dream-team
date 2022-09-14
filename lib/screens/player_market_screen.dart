import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/leonitas_market_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/player.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/round_icon_widget.dart';

class PlayerMarketScreen extends StatefulWidget {
  const PlayerMarketScreen({Key? key}) : super(key: key);

  @override
  State<PlayerMarketScreen> createState() => _PlayerMarketScreenState();
}

class _PlayerMarketScreenState extends State<PlayerMarketScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController =
        Provider.of<UserController>(context, listen: false);
    final position = ModalRoute.of(context)?.settings.arguments as String;
    final PlayerController playerController =
        Provider.of<PlayerController>(context, listen: false);

    Future<bool> buy() async {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: "Mercado",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                      rightWidget: LeonitasMarketWidget(
                          leonitas: userController.user.leonita!),
                    ),
                    Row(
                      children: [
                        Text(
                          "Posição: ",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: const Color(0xffAAAAAA),
                                  ),
                        ),
                        Text(
                          position,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextfieldWithLabelWidget(
                        text: null,
                        hint: "Pesquisar jogador",
                        keyboardtype: TextInputType.name,
                        controller: controller,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: playerController.sizePlayers(),
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: PlayerCardWidget(
                            imgSrc: playerController.getImageUrl(index),
                            name: playerController.getName(index),
                            team: playerController.getTeam(index),
                            variation: playerController.getVariation(index),
                            points: playerController.getPoints(index).toInt(),
                            rightWidget: RoundIconWidget(
                              icon: Icons.add_rounded,
                              function: () => buy().then((response) {
                                if (response) {
                                  Navigator.of(context).pop();
                                }
                              }),
                            ),
                            price: 0, //TO-DO: ADD PRICE
                          ),
                        );
                      },
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
