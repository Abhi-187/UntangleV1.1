import 'package:flutter/material.dart';
import 'package:untangle/helpers.dart';
import 'package:untangle/pages/calls_page.dart';
import 'package:untangle/pages/contacts_page.dart';
import 'package:untangle/pages/messages_page.dart';
import 'package:untangle/pages/notifications_page.dart';
import 'package:untangle/theme.dart';
import 'package:untangle/widgets/widgets.dart';
import 'package:untangle/widgets/glowing_action_button.dart';
import 'package:untangle/widgets/icons_buttons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: const TextStyle(
                color: AppColors.textHighlight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              print('TODOsearch');
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  ValueChanged<int> onItemSelected;
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
        color: (brightness == Brightness.light) ? Colors.transparent : null,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        child: SafeArea(
            top: false,
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _NavigationBarItem(
                      index: 0,
                      lable: 'Messages',
                      icon: Icons.message,
                      isSelected: (selectedIndex == 0),
                      onTap: handleItemSelected),
                  _NavigationBarItem(
                      index: 1,
                      lable: 'Notification',
                      icon: Icons.notifications,
                      isSelected: (selectedIndex == 1),
                      onTap: handleItemSelected),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GlowingActionButton(
                        color: AppColors.secondary,
                        icon: Icons.add,
                        onPressed: () {
                          print('TO DO on new message');
                        }),
                  ),
                  _NavigationBarItem(
                      index: 2,
                      lable: 'Calls',
                      icon: Icons.call_sharp,
                      isSelected: (selectedIndex == 2),
                      onTap: handleItemSelected),
                  _NavigationBarItem(
                      index: 3,
                      lable: 'Contacts',
                      icon: Icons.contacts,
                      isSelected: (selectedIndex == 3),
                      onTap: handleItemSelected),
                ],
              ),
            )));
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
