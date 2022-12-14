import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/league_info_widget.dart';
import 'package:dream_team/components/leonitas_market_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/user.dart';
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
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customLeagueController =
        Provider.of<CustomLeagueController>(context, listen: false);
    final userController = Provider.of<UserController>(context, listen: false);

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
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: "Ligas comuns",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () =>
                            setState(() => Navigator.of(context).pop()),
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextfieldWithLabelWidget(
                              text: null,
                              hint: "C??digo da liga",
                              controller: codeController,
                              onChange: (_) => customLeagueController
                                  .searchLeagues(codeController.text)),
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
                                      .searchLeagues(codeController.text);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "Ligas comuns p??blicas",
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
                                  (_) => Navigator.of(context)
                                      .pushNamed(
                                        AppRoutes.customLeague,
                                        arguments: customLeagueController
                                            .getOpenLeagueId(index),
                                      )
                                      .then((_) => setState(() {})),
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
