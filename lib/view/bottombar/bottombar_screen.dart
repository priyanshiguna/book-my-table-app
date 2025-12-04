import 'package:animations/animations.dart';
import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:book_my_table_app/view/bottombar/bottombar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import 'components/bottombar_tile.dart';
import 'enum/bottombar_enum.dart';

class BottombarScreen extends StatelessWidget {
  BottombarScreen({super.key});

  final BottombarController con = Get.put(BottombarController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor).copyWith(systemNavigationBarDividerColor: Theme.of(context).dividerTheme.color),
      child: Obx(
        () => PopScope(
          canPop: BottombarTab.values.first == con.selectedBottomTab.value,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              con.selectedBottomTab.value = BottombarTab.values.first;
            }
          },
          child: Scaffold(
            body: PageTransitionSwitcher(
              reverse: con.isLoggedIn.value,
              transitionBuilder: (Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
                return SharedAxisTransition(animation: animation, secondaryAnimation: secondaryAnimation, transitionType: SharedAxisTransitionType.horizontal, fillColor: const Color.fromARGB(0, 255, 255, 255), child: child);
              },
              child: SizedBox(key: ValueKey<BottombarTab>(con.selectedBottomTab.value), child: BottombarTab.getBodyWidget(con.selectedBottomTab.value)),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            bottomNavigationBar: BottomAppBar(
              notchMargin: 6,
              elevation: 35,
              shadowColor: customColors(context).textPrimaryBlack,
              color: customColors(context).surfaceColor,
              padding: EdgeInsets.symmetric(horizontal: 4),
              shape: AutomaticNotchedShape(RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
              child: Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [bottomTab(1), bottomTab(2), bottomTab(3), bottomTab(4)])),
            ),
          ),
        ),
      ),
    );
  }

  BottombarTile bottomTab(int index) => BottombarTile(
    isSelected: con.selectedBottomTab.value == BottombarTab.fromId(index),
    title: BottombarTab.fromId(index).label,
    image: con.selectedBottomTab.value == BottombarTab.fromId(index) ? BottombarTab.fromId(index).selectedImage : BottombarTab.fromId(index).unselectImage,
    onTap: () {
      con.onBottomBarTap(hapticFeedback: true, BottombarTab.fromId(index));
    },
  );
}
