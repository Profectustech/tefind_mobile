import 'package:flutter/material.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/utils/app_colors.dart';

void showte_findSnackBar(String message, Widget? icon, bool success) {
  final overlay = Overlay.of(NavigatorService.navigationKey_.currentContext!);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 80,
      left: 90,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient:  LinearGradient(
              colors:success? [AppColors.primaryColor, Color(0xFF40B98D)]:[AppColors.red, AppColors.red.withOpacity(0.6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              if (icon != null) icon,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () => overlayEntry.remove(),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 5), () {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}
