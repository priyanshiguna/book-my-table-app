import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:book_my_table_app/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../exports.dart';
import '../utils/common_enums.dart';

Future<void> showCommonOverlay<T>(
  BuildContext context, {
  required GlobalKey key,
  List<T>? items,
  String Function(T)? displayItem,
  String? selectedValue,
  String? emptyMessage,
  double? width,
  double? height,
  double? topPadding,
  void Function()? onShow,
  double? itemSpacing = 3,
  Widget? child,
  bool? withAllAccounts = false,
  bool? showDivider = false,
  bool? showScrollbar = false,
  bool? showOnlyText = false,
  Function(T)? onItemSelected,
  void Function()? onRemove,
  RadioButtonType? radioButtonType,
  EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(vertical: defaultPadding / 2),
}) async {
  final RenderBox? widgetRenderBox = key.currentContext?.findRenderObject() as RenderBox?;
  if (widgetRenderBox == null) return;

  final Offset position = widgetRenderBox.localToGlobal(Offset.zero);
  final double widgetHeight = widgetRenderBox.size.height;
  final double screenHeight = Get.height;

  final double spaceBelow = screenHeight - position.dy - widgetHeight;
  final double spaceAbove = position.dy;

  bool showAbove = spaceBelow < 100 && spaceAbove > spaceBelow;

  // Determine item count based on provided items (not global accounts list)
  int itemCount = (items?.length ?? 0);

  double overlayHeight = (height ?? (itemCount * 50.0 + (itemSpacing ?? 0))) + (padding?.vertical ?? 0);

  if (spaceBelow < overlayHeight) {
    overlayHeight = spaceBelow;
  }

  removeOverlay();
  showOverlay(
    context,
    onShow: onShow,
    onClose: () {},
    child: Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => removeOverlay(onRemove: onRemove),
          child: SizedBox(height: Get.height, width: Get.width),
        ),
        Positioned(
          top: showAbove ? position.dy - (defaultPadding) : position.dy + widgetHeight + (topPadding ?? defaultPadding / 2),
          right: defaultPadding,

          left: width != null
              ? (Get.width - width) /
                    1.3 // Center the overlay if width is provided
              : defaultPadding, // Align with the button if no width is provided

          child: SizedBox(
            width: width ?? Get.width, // Use passed width or match button
            height: overlayHeight,
            child: FadeTransitionOverlay<T>(items: items, displayItem: displayItem, selectedValue: selectedValue, onItemSelected: onItemSelected, emptyMessage: emptyMessage, width: width, radioButtonType: radioButtonType, padding: padding, itemSpacing: itemSpacing, withAllBranch: withAllAccounts, showDivider: showDivider, showScrollbar: showScrollbar, showOnlyText: showOnlyText, child: child),
          ),
        ),
      ],
    ),
  );
}

class FadeTransitionOverlay<T> extends StatefulWidget {
  final List<T>? items;
  final Function(T)? onItemSelected;
  final String Function(T)? displayItem;
  final String? selectedValue;
  final String? emptyMessage;
  final Widget? child;
  final double? width;
  final RadioButtonType? radioButtonType;
  final EdgeInsetsGeometry? padding;
  final double? itemSpacing;
  final bool? withAllBranch;
  final bool? showDivider;
  final bool? showScrollbar;
  final bool? showOnlyText;

  const FadeTransitionOverlay({super.key, this.items, this.onItemSelected, this.displayItem, this.selectedValue, this.emptyMessage, this.child, this.width, this.radioButtonType, this.padding, this.itemSpacing, this.withAllBranch = false, this.showDivider = false, this.showScrollbar = false, this.showOnlyText = false});

  @override
  State<FadeTransitionOverlay> createState() => _FadeTransitionOverlayState<T>();
}

class _FadeTransitionOverlayState<T> extends State<FadeTransitionOverlay<T>> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _animationController.forward();
  }

  void closeOverlayWithAnimation() {
    _animationController.reverse().then((_) {
      if (mounted) {
        removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AppOverlaySelection<T>(
        items: widget.items,
        displayItem: widget.displayItem,
        selectedValue: widget.selectedValue,
        onItemSelected: (item) {
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(item);
          }
          closeOverlayWithAnimation();
        },
        emptyMessage: widget.emptyMessage,
        width: widget.width,
        radioButtonType: widget.radioButtonType,
        padding: widget.padding,
        itemSpacing: widget.itemSpacing,
        withAllAccounts: widget.withAllBranch,
        showOnlyText: widget.showOnlyText,
        showDivider: widget.showDivider,
        showScrollbar: widget.showScrollbar,
        child: widget.child,
      ),
    );
  }
}

