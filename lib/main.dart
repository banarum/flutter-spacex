import 'package:flutter/cupertino.dart';
import 'package:fluuter_spacex/ui/launch_detail_view.dart';
import 'package:fluuter_spacex/ui/launches_table_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'SpaceX official',
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "/": (ctx) => LaunchTableView(),
          "/launch": (ctx) => LaunchDetailView(args: settings.arguments as LaunchArguments),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return CupertinoPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}



