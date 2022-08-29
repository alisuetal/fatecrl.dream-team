import 'package:dream_team/components/amount_widget.dart';
import 'package:dream_team/components/app_bar_widget.dart';
import 'package:dream_team/components/button_widget.dart';
import 'package:dream_team/components/inline_information_widget.dart';
import 'package:dream_team/components/screen_holder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/amount_with_label_widget.dart';
import '../components/round_icon_widget.dart';
import '../components/small_inline_information_widget.dart';
import '../components/textfield_with_label_widget.dart';

class CreateLeagueScreen extends HookWidget {
  const CreateLeagueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPrivate = useState(false);
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
                      title: "Criar liga",
                      leftWidget: RoundIconWidget(
                        icon: Icons.arrow_back_rounded,
                        function: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextfieldWithLabelWidget(
                        text: null,
                        hint: "Nome da liga",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AmountWithLabelWidget(
                        hint: "Quantidade de participantes",
                        amount: 0,
                        onDecrease: () {},
                        onIncrease: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AmountWithLabelWidget(
                        hint: "Quantidade de rodadas",
                        amount: 0,
                        onDecrease: () {},
                        onIncrease: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: isPrivate.value,
                            onChanged: (_) =>
                                isPrivate.value = !isPrivate.value,
                          ),
                          Text(
                            "Privado",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ButtonWidget(
                        text: "Criar",
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
