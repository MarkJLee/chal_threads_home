import 'package:chal_threads_home/features/authentication/repos/authentication_repo.dart';
import 'package:chal_threads_home/features/authentication/views/login_screen.dart';
import 'package:chal_threads_home/features/profile/view_models/dark_mode_mv.dart';
import 'package:chal_threads_home/features/profile/views/privacy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 임시
final isLoadingProvider = StateProvider<bool>((ref) => false);

class SettingsScreen extends ConsumerWidget {
  static const String routeURL = "/settings";
  static const String routeName = "settings";
  const SettingsScreen({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // isLoading, _displayLogOutDialog 함수는 임시로 추가 (다음에 수정)
    final isLoading = ref.watch(isLoadingProvider);
    void _displayLogOutDialog(BuildContext context) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Log out?'),
            content: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  "assets/8.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  ref.read(authRepo).signOut();
                  context.goNamed(LoginScreen.routeName);
                },
              ),
            ],
          );
        },
      );
    }

    void _showLogOutDialog(BuildContext context) async {
      await Future.delayed(const Duration(seconds: 1));

      _displayLogOutDialog(context);
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.dark_mode_outlined,
            size: 30,
          ),
          title: const Text(
            "Dark mode",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          trailing: CupertinoSwitch(
            value: ref.watch(darkModeProvider).isDarkMode,
            onChanged: (value) =>
                ref.read(darkModeProvider.notifier).setDarkMode(value),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.person_add_outlined,
            size: 30,
          ),
          title: const Text(
            "Follow and invite friends",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.notifications_none_outlined,
            size: 30,
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.lock_outlined,
            size: 30,
          ),
          title: const Text(
            "Privacy",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () => context.goNamed(PrivacyScreen.routeName),
        ),
        ListTile(
          leading: const Icon(
            Icons.account_circle_outlined,
            size: 30,
          ),
          title: const Text(
            "Account",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.support,
            size: 30,
          ),
          title: const Text(
            "Help",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.info_outline,
            size: 30,
          ),
          title: const Text(
            "About",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _showLogOutDialog(context),
                child: const Text(
                  "Log out",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              isLoading ? const CupertinoActivityIndicator() : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
