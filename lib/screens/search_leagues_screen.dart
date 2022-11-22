import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/league_info_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/round_icon_widget.dart';
import '../controllers/custom_league.dart';
import '../tools/app_routes.dart';

class SearchLeaguesScreen extends StatefulWidget {
  const SearchLeaguesScreen({Key? key}) : super(key: key);

  @override
  State<SearchLeaguesScreen> createState() => _SearchLeaguesScreenState();
}

class _SearchLeaguesScreenState extends State<SearchLeaguesScreen> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customLeagueController =
        Provider.of<CustomLeagueController>(context, listen: false);

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
                      title: "Ligas comuns",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextfieldWithLabelWidget(
                        text: null,
                        hint: "Código da liga",
                        controller: codeController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 75, right: 8),
                          child: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              customLeagueController
                                  .searchPlayers(codeController.text);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "Ligas comuns públicas",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: customLeagueController.openLeaguesLength(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: LeagueInfoWidget(
                            name: customLeagueController
                                .getOpenLeagueNameIndex(index),
                            creator: customLeagueController
                                .getOpenLeagueCreatorIndex(index),
                            position: 0,
                            points: -1,
                            players: customLeagueController
                                .getOpenLeagueMembersIndex(index),
                            onTap: () => customLeagueController
                                .getLeagueMembers(customLeagueController
                                    .getOpenLeagueId(index))
                                .then(
                                  (_) => Navigator.of(context).pushNamed(
                                    AppRoutes.customLeague,
                                    arguments: customLeagueController
                                        .getOpenLeagueId(index),
                                  ),
                                ),
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
