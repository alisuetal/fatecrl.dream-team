import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/square_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenHolderWidget(
      content: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            fit: BoxFit.cover,
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
                    const AppBarWidget(
                      title: "Perfil",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Stack(
                        children: [
                          Container(
                            height: 128,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 158, 59, 59),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 64),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 128,
                                  width: 128,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 148, 129, 47),
                                    border: Border.all(
                                      color: const Color(0xff222222),
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(64),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Apelido",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 24,
                                    ),
                              ),
                              Text(
                                "@username",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 20,
                                      color: const Color(0xff888888),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        children: const [
                          Flexible(
                            child: SquareInformationWidget(
                              info: "0",
                              label: "Points",
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: SquareInformationWidget(
                              info: "0",
                              label: "leonitas",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        "Outros status",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: InlineInformationWidget(
                        leftText: "Pontos na última rodada",
                        rightText: "0",
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
