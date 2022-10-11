import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/header_profile_picture_widget.dart';
import 'package:dream_team/components/league_info_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/controllers/sponsors_league.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/ghost_button_widget.dart';

class LeaguesScreen extends StatefulWidget {
  final void Function()? changePage;
  const LeaguesScreen({this.changePage, Key? key}) : super(key: key);

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);
    final sponsorLeagueController =
        Provider.of<SponsorsLeagueController>(context, listen: false);

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
                      title: "Ligas",
                      rightWidget: HeaderProfilePictureWidget(
                        imgSrc:
                            "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                        function: widget.changePage != null
                            ? () => widget.changePage!()
                            : () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Liga do coração",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: LeagueInfoWidget(
                        name: sponsorLeagueController
                            .getUserLeague(userController.getLeague()),
                        creator: "",
                        position: userController.user.position,
                        points: userController.getPoint(),
                        onTap: () => sponsorLeagueController
                            .getLeagueMembers(
                                userController.user.sponsorsLeague ?? 0)
                            .then(
                              (_) => Navigator.of(context)
                                  .pushNamed(AppRoutes.league),
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: "Ver mais",
                        function: () {},
                        enabled: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Ligas comuns",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: LeagueInfoWidget(
                        name: "Mockup",
                        creator: "Mockup creator",
                        position: 1,
                        points: 12.3,
                        onTap: () =>
                            Navigator.of(context).pushNamed(AppRoutes.league),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: "Ver mais",
                        function: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.searchLeagues);
                        },
                        enabled: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: GhostButtonWidget(
                        text: "Criar liga comum",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.createLeague);
                        },
                        color: Theme.of(context).colorScheme.primary,
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
