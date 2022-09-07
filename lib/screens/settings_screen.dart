import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/header_profile_picture_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final void Function()? changePage;
  const SettingsScreen({this.changePage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController user = Provider.of<UserController>(context);
    print(user.user.email);
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
                      title: "Ajustes",
                      rightWidget: HeaderProfilePictureWidget(
                        imgSrc:
                            "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                        function:
                            changePage != null ? () => changePage!() : () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        enabled: true,
                        function: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.changeUserInfo,
                            arguments: [
                              "Apelido",
                              false,
                              false,
                              user.user.nickname,
                              100
                            ],
                          );
                        },
                        text: "Alterar apelido",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ButtonWidget(
                        enabled: true,
                        function: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.changeUserInfo,
                            arguments: [
                              "E-mail",
                              false,
                              true,
                              user.user.email,
                            ],
                          );
                        },
                        text: "Alterar e-mail",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ButtonWidget(
                        enabled: true,
                        function: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.changeUserInfo,
                            arguments: [
                              "Senha",
                              true,
                              true,
                              user.user.password,
                            ],
                          );
                        },
                        text: "Alterar senha",
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
