import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './snack_bar.dart';

httpErrorHandle({required BuildContext context,required http.Response response, required Function  onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
     showSnackBar(context: context, message: 'Bad Request');
      break;
    case 500:
      showSnackBar(context: context, message: 'Internal Server Error');
      break;
    default:
      showSnackBar(context: context, message: 'Something went wrong.. Try again');
  }
}


