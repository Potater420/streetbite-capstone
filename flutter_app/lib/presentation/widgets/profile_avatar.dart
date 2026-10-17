import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// 64-px round avatar from the Figma Profile screen. Tap to change the photo.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.photo,
    required this.isUploading,
    required this.onTap,
  });

  final Uint8List? photo;
  final bool isUploading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Tooltip(
      message: context.l10n.changePhoto,
      child: GestureDetector(
        onTap: isUploading ? null : onTap,
        child: SizedBox(
          width: 64,
          height: 64,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: primary.withValues(alpha: 0.12),
                backgroundImage: photo == null ? null : MemoryImage(photo!),
                child: photo == null
                    ? Icon(Icons.person, size: 36, color: primary)
                    : null,
              ),
              if (isUploading)
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black38,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
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
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: primary,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}