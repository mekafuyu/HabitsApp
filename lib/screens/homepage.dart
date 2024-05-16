import 'package:flutter/material.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/models/form_new_task.dart';
import 'package:habitsapp/models/taskcard.dart';
import 'package:habitsapp/models/usercard.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const UserCard(),
            Expanded(
              child: ListView(
                children: [
                  for (var habit in appState.habits) TaskCard(habit: habit)
                ],
              ),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          openModal(context);
        },
      ),
    );
  }

  Future openModal(BuildContext context) {
    return showMaterialModalBottomSheet(
      // clipBehavior: ,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [FormNewTask()],
          ),
        );
      },
    );
  }
}
