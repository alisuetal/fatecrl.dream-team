import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/custom_league.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/round_icon_widget.dart';
import '../components/small_inline_information_widget.dart';

class CustomLeagueScreen extends StatefulWidget {
  const CustomLeagueScreen({Key? key}) : super(key: key);

  @override
  State<CustomLeagueScreen> createState() => _CustomLeagueScreenState();
}

class _CustomLeagueScreenState extends State<CustomLeagueScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);
    final customLeagueController =
        Provider.of<CustomLeagueController>(context, listen: false);
    final leagueId = ModalRoute.of(context)?.settings.arguments as int;

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
                      title: customLeagueController.getLeagueNameId(leagueId),
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Text(
                      "Criador: ${customLeagueController.getCreatorNameId(leagueId)} • 0 participantes",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Color(0xffAAAAAA),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Seus status",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: InlineInformationWidget(
                        leftText: "Pontos na última rodada",
                        rightText: "0",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: InlineInformationWidget(
                        leftText: "Pontos",
                        rightText: customLeagueController
                            .getUserPointsId(leagueId)
                            .toString(),
                      ),
                    ),
                    FutureBuilder(
                      future: customLeagueController.getUserPosition(
                          userController.user.email!, leagueId, false),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: InlineInformationWidget(
                            leftText: "Posição",
                            rightText: snapshot.data.toString(),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Participantes",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListView.builder(
                      itemCount: customLeagueController.memberLength(),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SmallInlineInformationWidget(
                            iconText:
                                "#${customLeagueController.getMemberPosition(index)}",
                            leftText:
                                customLeagueController.getMemberNickname(index),
                            rightText:
                                "${customLeagueController.getMemberPoints(index)} pts",
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
