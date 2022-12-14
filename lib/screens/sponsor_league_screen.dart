import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/controllers/sponsors_league.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/round_icon_widget.dart';
import '../components/small_inline_information_widget.dart';

class SponsorLeagueScreen extends StatefulWidget {
  const SponsorLeagueScreen({Key? key}) : super(key: key);

  @override
  State<SponsorLeagueScreen> createState() => _SponsorLeagueScreenState();
}

class _SponsorLeagueScreenState extends State<SponsorLeagueScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);
    final sponsorLeagueController =
        Provider.of<SponsorsLeagueController>(context, listen: false);
    final arguments = ModalRoute.of(context)?.settings.arguments as int;
    final leagueId = arguments;

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
                      title: sponsorLeagueController.getLeagueNameId(leagueId),
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    if (leagueId == userController.user.sponsorsLeague!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              "Seus status",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: const Color(0xffAAAAAA),
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: InlineInformationWidget(
                              leftText: "Pontos",
                              rightText: userController.user.point.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: InlineInformationWidget(
                              leftText: "Posi????o",
                              rightText:
                                  userController.user.position.toString(),
                            ),
                          ),
                        ],
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
                      itemCount: sponsorLeagueController.getMembersLength(),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SmallInlineInformationWidget(
                            iconText:
                                "#${sponsorLeagueController.getMemberPosition(index)}",
                            leftText: sponsorLeagueController
                                .getMemberNickname(index),
                            rightText:
                                "${sponsorLeagueController.getMemberPoints(index)} pts",
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
