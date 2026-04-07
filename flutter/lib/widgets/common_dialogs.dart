import 'package:flutter/material.dart';

class CommonDialogs {
  // 확인용 팝업
  static void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = '확인',
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 팝업 닫기
              if (onPressed != null) onPressed();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  // 선택 확인용 팝업
  static void showConfirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = '확인',
    String cancelText = '취소',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          // 취소 버튼
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel();
            },
            child: Text(cancelText, style: const TextStyle(color: Colors.grey)),
          ),
          // 확인 버튼
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(confirmText, style: const TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }
}