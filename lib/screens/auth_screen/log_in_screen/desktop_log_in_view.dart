import 'package:healthmini/utils/general_imports.dart';
import 'package:healthmini/utils/validation_utils.dart';

class DesktopLoginView extends StatelessWidget {
  final TextEditingController emailCrt;
  const DesktopLoginView({super.key, required this.emailCrt});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height / 11),
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.height / 1.6,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.black12Color,
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 0.5)
                    ],
                    color: AppColors.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Log In",
                      style: AppTextStyles.boldTextStyles(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    editBoxWidget(
                        context,
                        emailCrt,
                        ValidationUtils.emptyValidation,
                        "Email",
                        "Va",
                        TextInputType.text),
                    const SizedBox(height: 18),
                    editBoxWidget(
                        context,
                        emailCrt,
                        ValidationUtils.emptyValidation,
                        "Password",
                        "Va",
                        TextInputType.text),
                    const SizedBox(height: 50),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.width / 30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Text("Log In",style: AppTextStyles.boldTextStyles(fontSize: 18,textColor: AppColors.whiteColor),),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        signUpOption(icon: "svg/google.svg"),
                        signUpOption(icon: "svg/facebook.svg"),
                        signUpOption(icon: "svg/twitter.svg"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "svg/meditation.svg",
                height: MediaQuery.of(context).size.width / 2.5,
              )
            ],
          )),
        ],
      ),
    );
  }
}

Widget signUpOption({required String icon}) {
  return Container(
    padding: EdgeInsets.all(8),
    height: 50,
    width: 50,
    decoration:
        BoxDecoration(border: Border.all(color: AppColors.black12Color,width: 1),borderRadius: BorderRadius.all(Radius.circular(8))),
    child: SvgPicture.asset(icon),
  );
}

Widget editBoxWidget(
    BuildContext context,
    TextEditingController edtController,
    Function validationFunction,
    String label,
    String errorLabel,
    TextInputType inputType,
    {Widget? tailIcon,
    Widget? leadingIcon,
    bool? isLastField,
    bool? isEditable = true,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? optionalTextInputAction,
    int? minLines,
    VoidCallback? onTab,
    int? maxLines}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        child: TextFormField(
          enabled: isEditable,
          style: TextStyle(
            color: AppColors.blackColor,
          ),
          onTap: onTab,
          maxLines: maxLines,
          minLines: minLines,
          controller: edtController,
          textInputAction: optionalTextInputAction ??
              (isLastField == true
                  ? TextInputAction.done
                  : TextInputAction.next),
          decoration: InputDecoration(
            prefix: leadingIcon,
            suffixIcon: tailIcon,
            fillColor: Theme.of(context).cardColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: AppColors.appColors,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: AppColors.black12Color,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: AppColors.redColor,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: AppColors.black12Color,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: AppColors.black12Color,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            labelText: label,
            labelStyle: TextStyle(color: AppColors.black12Color),
            isDense: true,
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).colorScheme.error
                    : AppColors.appColors;
                return TextStyle(color: color, letterSpacing: 1.3);
              },
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: inputType,
          inputFormatters: inputFormatters ?? [],
          validator: (String? value) {
            return validationFunction(value ?? "") == null ? null : errorLabel;
          },
        ),
      )
    ],
  );
}
