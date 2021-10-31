import 'package:flutter/cupertino.dart';
import 'package:fluuter_spacex/network/api.dart';

class LaunchTableView extends StatefulWidget {
  LaunchTableView({Key? key}) : super(key: key);

  @override
  LaunchTableState createState() => LaunchTableState();
}

class LaunchTableState extends State<LaunchTableView> {
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

    SpaceXApi.shared.getUpcomingLaunches().then((rsp) => print(rsp[0].rocketData!.name));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('SpaceX'),
      ),
      child: Container(),
    );
  }
}
