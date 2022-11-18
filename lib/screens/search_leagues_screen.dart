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
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: TextfieldWithLabelWidget(
                        hint: "Código da liga",
                      ),
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
                      itemCount: customLeagueController.publicLeaguesLength(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: LeagueInfoWidget(
                            name: customLeagueController
                                .getPublicLeagueNameIndex(index),
                            creator: customLeagueController
                                .getPublicLeagueCreatorIndex(index),
                            position: 0,
                            points: -1,
                            players: customLeagueController
                                .getPublicLeagueMembersIndex(index),
                            onTap: () => customLeagueController
                                .getLeagueMembers(customLeagueController
                                    .getPublicLeagueId(index))
                                .then(
                                  (_) => Navigator.of(context).pushNamed(
                                    AppRoutes.customLeague,
                                    arguments: customLeagueController
                                        .getPublicLeagueId(index),
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
