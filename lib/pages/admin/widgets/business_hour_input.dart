import 'package:flutter/material.dart';
import 'package:qswait/models/admin/business_hour.dart';
import 'package:qswait/utils/Colors.dart';

class BusinessHourInput extends StatefulWidget {
  final BusinessHour businessHour;
  final ValueChanged<BusinessHour> onChanged;

  BusinessHourInput({required this.businessHour, required this.onChanged});

  @override
  _BusinessHourInputState createState() => _BusinessHourInputState();
}

class _BusinessHourInputState extends State<BusinessHourInput> {
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _startTimeController.text = widget.businessHour.startTime.isNotEmpty
        ? widget.businessHour.startTime
        : _formatTimeOfDay(TimeOfDay.now());
    _endTimeController.text = widget.businessHour.endTime.isNotEmpty
        ? widget.businessHour.endTime
        : _formatTimeOfDay(TimeOfDay.now());
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
      TextEditingController controller, String initialTime) async {
    final TimeOfDay initial = _parseTimeOfDay(initialTime);
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (timeOfDay != null) {
      setState(() {
        controller.text = _formatTimeOfDay(timeOfDay);
        _validateAndSave();
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  void _validateAndSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChanged(BusinessHour(
        startTime: _startTimeController.text,
        endTime: _endTimeController.text,
      ));
    }
  }

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return '請輸入時間';
    }
    final timePattern = RegExp(r'^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$');
    if (!timePattern.hasMatch(value)) {
      return '請輸入有效的24小時制時間 (HH:MM)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _selectTime(
                    _startTimeController, _startTimeController.text),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('開始時間',
                              style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(width: 8),
                          Text(
                              _startTimeController.text.isEmpty
                                  ? '選擇時間'
                                  : _startTimeController.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: AppColors.primaryColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              width: 32,
            ),
            Expanded(
              child: InkWell(
                onTap: () =>
                    _selectTime(_endTimeController, _endTimeController.text),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('結束時間',
                              style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(width: 8),
                          Text(
                              _endTimeController.text.isEmpty
                                  ? '選擇時間'
                                  : _endTimeController.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: AppColors.primaryColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
