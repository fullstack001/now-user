// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';

import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/buttons-management/part_of_file/part.dart';

class AddCardDetails extends StatefulWidget {
  final method;
  AddCardDetails({this.method});
  @override
  State<AddCardDetails> createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  final _formKey = new GlobalKey<FormState>();

  var creditCard = TextEditingController();

  var expiry = TextEditingController();

  var cvc = TextEditingController();

  bool firstInit = false;

  SaveAddressController _addressController = Get.find();

  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';
  // String cardNumber = '4427 4221 2843 8267';

  // String expiryDate = '06/27';

  // String cardHolderName = '';

  // String cvvCode = '638';

  bool isCvvFocused = false;

  bool _isLoading = false;

  ProfileScreenController _profileScreenController = Get.find();
  HomeScreenController _homeScreenController = Get.find();
  final formKey = new GlobalKey<FormState>();

  void onCreditCardModelChange(creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!firstInit) {
      firstInit = true;
      if (kReleaseMode) {
        creditCard.text = "4242 4242 4242 4242";
        expiry.text = "12/40";
        cvc.text = "123";
      }
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: black),
          title: Text(
            "Add Payment Method",
            style: TextStyle(color: black),
          ),
          backgroundColor: white,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // if (kReleaseMode)
                //   CreditCardWidget(
                //     cardNumber: cardNumber,
                //     expiryDate: expiryDate,
                //     cardHolderName: cardHolderName,
                //     cvvCode: cvvCode,
                //     showBackView: isCvvFocused,
                //     isHolderNameVisible: true,
                //     onCreditCardWidgetChange: (CreditCardBrand) {
                //       print("");
                //     },
                //   ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: AppColors.solidBlue)),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.solidBlue,
                                            width: 8)),
                                  ),
                                  12.width,
                                  FittedBox(
                                    child: Text(
                                        widget.method == "VISA"
                                            ? "Debit/Credit Card"
                                            : "Paypal",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff555555),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              ),
                              FittedBox(
                                  child: Image.asset(
                                "assets/user_assets/png/${widget.method}.png",
                                width: 100,
                                height: 40,
                              ))
                            ]),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        cardHolderDecoration: InputDecoration(
                            labelText: "Name on Card",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Color(0xffBDBDBD)))),
                        expiryDateDecoration: InputDecoration(
                            labelText: "Expiry Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Color(0xffBDBDBD)))),
                        cvvCodeDecoration: InputDecoration(
                            labelText: "Security Code",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Color(0xffBDBDBD)))),
                        cardNumberDecoration: InputDecoration(
                            labelText: "Card Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Color(0xffBDBDBD)))),
                        formKey: formKey,
                        themeColor: Colors.cyan,
                        onCreditCardModelChange: onCreditCardModelChange,
                        cardHolderName: '',
                        cardNumber: '',
                        expiryDate: '',
                        cvvCode: '',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FarenowButton(
                    title: "Save Card",
                    onPressed: _submitCard,
                    type: BUTTONTYPE.rectangular),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "The information given below must match the name on your card or your bank may decline your purchase. All information is kept confidential.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff555555)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void saveCard(String? tokenId) async {
    await ServiceReposiotry().saveCard(tokenId!).then((response) async {
      if (response != null) {
        if (!response["error"]) {
          await ServiceReposiotry().getCards().then((data) {
            if (data != null) {
              if (!data.error) {
                _addressController.crditCards(data.cardData.creditCardData);
                _addressController.crditCards.refresh();
              }
            }
          });

          AppDialogUtils.dismiss();
        } else {
          AppDialogUtils.errorDialog(response["message"]);
        }
      }
    });
  }

  Future<void> _submitCard() async {
    Get.focusScope!.unfocus();
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      setState(() {
        AppDialogUtils.dialogLoading();
        Map<String, dynamic> _body = {
          "card[number]": cardNumber,
          "card[exp_month]": "${int.parse(expiryDate.split("/")[0])}",
          "card[exp_year]": "${int.parse(expiryDate.split("/")[1])}",
          "card[cvc]": cvvCode
        };
        print(_body);
        _addressController.getCardToken(body: _body).then((value) {
          print(value);
          if (value != null) {
            Get.back();

            saveCard(value!);
          }
        });
      });
    } on HttpException catch (error) {
      AppDialogUtils.dismiss();
      print('this is error');
      print(error);
      print('this is error');
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
      }
      _showErrorDialog(error.toString());
    } catch (error) {
      print(error);
      const errorMessage = 'Could not authenticate you. Please try again later';
      AppDialogUtils.dismiss();
      _showErrorDialog(errorMessage.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An Error Occured'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Okay'))
              ],
            ));
  }
}
// adb uninstall "com.example.farenow"
