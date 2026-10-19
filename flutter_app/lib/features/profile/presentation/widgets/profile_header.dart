import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:streetbite/features/profile/presentation/widgets/profile_avatar.dart';

/// Green gradient header with the large avatar, name and email.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.photo,
    required this.isUploading,
    required this.onAvatarTap,
  });

  final String name;
  final String email;
  final Uint8List? photo;
  final bool isUploading;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.paddingOf(context).top + 24,
        20,
        28,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primary, Color.lerp(primary, Colors.black, 0.18)!],
        ),
      ),
      child: Column(
        children: [
          ProfileAvatar(
            radius: 56,
            ringColor: Colors.white,
            photo: photo,
            isUploading: isUploading,
            onTap: onAvatarTap,
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
