import 'package:chicago/chicago.dart';
import 'package:flutter/widgets.dart';

class CalendarsDemo extends StatelessWidget {
  const CalendarsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChicagoApp(
      home: ColoredBox(
        color: const Color(0xffdddcd5),
        child: Rollup(
          heading: Text('Calendars'),
          semanticLabel: 'Calendars',
          childBuilder: (BuildContext context) {
            return BorderPane(
              backgroundColor: Color(0xffffffff),
              borderColor: Color(0xff999999),
              child: CalendarButton(
                initialYear: DateTime.now().year,
              ),
            );
          },
        ),
      ),
    );
  }
}
