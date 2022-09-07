import 'package:dream_team/controllers/user.dart';
import 'package:dream_team/screens/change_user_info_screen.dart';
import 'package:dream_team/screens/create_league_screen.dart';
import 'package:dream_team/screens/league_screen.dart';
import 'package:dream_team/screens/search_leagues_screen.dart';
import 'package:dream_team/screens/settings_screen.dart';
import 'package:dream_team/screens/team_screen.dart';
import 'package:dream_team/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/complete_sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'screens/log_in_screen.dart';
import 'screens/player_market_screen.dart';
import 'tools/app_routes.dart';
import 'tools/color_utilities.dart';

void main() {
  runApp(const Providers());
}

class Providers extends StatelessWidget {
  const Providers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DreamTeam();
  }
}

class DreamTeam extends StatelessWidget {
  const DreamTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserControler(),
        ),
      ],
      child: MaterialApp(
        title: "Dream Team",
        theme: ThemeData(
          fontFamily: "Coolvetica",
          primarySwatch: ColorUtilities.createMaterialColor(
            const Color(0xffE56B44),
          ),
          backgroundColor: const Color(0xff222222),
          brightness: Brightness.dark,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
            headline3: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
            headline4: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            bodyText1: TextStyle(
              fontSize: 20,
              fontFamily: "Coolvetica",
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              fontSize: 16,
              fontFamily: "Coolvetica",
              color: Colors.white,
            ),
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.signUp: (context) => SignUpScreen(),
          AppRoutes.logIn: (context) => LogInScreen(),
          AppRoutes.completeSignUp: (context) => const CompleteSignUpScreen(),
          AppRoutes.team: (context) => const TeamScreen(),
          AppRoutes.playerMarket: (context) => const PlayerMarketScreen(),
          AppRoutes.league: (context) => const LeagueScreen(),
          AppRoutes.createLeague: (context) => const CreateLeagueScreen(),
          AppRoutes.searchLeagues: (context) => const SearchLeaguesScreen(),
          AppRoutes.settings: (context) => const SettingsScreen(),
          AppRoutes.changeUserInfo: (context) => const ChangeUserInfoScreen(),
        },
      ),
    );
  }
}
