import 'package:flutter/material.dart';
import 'package:organaki_app/core/colors_app.dart';
import 'package:go_router/go_router.dart';
import 'package:organaki_app/modules/authentication/pages/login_page.dart';
import 'package:organaki_app/modules/home/pages/home_map_page.dart';
import 'package:organaki_app/modules/home/pages/home_orders_page.dart';
import 'package:organaki_app/modules/producer/pages/producer_account_page.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int currentIndex = 0;

  void changeIndexNavigator(int index) {
    setState(() => currentIndex = index);
  }

  final List<BarItem> barItems = [
    BarItem(
      text: 'Map',
      icon: Icons.home,
    ),
    BarItem(
      text: 'Orders',
      icon: Icons.history,
    ),
    BarItem(
      text: 'Account',
      icon: Icons.account_circle,
    ),
  ];

  final List<Widget> children = [
    const HomeMapPage(),
    const HomeOrdersPage(),
    const LoginPage(),
    const ProducerAccountPage()
  ];

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    FocusManager.instance.primaryFocus?.unfocus();
    final String location = route.location;
    if (location.startsWith('/map')) {
      return 0;
    }
    if (location.startsWith('/list')) {
      return 1;
    }
    if (location.startsWith('/account')) {
      if (location.startsWith('/account/login')) {
        return 2; //loginPage
      }
      if (location.startsWith('/account/account')) {
        return 3; //ProducerEditPage
      }
    }
    return 0;
  }

  int teste = 0;
  void onTap(int value) {
    switch (value) {
      case 0:
        teste = 0;
        return context.go('/map');
      case 1:
        teste = 1;
        return context.go('/list');
      case 2:
        teste = 2;
        return context.go('/account');
      default:
        teste = 0;
        return context.go('/map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
            index: _calculateSelectedIndex(context), children: children),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: teste,
          selectedItemColor: ColorApp.blue3,
          onTap: onTap,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Abhaya Libre',
            fontWeight: FontWeight.w600,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Mapa'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Produtores'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: 'Conta'),
          ],
        ));
  }
}

/*class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem>? barItems;
  final Function? onBarTap;
  final bool? isItemsPage;
  final String? pageKey;
  final bool? isAccountPage;
  final int? indexNavigator;

  const AnimatedBottomBar({
    super.key,
    this.barItems,
    this.onBarTap,
    this.isItemsPage,
    this.pageKey,
    this.isAccountPage,
    this.indexNavigator,
  });

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 0;
  Duration duration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    selectedBarIndex = widget.indexNavigator ?? 0;
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> barItems = [];
    for (int i = 0; i < widget.barItems!.length; i++) {
      BarItem item = widget.barItems![i];

      //bool isSelected = selectedBarIndex == i;

      barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap!(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          duration: duration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: <Widget>[
                  Icon(
                    item.icon,
                    color: ColorApp.blue3,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    item.text,
                    style: TextStyle(
                      fontFamily: 'Abhaya Libre',
                      color: ColorApp.blue3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return barItems;
  }
}*/

class BarItem {
  String text;
  IconData icon;

  BarItem({required this.text, required this.icon});
}
