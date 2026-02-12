import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_app/services/outlet_report_service.dart';
import 'package:survey_app/utils/globalfns.dart';
import 'package:survey_app/utils/yekonga/ye_gvars.dart';
import 'package:survey_app/views/all_forms.dart';
import 'package:survey_app/views/auth/login.dart';
import 'package:survey_app/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outlet Interaction Report',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.knaufBlue,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: PreLoader(),
    );
  }
}

class PreLoader extends StatefulWidget {
  const PreLoader({super.key});

  @override
  State<PreLoader> createState() => _PreLoaderState();
}

class _PreLoaderState extends State<PreLoader> {
  @override
  void initState() {
    initter();
    super.initState();
  }

  void initter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    var uAccessToken = prefs.getString(ygAccesstoken);
    var uRefreshToken = prefs.getString(ygRefreshtoken);
    if (uAccessToken == null && uRefreshToken == null) {
      moover(Login());
    } else {
      refreshit(uRefreshToken);
    }
  }

  void refreshit(refreshToken) async {
    var quer =
        """
query {
  refreshToken(refreshToken:"$refreshToken") {
    refreshToken
    accessToken
  }
}
""";

    try {
      var res = await YeGenV1().shooterAuth(query: quer);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (res[respGood]) {
        var tokenizer = res[respBody][ygdata][ygRefreshtoken];
        if (tokenizer != null) {
          var uAccessToken = tokenizer[ygAccesstoken];
          var uRefreshToken = tokenizer[ygRefreshtoken];
          await prefs.setString(ygAccesstoken, uAccessToken);
          await prefs.setString(ygRefreshtoken, uRefreshToken);
          moover(AllForms());
        } else {
          var err = res[respBody][ygerrors][0][ygmsg];
          showToast(isGood: false, message: "$err");
          moover(Login());
        }
      } else {
        showToast(isGood: false, message: "Oops! Failed");
        moover(Login());
      }
    } catch (e) {
      moover(Login());
    }
  }

  void moover(Widget dest) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return dest;
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
