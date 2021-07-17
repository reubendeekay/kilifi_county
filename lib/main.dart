import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:kilifi_county/providers/dark_mode_provider.dart';
import 'package:kilifi_county/providers/post_provider.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:kilifi_county/screens/add_post_screen.dart';
import 'package:kilifi_county/screens/auth_screen.dart';
import 'package:kilifi_county/screens/bottom_navigation.dart';
import 'package:kilifi_county/screens/chat/chatrooms.dart';
import 'package:kilifi_county/screens/chat/chatscreem.dart';
import 'package:kilifi_county/screens/complete_profile_screen.dart';
import 'package:kilifi_county/screens/forum/comments_screen.dart';
import 'package:kilifi_county/screens/forum/forum_search_screen.dart';

import 'package:kilifi_county/screens/forum/widgets/floating_button.dart';
import 'package:kilifi_county/screens/news_details.dart';
import 'package:kilifi_county/screens/profile/widgets/account_details_screen.dart';
import 'package:kilifi_county/screens/services/about_us.dart';
import 'package:kilifi_county/screens/services/appointment_status_screen.dart';
import 'package:kilifi_county/screens/services/appointments_screen.dart';
import 'package:kilifi_county/screens/services/consultation_screen.dart';
import 'package:kilifi_county/screens/services/gallery_screen.dart';
import 'package:kilifi_county/screens/services/job_details_screen.dart';
import 'package:kilifi_county/screens/services/job_oppportunities_screen.dart';
import 'package:kilifi_county/screens/services/services_screen.dart';
import 'package:kilifi_county/widgets/media_grid.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          }),
          ChangeNotifierProvider.value(value: UsersProvider()),
          ChangeNotifierProvider.value(value: PostProvider()),
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MediaQuery(
                child: child,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            // home: StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (ctx, snapshot) =>
            //       snapshot.hasData ? MyNav() : AuthScreen(),
            // ),
            home: AboutUs(),
            routes: {
              NewsDetailsScreen.routeName: (ctx) => NewsDetailsScreen(),
              ServicesScreen.routeName: (ctx) => ServicesScreen(),
              AddPostScreen.routeName: (ctx) => AddPostScreen(),
              FloatingButton.routeName: (ctx) => FloatingButton(),
              Gallery.routeName: (ctx) => Gallery(),
              CompleteProfileScreen.routeName: (ctx) => CompleteProfileScreen(),
              CommentsScreen.routeName: (ctx) => CommentsScreen(),
              ChatRooms.routeName: (ctx) => ChatRooms(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
              AccountDetailsScreen.routeName: (ctx) => AccountDetailsScreen(),
              AppointmentsScreen.routeName: (ctx) => AppointmentsScreen(),
              AppointmentStatusScreen.routeName: (ctx) =>
                  AppointmentStatusScreen(),
              ForumSearchScreen.routeName: (ctx) => ForumSearchScreen(),
              ConsultationScreen.routeName: (ctx) => ConsultationScreen(),
              JobOpportunitiesScreen.routeName: (ctx) =>
                  JobOpportunitiesScreen(),
              JobDetailsScreen.routeName: (ctx) => JobDetailsScreen(),
              GalleryScreen.routeName: (ctx) => GalleryScreen(),
              AboutUs.routeName: (ctx) => AboutUs(),
            },
          );
        }));
  }
}
