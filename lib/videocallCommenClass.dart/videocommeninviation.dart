// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// import '../core/utils/image_constant.dart';
// import '../widgets/custom_image_view.dart';

// String? imageurlCheck;

// Widget customAvatarBuilder(
//   BuildContext context,
//   Size size,
//   ZegoUIKitUser? user,
//   Map<String, dynamic> extraInfo,
// ) {
//   return imageurlCheck?.isNotEmpty == true || imageurlCheck != null
//       ? CachedNetworkImage(
//           imageUrl: imageurlCheck!,
//           imageBuilder: (context, imageProvider) => Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: imageProvider,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           progressIndicatorBuilder: (context, url, downloadProgress) =>
//               CircularProgressIndicator(value: downloadProgress.progress),
//           errorWidget: (context, url, error) {
//             ZegoLoggerService.logInfo(
//               '$user avatar url is invalid',
//               tag: 'live audio',
//               subTag: 'live page',
//             );
//             return ZegoAvatar(user: user, avatarSize: size);
//           },
//         )
//       : CustomImageView(
//           imagePath: ImageConstant.tomcruse,
//           height: 30,
//           width: 30,
//         );
// }
