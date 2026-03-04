import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../packages/cached_network_image/cached_network_image.dart';
import '../../../../res/app_custom_color.dart';
import 'restaurant_detail_controller.dart';

class RestaurantDetailScreen extends StatelessWidget {
  RestaurantDetailScreen({super.key});

  final RestaurantDetailController con = Get.put(RestaurantDetailController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(isReverse: false, systemNavigationBarColor: Theme.of(context).primaryColor, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          shrinkWrap: true,
          physics: const RangeMaintainingScrollPhysics(),
          controller: con.scrollController.value,
          slivers: [
            /// Pinned header with image and actions
            SliverAppBar(
              pinned: true,
              stretch: true,
              expandedHeight: Get.width,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 6,
              forceElevated: true,
              collapsedHeight: (kToolbarHeight + defaultPadding),
              toolbarHeight: (kToolbarHeight + defaultPadding),
              centerTitle: false,
              titleSpacing: 0,
              leadingWidth: 62,
              leading: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2).copyWith(right: defaultPadding / 3),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: customColors(context).backgroundLight.withAlpha(14)),
                  child: AppIconButton(
                    icon: SvgPicture.asset(
                      AppAssets.backArrowIcon,
                      colorFilter: ColorFilter.mode(customColors(context).whiteColor, BlendMode.srcIn),
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
              actions: [],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.zero,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    /// Recipe Image
                    AppNetworkImage(
                      imageUrl: 'https://media.istockphoto.com/id/632439546/photo/pasta-plate.jpg?s=612x612&w=0&k=20&c=zZPaNg_mf7cTVIeJPFVRtsjYClNYkGMcUc5ZBrARwZU=',
                      height: double.infinity,
                      width: double.infinity,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      fit: BoxFit.cover,
                      errorWidget: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withCtmOpacity(.15)),
                          // child: Center(
                          //   child: SvgPicture.asset(
                          //     AppAssets.recipeEmptyState,
                          //     height: double.infinity,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Content
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 1000,
                  color: Colors.white,
                  child: const Column(
                    children: [],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
