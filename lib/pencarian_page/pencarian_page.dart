import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_search_view.dart';
import 'widgets/list2mobile_item_widget.dart';

class PencarianPage extends StatelessWidget {
  PencarianPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: appTheme.gray100,
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgGroup175),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: AppDecoration.fillGray.copyWith(
              image: DecorationImage(
                image: AssetImage(ImageConstant.imgGroup175),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 22.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildPencarian(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPencarian(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.v),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 17.h),
              child: Text(
                "Kategori",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(height: 26.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: CustomSearchView(
              controller: searchController,
              hintText: "Pencarian",
            ),
          ),
          SizedBox(height: 32.v),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 2.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return List2mobileItemWidget(
                onTapList2mobile: () => onTapList2mobile(context),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Navigates to the detailKategoriContainerScreen when the action is triggered.
  void onTapList2mobile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.detailKategoriContainerScreen);
  }
}
