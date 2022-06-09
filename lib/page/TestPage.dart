// Good
class MyWidget extends StatelessWidget {
  final List<int> numbers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) {
            // These lines live inside the condition builder only.
            final int firstEvenNumber = numbers.firstWhere(
              (element) => element % 2 == 0,
              orElse: () => null,
            );
            return firstEvenNumber != null;
          },
          widgetBuilder: (BuildContext context) {
            // the widget is created only when we need to render it,
            // while maintaining good readability.
            return Text(
              'Even number found.',
              style: TextStyle(
                color: Colors.green,
              ),
            );
          },
          fallbackBuilder: (BuildContext context) {
            return Text(
              'There is no even numbers.',
              style: TextStyle(
                color: Colors.red,
              ),
            );
          }),
    );
  }
}
