

import 'package:hodhod/app/types/enum.dart';

class MoreModel {
  MoreModel({
    this.icon,
    this.name,
    this.isWeb,
    this.keyPage,
    required this.key,
  });

  String? icon;
  String? name;
  String? keyPage;
  bool? isWeb;
  MoreType key;
}
