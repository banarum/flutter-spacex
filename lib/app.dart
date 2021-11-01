import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/network/repository.dart';
import 'package:flutter_spacex/ui/launch_detail_view.dart';
import 'package:flutter_spacex/ui/launches_table_view.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repository,
        child: CupertinoApp(
          title: 'SpaceX official',
          onGenerateRoute: (RouteSettings settings) {
            var routes = <String, WidgetBuilder>{
              "/": (ctx) => const LaunchTableView(),
              "/launch": (ctx) =>
                  LaunchDetailView(args: settings.arguments as LaunchArguments),
            };
            WidgetBuilder builder = routes[settings.name]!;
            return CupertinoPageRoute(builder: (ctx) => builder(ctx));
          },
        ));
  }
}
