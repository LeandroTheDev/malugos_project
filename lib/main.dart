import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:malugos_project/data/mysqldata.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:malugos_project/pages/authpage.dart';
import 'package:malugos_project/pages/authremember.dart';
import 'package:malugos_project/pages/drawer_page/category_pages/keybord_category.dart';
import 'package:malugos_project/pages/drawer_page/category_pages/monitor_category.dart';
import 'package:malugos_project/pages/drawer_page/category_pages/mouse_category.dart';
import 'package:malugos_project/pages/drawer_page/categorypage.dart';
import 'package:malugos_project/pages/drawer_page/configurationpage.dart';
import 'package:malugos_project/pages/drawer_page/profilepage.dart';
import 'package:malugos_project/pages/drawer_page/profilepage/deliverylocation.dart';
import 'package:malugos_project/pages/drawer_page/profilepage/details.dart';
import 'package:malugos_project/pages/drawer_page/profilepage/history.dart';
import 'package:malugos_project/pages/home_page/featurepage.dart';
import 'package:malugos_project/pages/home_page/finishpurchase.dart';
import 'package:malugos_project/pages/home_page/mostsellpage.dart';
import 'package:malugos_project/pages/home_page/promopage.dart';
import 'package:malugos_project/pages/homepage.dart';
import 'package:provider/provider.dart';

Future main() async {
  //Loads the configurations
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_live_51MFJv1FxdtyBnlAXresWRrKid8jvOKJc2VkUm5LGtjORilwz4dS8l9DOVC1J0GsyIapM5fXxOgBZOrwXiC5Ouyg000uSKS15PU';
  await UserPreferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Options(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Malugos',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24),
        primarySwatch: Colors.lightGreen,
      ),
      routes: {
        '/authpage': (context) => const AuthPage(),
        '/homepage': (context) => const HomePage(),
        '/categorypage': (context) => const CategoryPage(),
        '/configurationpage': (context) => const ConfigurationPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/featurepage': (context) => const FeaturePage(),
        '/keyboardCategory': (context) => const KeybordCategory(),
        '/mouseCategory': (context) => const MouseCategory(),
        '/monitorCategory': (context) => const MonitorCategory(),
        '/promopage': (context) => const PromoPage(),
        '/mostsellpage': (context) => const MostSellPage(),
        '/finishpurchase': (context) => const FinishPurchase(),
        '/history': (context) => const History(),
        '/deliverylocation': (context) => const DeliveryLocation(),
        '/details': (context) => const DetailsPage(),
        '/paymentpage': (context) => const PaymentPage(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthRemember();
  }
}
