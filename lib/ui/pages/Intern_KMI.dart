import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';
import 'package:magangskipsi/ui/widget/interest_item.dart';
// import 'package:url_launcher/url_launcher.dart';

class MagangKMI extends StatelessWidget {
  const MagangKMI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget backgroundImage() {
      return Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/image_kmi.png',
            ),
          ),
        ),
      );
    }

    //button download file Pakta Integritas
    // Widget downloadFileortu() {
    //   return Container(
    //     // margin: EdgeInsets.only(bottom: 30),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         TextButton(
    //           onPressed: () async {
    //             const url = 'https://www86.zippyshare.com/v/5jtFCW4v/file.html';
    //             if (await canLaunch(url)) {
    //               await launch(url);
    //             } else {
    //               throw 'Link tidak bisa dibuka $url';
    //             }
    //           },
    //           style: TextButton.styleFrom(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(defaultRadius),
    //             ),
    //           ),
    //           child: Text(
    //             'Download Pakta Integritas',
    //             style: textWhiteStyle.copyWith(
    //               color: kRedColor,
    //               fontSize: 10,
    //               fontWeight: light,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    //button Upload khs
    Widget uploadFileKHS() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        height: 50,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomButton(
                title: 'Upload File KHS',
                onPressed: () {},
                width: 250,
                height: 50,
              ),
            ),
          ],
        ),
      );
    }

    //button upload file Pakta Integritas
    // Widget uploadFileortu() {
    //   return Container(
    //     margin: EdgeInsets.symmetric(
    //       vertical: 2,
    //     ),
    //     height: 50,
    //     width: double.infinity,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Center(
    //           child: CustomButton(
    //             title: 'Upload File izin ortu',
    //             onPressed: () {},
    //             width: 280,
    //             height: 50,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget customShadow() {
      return Container(
        width: double.infinity,
        height: 300,
        margin: EdgeInsets.only(top: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kWhiteColor.withOpacity(0),
              Colors.black.withOpacity(0.95),
            ],
          ),
        ),
      );
    }

    Widget bodyContent() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            //Note:Emblem
            Container(
              width: 110,
              height: 25,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/emblem.png'),
                ),
              ),
            ),

            //Note: Judul Program
            Container(
              margin: EdgeInsets.only(top: 280),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Program Magang KMI',
                        style: textWhiteStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Note: Keterangan
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Note : About
                  Text(
                    'About',
                    style: textBlackStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Magang Bersertifikat adalah bagian dari program Kampus Merdeka yang bertujuan untuk memberikan kesempatan kepada mahasiswa belajar dan mengembangkan diri melalui aktivitas di luar kelas perkuliahan.',
                    style: textBlackStyle.copyWith(
                      fontSize: 10,
                      fontWeight: reguler,
                    ),
                  ),
                  // Note: Interets
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Benefit',
                    style: textBlackStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      InterestItem(
                        text: 'Sertifikat',
                      ),
                      InterestItem(
                        text: 'Uang Saku',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InterestItem(
                        text: 'Relasi Kerja',
                      ),
                      InterestItem(
                        text: 'Pengalaman Kerja',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Office Form ',
                    style: textBlackStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Masukan IPK Anda',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              borderSide: BorderSide(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        // downloadFileortu(),
                        uploadFileKHS(),
                        // uploadFileortu(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Note Button Submit
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 60,
              ),
              child: Row(
                children: [
                  CustomButton(
                    title: 'Submit',
                    onPressed: () {},
                    width: 250,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundImage(),
            customShadow(),
            bodyContent(),
          ],
        ),
      ),
    );
  }
}
