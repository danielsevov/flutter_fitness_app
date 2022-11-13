import 'package:lift_to_live_flutter/domain/entities/article.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/domain/entities/image.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/entities/token.dart';
import 'package:lift_to_live_flutter/domain/entities/user.dart';

class TestData {
  static final User test_user_1 = User('user@email.com', 'user@email.com', 'coach@email.com', 'NL', '23/12/1999', 'Test User', '5555555555');
  static final User test_coach_1 = User('coach@email.com', 'coach@email.com', 'admin@email.com', 'NL', '23/12/1999', 'Test Coach', '5555555555');

  static final Article test_article_1 = Article('A', 'A', 'A', 'A', 'A', 'A');
  static final Article test_article_2 = Article('B', 'B', 'B', 'B', 'B', 'B');

  static final HabitTask test_habit_task_1 = HabitTask('A', false);
  static final HabitTask test_habit_task_2 = HabitTask('B', false);
  static final HabitTask test_habit_task_3 = HabitTask('C', false);
  static final HabitTask test_habit_task_4 = HabitTask('A', true);

  static final List<HabitTask> test_list_tasks_1 = [TestData.test_habit_task_1, TestData.test_habit_task_2, TestData.test_habit_task_3];
  static final List<HabitTask> test_list_tasks_2 = [TestData.test_habit_task_4, TestData.test_habit_task_2, TestData.test_habit_task_3];
  static final List<HabitTask> test_list_tasks_3 = [TestData.test_habit_task_1];

  static final Habit test_habit_1 = Habit(1, 'A', 'A', 'A', 'A', false, test_list_tasks_1);
  static final Habit test_habit_2 = Habit(1, 'A', 'A', 'A', 'A', false, []);
  static final Habit test_habit_3 = Habit(1, 'A', 'A', 'A', 'A', true, test_list_tasks_1);

  static final MyImage test_image_1 = MyImage('A', 'A', 1, 'A', '4444');
  static final MyImage test_image_2 = MyImage('B', 'B', 2, 'B', 'B');

  static final News test_news_1 = News('A', 1, [test_article_1]);
  static final News test_news_2 = News('B', 2, [test_article_1, test_article_2]);

  static final Token test_token_1 = Token('A');
  static final Token test_token_2 = Token('B');

  static final Role test_role_1 = Role('A', 'A');
  static final Role test_role_2 = Role('B', 'B');

}