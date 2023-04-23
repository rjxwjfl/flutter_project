import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/view/dowith/project/model/entry_view_ui.dart';

class UserSummary extends StatelessWidget {
  const UserSummary({required this.data, required this.callback, Key? key}) : super(key: key);

  final MembersListModel data;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: data.imageUrl == null || data.imageUrl == ""
                    ? Text(
                        data.name[0].toUpperCase(),
                        style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.onSecondary),
                      )
                    : null,
              ),
            ),
            Text(
              data.name,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w500
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              intToString(data.role),
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
