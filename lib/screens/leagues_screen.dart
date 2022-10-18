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
  bool _verMais = false;

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
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount:
                            _verMais ? sponsorLeagueController.length() : 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: LeagueInfoWidget(
                              name: _verMais
                                  ? sponsorLeagueController
                                      .getLeagueNameIndex(index)
                                  : sponsorLeagueController.getLeagueNameId(
                                      userController.user.sponsorsLeague!),
                              creator: "",
                              position: _verMais &&
                                      !sponsorLeagueController.isHisLeague(
                                          index,
                                          userController.user.sponsorsLeague!)
                                  ? -1
                                  : userController.user.position,
                              points: _verMais &&
                                      !sponsorLeagueController.isHisLeague(
                                          index,
                                          userController.user.sponsorsLeague!)
                                  ? -1
                                  : userController.getPoint(),
                              onTap: () => sponsorLeagueController
                                  .getLeagueMembers(_verMais
                                      ? sponsorLeagueController
                                          .getLeagueId(index)
                                      : userController.user.sponsorsLeague!)
                                  .then(
                                    (_) => Navigator.of(context).pushNamed(
                                        AppRoutes.sponsorLeague,
                                        arguments: _verMais
                                            ? sponsorLeagueController
                                                .getLeagueId(index)
                                            : userController
                                                .user.sponsorsLeague!),
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: _verMais ? "Ver menos" : "Ver mais",
                        function: () => setState(() {
                          _verMais = !_verMais;
                        }),
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
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.customLeague),
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
