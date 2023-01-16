import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;

  const CustomAppBar({super.key, required this.appBar, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      centerTitle: true,
      actions: const [LogoutBtn()],
    );
  }

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Size get preferredSize =>
      Size.fromHeight(appBar.preferredSize.height / 100 * 80);
}








// --------------------------- 참고
class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Theme theme;

  const CustomAppBar2({
    Key? key,
    this.leading,
    this.title,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// This part is copied from AppBar class
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    Widget? leadingIcon = leading;

    if (leadingIcon == null && automaticallyImplyLeading) {
      if (hasDrawer) {
        leadingIcon = IconButton(
          icon: const Icon(Icons.mood_sharp, color: Colors.yellowAccent),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      } else {
        if (canPop) {
          leadingIcon = IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.sentiment_dissatisfied_sharp,
              color: Colors.red,
            ),
          );
        }
      }
    }

    return AppBar(
      leading: leadingIcon,
      title: title,
      centerTitle: centerTitle,
      elevation: 1,
      // backgroundColor: Colors.red,
      // foregroundColor: Colors.amber,
      actions: const [LogoutBtn()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
