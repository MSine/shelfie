import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/group_model.dart';
import 'user_details_card.dart';
import 'group_details_card.dart';

class PromotedCard extends StatelessWidget{
  final Promotable promotable;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const PromotedCard({
    Key? key,
    required this.promotable,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (promotable is User) {
      return UserDetailsCard(
        user: promotable as User,
        onAccept: onAccept,
        onDecline: onDecline,
      );
    }
    return GroupDetailsCard(
      group: promotable as Group,
      onAccept: onAccept,
      onDecline: onDecline,
    );
  }
}