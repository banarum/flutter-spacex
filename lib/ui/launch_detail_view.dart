import 'package:flutter/cupertino.dart';

class LaunchDetailView extends StatefulWidget {
  final LaunchArguments args;

  LaunchDetailView({Key? key, required this.args}) : super(key: key);

  @override
  LaunchDetailState createState() => LaunchDetailState();
}

class LaunchDetailState extends State<LaunchDetailView> {
  /*void gotoRoom([Room? room]) {
    Navigator.of(context)
        .pushNamed("/room", arguments: new RoomArguments(room))
        .then((value) => setState(() {
              roomsRequest = BankstaApi.shared.getRooms(APP_USER_ID);
            }));
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Cupertino Store'),
      ),
      child: Container(),
    );
  }
}

class LaunchArguments {
  //final int id;

  LaunchArguments();
}
