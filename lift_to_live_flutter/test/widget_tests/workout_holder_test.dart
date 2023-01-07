import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/workout_set.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/workout_set_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';

void main() {
  testWidgets('WorkoutHolder test constructor thumb up', (tester) async {
      // tests
      // final List<WorkoutSet> workSets = [WorkoutSet('A', [1, 2, 3], [1, 2, 3], 'A', false), WorkoutSet('B', [1, 2, 3], [1, 2, 3], 'B', false), WorkoutSet('C', [1, 2, 3], [1, 2, 3], 'C', false)];
      // final List<TextEditingController> reps = [], kilos = [], completes = [];
      //
      // List<WorkoutSetHolder> workoutItems = <WorkoutSetHolder>[];
      // int j = 0;
      // for(WorkoutSet set in workSets) {
      //   j++;
      //   List<WorkoutSetTaskHolder> workoutSetItems = <WorkoutSetTaskHolder>[];
      //   for(int i = 0; i < set.reps.length; i++) {
      //     var rc = TextEditingController();
      //     var kc = TextEditingController();
      //     var cc = TextEditingController();
      //
      //     rc.text = set.reps[i].toString();
      //     kc.text = set.kilos[i].toString();
      //     cc.text = set.isCompleted.toString();
      //
      //     reps.add(rc);
      //     kilos.add(kc);
      //     completes.add(cc);
      //
      //     var newWidget = WorkoutSetTaskHolder(repsController: rc, kilosController: kc, isCompletedController: cc, isEnabled: true,);
      //     workoutSetItems.add(newWidget);
      //   }
      //
      //   var exC = SingleValueDropDownController();
      //   var noC = TextEditingController();
      //   workoutItems.add(WorkoutSetHolder(workoutSetItems: workoutSetItems, exerciseController: exC, noteController: noC, isEnabled: true, exercises: const ['Ex 1', 'Ex 2'], index: j,));
      // }
      //
      // var widget = SizedBox(height: 400, width: 400,child: Column(children: workoutItems,));
      //
      // await tester.pumpWidget(MaterialApp(
      //     title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(height: 600, width: 400, color: Helper.blueColor,child: widget),))));
      //
      // await tester.pump(const Duration(seconds: 3));
      // await tester.pumpAndSettle();
      //
      // var finder = find.text('1').first;
      // await tester.enterText(finder, '200');
      //
      // await tester.pumpAndSettle();
      // await tester.pump(const Duration(seconds: 3));
      //
      // expect(reps[0].text, '200');
      // expect(completes[0].text, 'false');
      //
      // var finder2 = find.byType(Checkbox).first;
      // await tester.tap(finder2);
      //
      // await tester.pumpAndSettle();
      // await tester.pump(const Duration(seconds: 3));
      //
      // expect(completes[0].text, 'true');
      //
      // await tester.enterText(finder, '200');
      //
      // await tester.pumpAndSettle();
      // await tester.pump(const Duration(seconds: 3));
      //
      // await tester.enterText(finder, 'Azis');
      //
      // await tester.pumpAndSettle();
      // await tester.pump(const Duration(seconds: 3));

    });
}