class AppOverlaySelection<T> extends StatefulWidget {
  final List<T>? items;
  final Function(T)? onItemSelected;
  final String Function(T)? displayItem;
  final String? selectedValue;
  final String? emptyMessage;
  final Widget? child;
  final double? width;
  final RadioButtonType? radioButtonType;
  final EdgeInsetsGeometry? padding;
  final double? itemSpacing;
  final bool? withAllAccounts;
  final bool? showDivider;
  final bool? showScrollbar;
  final bool? showOnlyText;

  const AppOverlaySelection({super.key, this.items, this.onItemSelected, this.displayItem, this.selectedValue, this.emptyMessage, this.child, this.width, this.radioButtonType, this.padding, this.itemSpacing, this.withAllAccounts = false, this.showDivider = false, this.showScrollbar = false, this.showOnlyText = false});

  @override
  AppOverlaySelectionState<T> createState() => AppOverlaySelectionState<T>();
}

class AppOverlaySelectionState<T> extends State<AppOverlaySelection<T>> {
  final ScrollController _sc = ScrollController(initialScrollOffset: 0);

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        // width: widget.width ?? Get.width,
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: defaultPadding),
        margin: const EdgeInsets.only(bottom: defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, spreadRadius: 0, offset: const Offset(0, 3))],
        ),
        child:
            widget.child ??
            ((widget.items?.isNotEmpty ?? false)
                ? MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: CupertinoScrollbar(
                      thumbVisibility: widget.showScrollbar,
                      controller: _sc,
                      child: ListView.separated(
                        controller: _sc,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        itemCount: widget.items?.length ?? 0,
                        separatorBuilder: (context, index) => widget.showDivider == false
                            ? SizedBox(height: widget.itemSpacing ?? 3)
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                child: Divider(thickness: 1, height: widget.itemSpacing ?? 1, color: const Color(0xffE5E7EB)),
                              ),
                        itemBuilder: (context, index) {
                          // First item → All branch widget
                          /*  if (widget.withAllAccounts == true && baseCon.allAccountsList.length >= 2 && index == 0) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: (defaultPadding / 2)),
                              child: allBranchWidget(),
                            ).paddingOnly(bottom: widget.itemSpacing ?? 3);
                          }

                          final realIndex = (widget.withAllAccounts == true && baseCon.allAccountsList.length >= 2) ? index - 1 : index;
 */
                          final item = widget.items?[index];
                          final itemText = item != null ? (widget.displayItem != null ? widget.displayItem!(item) : "") : "";
                          final isSelected = itemText == widget.selectedValue;

                          return SizedBox(
                            width: Get.width / 2,
                            child: AnimatedContainer(
                              duration: defaultDuration,
                              decoration: BoxDecoration(color: (widget.radioButtonType == null) ? (isSelected ? Theme.of(context).primaryColor.withAlpha(15) : null) : null, borderRadius: BorderRadius.circular(defaultRadius)),
                              margin: const EdgeInsets.symmetric(horizontal: (defaultPadding / 2)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(defaultRadius),
                                onTap: () {
                                  if (widget.onItemSelected != null) {
                                    widget.onItemSelected!(item as T);
                                  }
                                },
                                child: ListTile(
                                  dense: true,
                                  minVerticalPadding: 0,
                                  contentPadding: const EdgeInsets.only(left: defaultPadding / 2, right: defaultPadding / 2),
                                  titleAlignment: ListTileTitleAlignment.center,
                                  title: Text(
                                    itemText,
                                    style: (isSelected
                                        ? (widget.radioButtonType == null)
                                              ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Theme.of(context).primaryColor)
                                              : Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp)
                                        : Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                                  ),
                                  trailing: (widget.radioButtonType != null)
                                      ? IntrinsicWidth(
                                          child: CustomRadioButton(radioButtonType: widget.radioButtonType!, isSelected: RxBool(isSelected)),
                                        )
                                      : (isSelected ? Icon(Icons.check, color: Theme.of(context).primaryColor) : const SizedBox()),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Text(
                    widget.emptyMessage ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textPrimaryBlack),
                  )),
      ),
    );
  }
}
