import 'dart:io';

import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/dialog_widget.dart';
import 'package:dream_team/components/ghost_button_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/leonitas_market_widget.dart';
import 'package:dream_team/components/player_team_card_widget.dart';
import 'package:dream_team/components/pop_up_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/controllers/custom_league.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/tools/app_routes.dart';
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
    final customLeagueController = Provider.of<CustomLeagueController>(context);
    final leagueId = ModalRoute.of(context)?.settings.arguments as int;

    Future<bool> entryLeague(int id) async {
      final entryValue =
          int.parse(customLeagueController.getEntryValueId(leagueId));
      if (userController.user.leonita! < entryValue) {
        showAlertDialog(context, "Erro", "Leonitas insuficientes", false);
        return false;
      }
      final leonita = await userController
          .upDateLeonita(userController.user.leonita! - entryValue);
      if (!leonita) {
        showAlertDialog(context, "Erro", "Tente novamente mais tarde", false);
        return false;
      }
      final add =
          await customLeagueController.addUser(userController.user.email!, id);
      if (!add) {
        showAlertDialog(context, "Erro", "Tente novamente mais tarde", false);
        return false;
      }
      return true;
    }

    Future<bool> exitLeague(int leagueId) async {
      final bool response = await showDialogWidget(
          context, "Atenção", "Deseja mesmo sair?", "Cancelar", "Sair");
      if (response) {
        final remove = await customLeagueController.removeUser(
            userController.user.email!, leagueId);
        return remove;
      }
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
                      rightWidget: !customLeagueController.isPrivate(leagueId)
                          ? LeonitasMarketWidget(
                              leonitas: userController.user.leonita!)
                          : Container(),
                    ),
                    Text(
                      "Criador: ${customLeagueController.getCreatorNameId(leagueId)} • Código: ${customLeagueController.getCodeId(leagueId)} ${!customLeagueController.isPrivate(leagueId) ? " • ${customLeagueController.getOpenLeagueMembersId(leagueId)} participantes" : ""}",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                          ),
                    ),
                    if (customLeagueController.isPrivate(leagueId))
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
                              rightText: customLeagueController
                                  .getUserPointsId(leagueId)
                                  .toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: InlineInformationWidget(
                              leftText: "Posição",
                              rightText: customLeagueController
                                  .getUserPositionId(leagueId)
                                  .toString(),
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
                    if (!customLeagueController.isPrivate(leagueId))
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ButtonWidget(
                          text:
                              "Entrar \$${customLeagueController.getEntryValueId(leagueId)}",
                          function: () =>
                              entryLeague(leagueId).then((response) {
                            if (response) {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            }
                          }),
                          enabled: true,
                        ),
                      ),
                    if (customLeagueController.isPrivate(leagueId) &&
                        userController.user.nickname !=
                            customLeagueController.getCreatorNameId(leagueId))
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: GhostButtonWidget(
                          text: "Sair",
                          onTap: () => exitLeague(leagueId).then((response) {
                            if (response) {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            }
                          }),
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
