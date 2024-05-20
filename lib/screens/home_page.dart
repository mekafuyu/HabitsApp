import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/models/form_new_task.dart';
import 'package:habitsapp/models/task_card.dart';
import 'package:habitsapp/models/user_card.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<HabitProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const UserCard(),
            FutureBuilder<Habit>(
                future: appState.futureHabit,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return TaskCard(habit: snapshot.data!);
                  } else {
                    return const Text('No habit data');
                  }
                },
              ),
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
          appState.fetchHabits();
          //openModal(context);
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
