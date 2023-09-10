import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

class Node {
  final EnglishLevel level;
  final TestTaskModel testTask;
  final int correctlyGuessedThisLevel;
  Node? leftChild; // incorrect
  Node? rightChild; //correct
  bool isFinalNode;
  Node(this.level, this.correctlyGuessedThisLevel, this.testTask, this.leftChild, this.rightChild,
      {this.isFinalNode = false});

  factory Node.finalNode(Node previousNode) =>
      Node(previousNode.level, previousNode.correctlyGuessedThisLevel, TestTaskModel.empty(), null, null,
          isFinalNode: true);
}

class LevelTestTasksTree {
  Node addChild(TestTaskModel testTask, int correctlyGuessedAtThisLevel) {
    return Node(EnglishLevel.levelFromString(testTask.level), correctlyGuessedAtThisLevel, testTask, null, null);
  }

  Future<void> buildATree(List<TestTaskModel> allTasks, List<TestTaskModel> pastTasks, Node startNode) async {
    try {
      final level = startNode.level;
      final correctlyGuessedAtThisPoint = startNode.correctlyGuessedThisLevel;

      late final TestTaskModel rightTestTask;

      if (correctlyGuessedAtThisPoint < 3) {
        rightTestTask = allTasks.firstWhere(
            (element) => element.level.toLowerCase() == level.name.toLowerCase() && !pastTasks.contains(element));
      } else {
        rightTestTask = allTasks.firstWhere((element) =>
            element.level.toLowerCase() == level.nextLevel?.name.toLowerCase() && !pastTasks.contains(element));
      }

      late final TestTaskModel leftTestTask;
      if (correctlyGuessedAtThisPoint >= -3 - level.index && level == EnglishLevel.a1) {
        leftTestTask = allTasks.firstWhere(
            (element) => element.level.toLowerCase() == level.name.toLowerCase() && !pastTasks.contains(element));
      } else if (correctlyGuessedAtThisPoint >= -3 - level.index) {
        leftTestTask = allTasks.firstWhere((element) =>
            element.level.toLowerCase() == level.previousLevel!.name.toLowerCase() && !pastTasks.contains(element));
      } else {
        throw 'The level is defined';
      }

      startNode.leftChild = addChild(leftTestTask,
          leftTestTask.level.toLowerCase() == startNode.level.name.toLowerCase() ? correctlyGuessedAtThisPoint - 1 : 0);
      startNode.rightChild = addChild(
          rightTestTask,
          rightTestTask.level.toLowerCase() == startNode.level.name.toLowerCase()
              ? correctlyGuessedAtThisPoint + 1
              : 0);

      if (startNode.rightChild != null) {
        pastTasks.add(rightTestTask);
        buildATree(allTasks, pastTasks, startNode.rightChild!);
      } else {
        startNode.rightChild ??= Node.finalNode(startNode);
      }
      if (startNode.leftChild != null) {
        pastTasks.add(leftTestTask);
        buildATree(allTasks, pastTasks, startNode.leftChild!);
      } else {
        startNode.leftChild ??= Node.finalNode(startNode);
      }
    } catch (e) {
      //didn't find the task
      return;
    }
  }

  Future<Node> startTree(List<TestTaskModel> allTasks) async {
    final TestTaskModel firstTask = allTasks.firstWhere((element) => element.level == EnglishLevel.a1.name);
    final Node node = Node(EnglishLevel.a1, 0, firstTask, null, null);
    final List<TestTaskModel> pastTasks = [firstTask];
    await buildATree(allTasks, pastTasks, node);
    return node;
  }
}
