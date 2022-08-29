import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/header_profile_picture_widget.dart';
import 'package:dream_team/components/league_info_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:dream_team/components/textfield_widget.dart';
import 'package:dream_team/components/textfield_with_label_widget.dart';
import 'package:dream_team/tools/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/ghost_button_widget.dart';
import '../components/round_icon_widget.dart';

class ChangeUserInfoScreen extends HookWidget {
  const ChangeUserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    final visibility = useState<bool>(arguments[1] as bool);
    print(visibility.value);
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
                      title: "Alterar ${arguments[0]}",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        arguments[0],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: const Color(0xffAAAAAA),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              visibility.value
                                  ? arguments[3]
                                  : arguments[3]
                                      .toString()
                                      .split('')
                                      .map((e) => "*")
                                      .join(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                          ),
                          if (!arguments[1])
                            GestureDetector(
                              onTap: () => visibility.value = !visibility.value,
                              child: Icon(
                                visibility.value
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                              ),
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextfieldWithLabelWidget(
                        obscure: arguments[1],
                        hint:
                            "Alterar ${arguments[0].toString().toLowerCase()}",
                      ),
                    ),
                    if (arguments[2])
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextfieldWidget(
                          obscure: arguments[1],
                          hint:
                              "Confirmar ${arguments[0].toString().toLowerCase()}",
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: "Alterar",
                        function: () {},
                        enabled: true,
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
