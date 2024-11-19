import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loading_view.dart';

Widget displayImageFromNetwork(String imageUrl, BoxFit fit, double width,
    double height, double borderRadius) {
  return CachedNetworkImage(
    useOldImageOnUrlChange: true,
    fit: BoxFit.cover,
    imageUrl: imageUrl,
    width: width,
    height: height,
    placeholder: (context, url) => const Center(child: LoadingView()),
    errorWidget: (context, url, error) => Center(
      child: Icon(Icons.error, size: 24.0.r, color: Colors.red),
    ),
    fadeOutDuration: const Duration(seconds: 0),
    fadeInDuration: const Duration(seconds: 0),
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          fit: fit,
          image: imageProvider,
        ),
      ),
    ),
  );
}
