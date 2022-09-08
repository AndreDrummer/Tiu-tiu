import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tiutiu/core/utils/image_handle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdImages extends StatelessWidget {
  const AdImages({
    required this.photos,
    super.key,
  });

  final List photos;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0.h),
          topLeft: Radius.circular(8.0.h),
        ),
      ),
      height: Get.height / 1.8,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: photos.length,
        itemBuilder: (ctx, index, i) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              width: double.infinity,
              child: AssetHandle.getImage(photos.elementAt(index)),
            ),
          );
        },
        options: CarouselOptions(
          enableInfiniteScroll: photos.length > 1,
          autoPlayCurve: Curves.easeIn,
          disableCenter: true,
          viewportFraction: 1,
          autoPlay: true,
        ),
      ),
    );
    ;
  }
}
