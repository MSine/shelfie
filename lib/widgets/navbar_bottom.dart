import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side Buttons
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color: currentIndex == 0 ? Colors.blue : Colors.grey),
                onPressed: () => onTap(0),
              ),
              IconButton(
                icon: Icon(Icons.explore, color: currentIndex == 1 ? Colors.blue : Colors.grey),
                onPressed: () => onTap(1),
              ),
            ],
          ),
          // Right Side Buttons
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.message, color: currentIndex == 3 ? Colors.blue : Colors.grey),
                onPressed: () => onTap(3),
              ),
              IconButton(
                icon: Icon(Icons.person, color: currentIndex == 4 ? Colors.blue : Colors.grey),
                onPressed: () => onTap(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
