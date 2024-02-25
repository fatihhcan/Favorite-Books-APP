import 'package:favorite_books_app/feature/favorite_books/view/favorite_books_view.dart';
import 'package:favorite_books_app/feature/home/view/home_view.dart';
import 'package:flutter/material.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const HomeView());
      case NavigationConstants.FAVORITES_BOOKS_VIEW:
        return normalNavigate(const FavoriteBooks());
      default:
        return normalNavigate(const NotFoundNavigation());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}



class NotFoundNavigation extends StatefulWidget {
  const NotFoundNavigation({Key? key}) : super(key: key);

  @override
  _NotFoundNavigationState createState() => _NotFoundNavigationState();
}

class _NotFoundNavigationState extends State<NotFoundNavigation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Navigation not found'),
    );
  }
}
