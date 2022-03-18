import 'package:brillo_connetz_app/models/match_modal.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:flutter/material.dart';
class MatchedUserTile extends StatefulWidget {
  final MatchUsersModel users;
  const MatchedUserTile({Key? key, required this.users}) : super(key: key);

  @override
  _MatchedUserTileState createState() => _MatchedUserTileState();
}

class _MatchedUserTileState extends State<MatchedUserTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(widget.users.profileImageUrl.toString()),
      ),
      title: Text(widget.users.firstName.toString(),
        style: Theme.of(context).textTheme.caption!.copyWith(color: kTextColor),

      ),

      subtitle: Text(widget.users.lastName.toString(),
        style: Theme.of(context).textTheme.caption!.copyWith(color: kTextColor),

      ),
    );
  }
}
