import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// Round avatar with a camera badge. Tap it to change the photo.
/// [ringColor] draws a ring around it (used on the green profile header).
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.photo,
    required this.isUploading,
    required this.onTap,
    this.radius = 32,
    this.ringColor,
  });

  final Uint8List? photo;
  final bool isUploading;
  final VoidCallback onTap;
  final double radius;
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final badgeSize = radius * 0.62;

    return Tooltip(
      message: context.l10n.changePhoto,
      child: GestureDetector(
        onTap: isUploading ? null : onTap,
        child: Container(
          padding: EdgeInsets.all(ringColor == null ? 0 : 4),
          decoration: BoxDecoration(shape: BoxShape.circle, color: ringColor),
          child: SizedBox(
            width: radius * 2,
            height: radius * 2,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: radius,
                  backgroundColor: primary.withValues(alpha: 0.12),
                  backgroundImage: photo == null ? null : MemoryImage(photo!),
                  child: photo == null
                      ? Icon(Icons.person, size: radius * 1.1, color: primary)
                      : null,
                ),
                if (isUploading)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black38,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: radius * 0.6,
                          height: radius * 0.6,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                PositionedDirectional(
                  end: 0,
                  bottom: 0,
                  child: Container(
                    width: badgeSize,
                    height: badgeSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0x33000000), blurRadius: 4),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: badgeSize * 0.55,
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
