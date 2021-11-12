import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magangskipsi/cubit/page_cubit.dart';
import 'package:magangskipsi/ui/pages/Intern_KMI.dart';
import 'package:magangskipsi/ui/pages/Intern_bumn.dart';
import 'package:magangskipsi/ui/pages/Main_page.dart';
import 'package:magangskipsi/ui/pages/change_password_page.dart';
import 'package:magangskipsi/ui/pages/evaluasi_page.dart';
import 'package:magangskipsi/ui/pages/signIn.dart';
import 'package:magangskipsi/ui/pages/Intern_personals.dart';
import 'package:magangskipsi/ui/pages/succes_submission.dart';
import 'package:magangskipsi/ui/pages/testfile.dart';
import 'ui/pages/Splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/SignInPage': (context) => SignInPage(),
          '/ChangePass': (context) => ChangePass(),
          '/MainPage': (context) => MainxPage(),
          '/MagangPersonals': (context) => Magangpersonals(),
          '/MagangBumn': (context) => MagangBumn(),
          '/MagangKMI': (context) => MagangKMI(),
          '/EvaluasiPage': (context) => EvaluasiPage(),
          '/SuccessSubmission': (context) => SuccesSubmissionPage(),
          '/testfile': (context) => UploadFilePage(),
        },
      ),
    );
  }
}
