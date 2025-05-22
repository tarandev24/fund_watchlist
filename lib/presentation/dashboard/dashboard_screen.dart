import 'package:flutter/material.dart';
import 'package:fund_watchlist/presentation/charts/fund_dashboard.dart';
import 'package:fund_watchlist/presentation/home/home_screen.dart';
import 'package:fund_watchlist/theme/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
    int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FundDashboardScreen(),
    Center(child: Text("Watchlist Screen")),
  ];

  @override


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            child: SizedBox(
                height: 25,
                width: 25,
                child: Image.asset('assets/icons/app_icon.png')),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 5.0, 10.0),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            )
          ],
        ),
         body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.black,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: Colors.grey.shade600,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Charts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: 'Watchlist',
            ),
          ],
        ),
      ),
    );
  }
}
