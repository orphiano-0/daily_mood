import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const SettingsButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.inversePrimary, width: 4),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20,),
            const SizedBox(width: 10),
            Text(
              text.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Pixel',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
