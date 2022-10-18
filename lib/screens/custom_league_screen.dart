import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/round_icon_widget.dart';
import '../components/small_inline_information_widget.dart';

class CustomLeagueScreen extends StatelessWidget {
  const CustomLeagueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      title: "Liga",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Text(
                      "Criador • Criado em 00/00/0000 • 0 participantes",
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
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: InlineInformationWidget(
                        leftText: "Pontos",
                        rightText: "0",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: InlineInformationWidget(
                        leftText: "Posição",
                        rightText: "#0",
                      ),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: SmallInlineInformationWidget(
                        leftText: "Mockup user",
                        rightText: "#0",
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
