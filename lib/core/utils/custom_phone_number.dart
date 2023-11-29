import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';

// ignore: must_be_immutable

class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber(
      {required this.country, required this.onTap, required this.controller});

  Country country;

  Function(Country) onTap;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // _openCountryPicker(context);
          },
          child: Container(
            decoration: BoxDecoration(
              // color: ColorConstant.blueGray50,
              color:  
            
             Color.fromARGB(255, 240, 239, 239),
            border: Border.all(color: Theme.of(context).brightness == Brightness.light
            ? Colors.transparent
            : Colors.white,),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 9,
                top: 12,
                right: 15,
                bottom: 12,
              ),
              child: Text(
                "+${country.phoneCode}",
                // style: AppStyle.txtInterMedium16Gray700,
              ),
            ),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            width: 273,
            // focusNode: FocusNode(),
            controller: controller,
            hintText: "12345-67890",
            
            margin: EdgeInsets.only(
              left: 8,
            ),
            maxLength: 10,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.number,

            // variant: TextFormFieldVariant.FillBluegray50,
            // padding: TextFormFieldPadding.PaddingAll16,
            // fontStyle: TextFormFieldFontStyle.InterMedium16,
          ),
        ),
      ],
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            width:60,
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize:14),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      );
  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 14),
          ),
          isSearchable: true,
          title: Text('Select your phone code',
              style: TextStyle(fontSize: 14)),
          onValuePicked: (Country country) => onTap(country),
          itemBuilder: _buildDialogItem,
        ),
      );
      
}
