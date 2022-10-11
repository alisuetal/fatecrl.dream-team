import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/leonitas_market_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/player.dart';
import 'package:dream_team/controllers/team.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/round_icon_widget.dart';
import '../models/player.dart';

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
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    final position = arguments[0] as String;
    final indexArg = arguments[1];
    final PlayerController playerController =
        Provider.of<PlayerController>(context, listen: false);
    final teamController = Provider.of<TeamController>(context, listen: false);

    Future<bool> buy(int index, Player player) async {
      if (player.price > userController.user.leonita!) {
        const PopUpWidget(
          title: "Atenção",
          text: "Leonitas insuficientes",
          success: false,
        );
        return false;
      }
      final newValue = userController.user.leonita! - player.price;
      final upLeonita = await userController.upDateLeonita(newValue);
      if (!upLeonita) {
        return false;
      }

      return teamController.addPlayer(
          index, player, userController.user.email ?? "");
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
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextfieldWithLabelWidget(
                            text: null,
                            hint: "Pesquisar jogador",
                            keyboardtype: TextInputType.name,
                            controller: controller,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 82, right: 8),
                              child: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: playerController.sizePlayers(),
                      physics: const NeverScrollableScrollPhysics(),
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
                              function: () => buy(indexArg,
                                      playerController.getPlayer(index))
                                  .then((response) {
                                if (response) {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                }
                              }),
                            ),
                            price: playerController
                                .getPrice(index), //TO-DO: ADD PRICE
                          ),
                        );
                      },
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
