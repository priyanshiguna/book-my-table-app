import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../packages/cached_network_image/cached_network_image.dart';
import '../../../../res/app_custom_color.dart';
import '../../components/tab_content_switcher.dart';
import 'restaurant_detail_controller.dart';

class RestaurantDetailScreen extends StatelessWidget {
  RestaurantDetailScreen({super.key});

  final RestaurantDetailController con = Get.put(RestaurantDetailController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(isReverse: false, systemNavigationBarColor: Theme.of(context).primaryColor, statusBarIconBrightness: Brightness.light),
      child: Obx(
        () => Scaffold(
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
                actions: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: customColors(context).backgroundLight.withAlpha(14)),
                      child: AppIconButton(
                        icon: SvgPicture.asset(
                          AppAssets.shareIcon,
                          height: 20,
                          colorFilter: ColorFilter.mode(customColors(context).whiteColor, BlendMode.srcIn),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 3).copyWith(right: defaultPadding / 2),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: customColors(context).backgroundLight.withAlpha(14)),
                      child: AppIconButton(
                        icon: SvgPicture.asset(
                          con.isLiked.isTrue ? AppAssets.heartFillIcon : AppAssets.heartIcon,
                          height: 20,
                          colorFilter: ColorFilter.mode(customColors(context).whiteColor, BlendMode.srcIn),
                        ),
                        onPressed: () {
                          con.isLiked.value = !con.isLiked.value;
                        },
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: EdgeInsets.zero,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      /// Restaurant Image
                      AppNetworkImage(
                        imageUrl: 'https://interiordesign.net/wp-content/uploads/2024/04/InteriorDesign_March2024_Brave-New-World-11-1024x768.jpg',
                        height: double.infinity,
                        width: double.infinity,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        fit: BoxFit.cover,
                        errorWidget: Container(
                          // color: Theme.of(context).scaffoldBackgroundColor,
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withCtmOpacity(.15)),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Rating and Restaurant Name Section
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Rating
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.starIcon, height: 16, width: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    '4.8',
                                    style: AppTextStyle.subtitleStyle(context, fontWeight: FontWeight.w600, fontSize: 14.sp, color: customColors(context).textFieldBorder),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '(365 reviews)',
                                    style: AppTextStyle.subtitleStyle(context)?.copyWith(fontSize: 14.sp, color: customColors(context).textFieldBorder),
                                  ),
                                ],
                              ),
                              defaultPadding.verticalSpace,

                              /// Restaurant Name
                              Text(
                                'LibertyBite Bistro',
                                style: AppTextStyle.titleStyle(context, color: customColors(context).kPrimaryColor),
                              ),
                              defaultPadding.verticalSpace,

                              /// Location
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.locationSVG, height: 16, width: 16),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '1089 Ocean avenue , New york, USA',
                                      maxLines: 2,
                                      overflow: .ellipsis,
                                      style: AppTextStyle.subtitleStyle(context)?.copyWith(fontSize: 14.sp, color: customColors(context).textPrimaryBlack),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// Tab Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            indicatorWeight: 3,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: customColors(context).textPrimaryBlack,
                            controller: con.tabController,
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: customColors(context).textGreyMedium,
                            labelStyle: AppTextStyle.subtitleStyle(context, fontWeight: FontWeight.w500),
                            unselectedLabelStyle: AppTextStyle.subtitleStyle(context, color: customColors(context).textFieldBorder, fontWeight: .w400),
                            tabs: const [
                              Tab(text: 'About'),
                              Tab(text: 'Gallery'),
                              Tab(text: 'Review'),
                            ],
                          ),
                        ),

                        /// Tab Views (replaced TabBarView with a simple switcher widget)
                        TabContentSwitcher(
                          controller: con.tabController,
                          about: _buildAboutTab(context),
                          gallery: _buildGalleryTab(context),
                          review: _buildReviewTab(context),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          bottomNavigationBar: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimaryColor.withCtmOpacity(0.2),
                  blurRadius: 22,
                  spreadRadius: 1,
                  offset: const Offset(0, -8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.paddingOf(context).bottom + defaultPadding),
              child: AppButton(
                title: 'Book a Table',
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Get.toNamed(AppRoutes.bookATableScreen);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyle.subtitleStyle(context, fontWeight: FontWeight.w500, fontSize: 14.sp, color: customColors(context).whiteColor.withCtmOpacity(.7)),
    );
  }

  //* About Tab
  Widget _buildAboutTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(context, 'About'),

          12.verticalSpace,
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
            style: AppTextStyle.subtitleStyle(context)?.copyWith(fontSize: 12.sp, fontWeight: .w400),
          ),
          defaultPadding.verticalSpace,

          titleWidget(context, 'Restaurant Contact'),

          (defaultPadding / 2).verticalSpace,

          Row(
            children: [
              AppNetworkImage(
                imageUrl: 'https://t3.ftcdn.net/jpg/06/01/50/96/360_F_601509638_jDwIDvlnryPRhXPsBeW1nXv90pdlbykC.jpg',
                width: 50,
                height: 50,
                backgroundColor: customColors(context).lightGrey,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(100),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget(context, 'Bessie Cooper'),
                  Text(
                    'Owner',
                    style: AppTextStyle.subtitleStyle(context, fontSize: 12.sp, fontWeight: .w500, color: customColors(context).textPrimaryBlack),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          titleWidget(context, 'Opening Hours'),
          const SizedBox(height: 12),
          _buildHourRow(context, 'Monday', '10:00 AM - 10:00 PM'),
          _buildHourRow(context, 'Tuesday', '10:00 AM - 10:00 PM'),
          _buildHourRow(context, 'Wednesday', '10:00 AM - 10:00 PM'),
        ],
      ),
    );
  }

  Widget _buildHourRow(BuildContext context, String day, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: AppTextStyle.subtitleStyle(context, fontSize: 14.sp)),
          Text(
            hours,
            style: AppTextStyle.subtitleStyle(context, color: customColors(context).textPrimaryBlack, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  //* Gallery Tab
  Widget _buildGalleryTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          titleWidget(context, 'Gallery'),
          defaultPadding.verticalSpace,

          GridView.builder(
            shrinkWrap: true,
            padding: .zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  color: customColors(context).lightGrey,
                  child: const AppNetworkImage(
                    imageUrl: 'https://interiordesign.net/wp-content/uploads/2024/04/InteriorDesign_March2024_Brave-New-World-11-1024x768.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //* Review Tab
  Widget _buildReviewTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          titleWidget(context, 'Reviews'),
          defaultPadding.verticalSpace,
          _buildReviewCard(context, 'Bessie Cooper', '11 months ago', 'Lorem ipsum'),
          const SizedBox(height: 16),
          _buildReviewCard(context, 'Arlene McCoy', '2 months ago', 'Lorem ipsum'),
          const SizedBox(height: 16),
          _buildReviewCard(context, 'Ralph Edwards', '1 week ago', 'Lorem ipsum'),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, String name, String time, String review) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppNetworkImage(
              imageUrl: 'https://t3.ftcdn.net/jpg/06/01/50/96/360_F_601509638_jDwIDvlnryPRhXPsBeW1nXv90pdlbykC.jpg',
              width: 50,
              height: 50,
              fit: .cover,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            12.horizontalSpace,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.subtitleStyle(context, fontWeight: FontWeight.w500, fontSize: 16.sp, color: customColors(context).kPrimaryColor),
                  ),
                  Text(
                    time,
                    style: AppTextStyle.subtitleStyle(context, fontSize: 12.sp, fontWeight: .w500, color: customColors(context).textFieldBorder),
                  ),
                ],
              ),
            ),
          ],
        ),

        defaultPadding.verticalSpace,
        // Review
        Text(
          '"the pain of an average man." The phrase is used as a placeholder in web development because.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, fontWeight: .w500, color: customColors(context).textFieldBorder),
        ),
      ],
    );
  }
}
