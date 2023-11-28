import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_question.dart';

class LinGameScreen extends StatelessWidget {
  const LinGameScreen({
    super.key,
    required this.question,
    required this.options,
    required this.selectedAnswers,
    required this.onSelected,
    required this.onNextTask,
    required this.remainingTime,
    this.isFinalQuestion = false,
    this.isOneAnswer = false,
  });
  final String question;
  final List<String> options;
  final List<int> selectedAnswers;
  final void Function(int) onSelected;
  final void Function() onNextTask;
  final int remainingTime;
  final bool isFinalQuestion;
  final bool isOneAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinQuestionText(
            textTask: question,
            answer: selectedAnswers.map((e) => options[e]).toList(),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (options[index].isNotEmpty) {
              if (isOneAnswer) {
                return RadioListTile(
                    title: Text('${index + 1}. ${options[index]}'),
                    value: index,
                    groupValue: selectedAnswers.isNotEmpty ? selectedAnswers.first : null,
                    onChanged: (selected) => onSelected(index));
              }
              return CheckboxListTile(
                title: Text('${index + 1}. ${options[index]}'),
                value: selectedAnswers.contains(index),
                onChanged: (selected) => onSelected(index),
              );
            }
            return null;
          },
          separatorBuilder: (_, __) => Divider(),
          itemCount: options.map((e) => e.isNotEmpty).length,
        ),
        const SizedBox(height: 20),
        Center(
          child: LinMainButton(
            onTap: selectedAnswers.isNotEmpty ? onNextTask : null,
            label: isFinalQuestion ? context.loc.finish : context.loc.next,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text('Time Remaining: ${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}'),
        ),
      ],
    );
  }
}
