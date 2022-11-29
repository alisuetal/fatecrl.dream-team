import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/ghost_button_widget.dart';
import '../tools/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Dream Team",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 40, letterSpacing: 1),
                      ),
                      SvgPicture.asset(
                        "assets/svg/logo.svg",
                        height: 156,
                        width: 156,
                      ),
                      Text(
                        "Escale seu time.\nLidere\nGanhe.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 32,
                              height: 1.5,
                              letterSpacing: 1,
                            ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWidget(
                        text: "Cadastro",
                        materialIcon: null,
                        function: () {
                          Navigator.of(context).pushNamed(AppRoutes.signUp);
                        },
                        enabled: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GhostButtonWidget(
                          text: "Entrar",
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.logIn);
                          },
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
