import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/square_information_widget.dart';
import 'package:dream_team/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserScreen extends HookWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserController>(context, listen: false);

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
                    const AppBarWidget(
                      title: "Perfil",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(64),
                                child: SizedBox(
                                  height: 128,
                                  width: 128,
                                  child: Image.network(
                                    "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                                  ),
                                ),
                              ),
                            ],
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
                                user.user.name ?? "!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 24,
                                    ),
                              ),
                              Text(
                                "@${user.user.nickname}",
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
                        children: [
                          Flexible(
                            child: SquareInformationWidget(
                              info: user.user.point.toString(),
                              label: "Points",
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: SquareInformationWidget(
                              info: user.user.leonita.toString(),
                              label: "leonitas",
                            ),
                          ),
                        ],
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
