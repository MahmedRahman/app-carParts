import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpart/app/data/component/CustomIndicator.dart';
import 'package:flutter/material.dart';


class CustomImageCached extends StatelessWidget {
  CustomImageCached({@required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25)
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CustomIndicator(
            indicatorStatus: IndicatorStatus.imageplaceholder,
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: CustomIndicator(
            indicatorStatus: IndicatorStatus.error,
          ),
        ),
      ),
    );
  }
}
