/* import 'package:flutter/material.dart';
 int _selectedProfileIndex = 0;
void _showProfileSwitchBottomSheet(BuildContext context,) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        child: ListView.builder(
          itemCount: _profiles.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_profiles[index]),
              trailing: Radio(
                value: index,
                groupValue: _selectedProfileIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedProfileIndex = value!;
                  });
                  // Close the bottom sheet after selecting a profile
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      );
    },
  );
}
 */