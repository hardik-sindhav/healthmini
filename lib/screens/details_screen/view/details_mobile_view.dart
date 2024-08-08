// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:healthmini/models/details_model.dart';
import 'package:healthmini/utils/general_imports.dart';

class DetailsMobileView extends StatelessWidget {
  final List<Data>? detailsList;
  const DetailsMobileView({super.key, this.detailsList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
          cacheExtent: 0,
          shrinkWrap: true,
          itemCount: detailsList?.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Basic Details  :",
                    style: AppTextStyles.mediumTextStyles(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textSpan(
                      title: "Disease Name",
                      value: detailsList?[index].diseaseName ?? ''),
                  textSpan(
                      title: "Prediction Percentage",
                      value:
                          "${detailsList?[index].predictionPercentage.toString() ?? ''} %"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Disease Symptoms  :",
                    style: AppTextStyles.mediumTextStyles(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: List.generate(
                        detailsList![index].diseaseSymptoms!.length,
                        (sIndex) => tagChip(
                            tag: detailsList![index]
                                    .diseaseSymptoms?[sIndex]
                                    .toString() ??
                                '')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Disease Reasons  :",
                    style: AppTextStyles.mediumTextStyles(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: List.generate(
                        detailsList![index].diseaseReason!.length,
                        (rIndex) => tagChip(
                            tag: detailsList![index]
                                    .diseaseReason?[rIndex]
                                    .toString() ??
                                '')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   "Medicine For Disease  :",
                  //   style: AppTextStyles.mediumTextStyles(fontSize: 16),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Wrap(
                  //   children: List.generate(
                  //       detailsList![index].medicineForDisease!.length,
                  //       (rIndex) => tagChip(
                  //           tag: detailsList![index]
                  //                   .medicineForDisease?[rIndex]
                  //                   .toString() ??
                  //               '')),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Home Treatment  :",
                    style: AppTextStyles.mediumTextStyles(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: List.generate(
                        detailsList![index].homeTreatment!.length,
                        (hIndex) => tagChip(
                            tag: detailsList![index].homeTreatment?[hIndex] ??
                                '')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Best Hospital Near You   :",
                    style: AppTextStyles.mediumTextStyles(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  detailsList?[index].bestHospital == null ||
                          detailsList![index].bestHospital!.isEmpty
                      ? Text(
                          "No Hospital Found !",
                          style: AppTextStyles.normalTextStyles(fontSize: 12),
                        )
                      : GeneralFunction().containsDemoDetails(
                                  string: detailsList?[index]
                                          .bestHospital?[0]
                                          .contact
                                          ?.mobile ??
                                      '',
                                  validation: '123456789') ||
                              GeneralFunction().containsDemoDetails(
                                  string: detailsList?[index]
                                          .bestHospital?[0]
                                          .contact
                                          ?.mobile ??
                                      '',
                                  validation: '9876543210')
                          ? Text(
                              "No Hospital Found !",
                              style:
                                  AppTextStyles.normalTextStyles(fontSize: 12),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  detailsList?[index].bestHospital!.length,
                              itemBuilder: (context, bIndex) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textSpan(
                                          title: "Name",
                                          value: detailsList?[index]
                                                  .bestHospital?[bIndex]
                                                  .name ??
                                              ''),
                                      GeneralFunction().containsDemoDetails(
                                              string: detailsList?[index]
                                                      .bestHospital?[bIndex]
                                                      .contact
                                                      ?.mobile ??
                                                  '',
                                              validation: '123456789')
                                          ? textSpan(
                                              title: "Mobile No",
                                              value: 'Mobile No not available.')
                                          : textSpan(
                                              title: "Mobile No",
                                              value: detailsList?[index]
                                                      .bestHospital?[bIndex]
                                                      .contact
                                                      ?.mobile ??
                                                  ''),
                                      GeneralFunction().containsDemoDetails(
                                              string: detailsList?[index]
                                                      .bestHospital?[bIndex]
                                                      .contact
                                                      ?.email ??
                                                  '',
                                              validation: 'example')
                                          ? textSpan(
                                              title: "Email",
                                              value: 'Email not available.')
                                          : textSpan(
                                              title: "Email",
                                              value: detailsList?[index]
                                                      .bestHospital?[bIndex]
                                                      .contact
                                                      ?.email ??
                                                  ''),
                                      GeneralFunction().containsDemoDetails(
                                              string: detailsList?[index]
                                                      .bestHospital?[bIndex]
                                                      .address
                                                      ?.street ??
                                                  '',
                                              validation: 'example')
                                          ? textSpan(
                                              title: "Address",
                                              value: 'Address not available.')
                                          : textSpan(
                                              title: "Address",
                                              value:
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.street ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.pin ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.city ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.state ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.country ?? ''}'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          actionBtn(
                                              disable: GeneralFunction()
                                                      .containsDemoDetails(
                                                          string: detailsList?[
                                                                      index]
                                                                  .bestHospital?[
                                                                      bIndex]
                                                                  .contact
                                                                  ?.mobile ??
                                                              '',
                                                          validation:
                                                              '123456789')
                                                  ? false
                                                  : true,
                                              onTab: () => launchCall(
                                                  context,
                                                  detailsList?[index]
                                                          .bestHospital?[bIndex]
                                                          .contact
                                                          ?.mobile ??
                                                      ''),
                                              icon: Icons.call,
                                              label: "Call Us"),
                                          const SizedBox(width: 10),
                                          actionBtn(
                                              disable: GeneralFunction()
                                                      .containsDemoDetails(
                                                          string: detailsList?[
                                                                      index]
                                                                  .bestHospital?[
                                                                      bIndex]
                                                                  .contact
                                                                  ?.email ??
                                                              '',
                                                          validation: 'example')
                                                  ? false
                                                  : true,
                                              onTab: () => launchMail(
                                                  detailsList?[index]
                                                          .bestHospital?[bIndex]
                                                          .contact
                                                          ?.email ??
                                                      ''),
                                              icon: Icons.mail_outline_rounded,
                                              label: "Send Mail"),
                                          const SizedBox(width: 10),
                                          actionBtn(
                                              disable: GeneralFunction()
                                                      .containsDemoDetails(
                                                          string: detailsList?[
                                                                      index]
                                                                  .bestHospital?[
                                                                      bIndex]
                                                                  .address
                                                                  ?.state ??
                                                              '',
                                                          validation: 'example')
                                                  ? false
                                                  : true,
                                              icon: Icons.add_location,
                                              label: "Find Map",
                                              onTab: () => MapUtils.openMap(
                                                  '${detailsList?[index].bestHospital?[bIndex].name ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.street ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.pin ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.city ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.state ?? ''}, '
                                                  '${detailsList?[index].bestHospital?[bIndex].address?.country ?? ''}'))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Future<void> launchCall(BuildContext context, String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunch(phoneUri.toString())) {
      try {
        await launch(phoneUri.toString());
      } catch (e) {
        showCustomSnackbar(context, "Something went wrong.", MessageType.error);
      }
    } else {
      showCustomSnackbar(context, "Something went wrong.", MessageType.error);
    }
  }

  Future<void> launchMail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Health Inquiry',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget textSpan({String? title, String? value}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${title ?? ''}  :  ",
            style: AppTextStyles.semiBoldTextStyles(fontSize: 14),
          ),
          TextSpan(
            text: value ?? '',
            style: AppTextStyles.normalTextStyles(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget actionBtn(
      {required IconData icon,
      required String label,
      VoidCallback? onTab,
      bool? disable}) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTab,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: disable != true ? Colors.black12 : Colors.grey,
                width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: disable != true ? Colors.black12 : Colors.black87,
              ),
              const SizedBox(width: 5),
              Text(label,
                  style: AppTextStyles.mediumTextStyles(
                    fontSize: 14,
                    textColor:
                        disable != true ? Colors.black12 : Colors.black87,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget tagChip({required String tag}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        tag,
        style: AppTextStyles.mediumTextStyles(fontSize: 14),
      ),
    );
  }
}
