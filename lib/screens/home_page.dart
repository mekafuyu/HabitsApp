import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/habits/user.dart';
import 'package:habitsapp/models/form_edit_task.dart';
import 'package:habitsapp/models/form_new_task.dart';
import 'package:habitsapp/models/habit_provider.dart';
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
            appState.useLocally
                ? UserCard(user: appState.user)
                : FutureBuilder<User?>(
                    future: appState.futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return UserCard(user: snapshot.data);
                      } else {
                        return Text('Error');
                      }
                    }),
            appState.useLocally
                ? Expanded(
                    child: ListView(
                      children: [
                        for (var habit in appState.habits)
                          TaskCard(
                            habit: habit,
                            openModal: openModal,
                          )
                      ],
                    ),
                  )
                : FutureBuilder<List<Habit>>(
                    future: appState.futureHabits,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return //TaskCard(habit: snapshot.data!);
                            Expanded(
                          child: ListView(
                            children: [
                              for (var habit in snapshot.data!)
                                if (habit.enable)
                                  TaskCard(habit: habit, openModal: openModal)
                            ],
                          ),
                        );
                      } else {
                        return const Text('No habit data');
                      }
                    },
                  ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          // appState.fetchHabits();
          openModal(context, null);
        },
      ),
    );
  }

  Future openModal(BuildContext context, Habit? habit) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              habit == null ? const FormNewTask() : FormEditTask(habit: habit)
            ],
          ),
        );
      },
    );
  }
}
