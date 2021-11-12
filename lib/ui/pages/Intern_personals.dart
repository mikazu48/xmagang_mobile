import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magangskipsi/globals.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';
import 'package:magangskipsi/ui/widget/interest_item.dart';
import '/../../globals.dart' as globals;
import 'package:http/http.dart' as http;

var ctrlNamaPerusahaan = TextEditingController();
var ctrlNamaPIC = TextEditingController();
var ctrlTelpPIC = TextEditingController();
CoreFacade cf = new CoreFacade();

class Magangpersonals extends StatelessWidget {
  const Magangpersonals({Key? key}) : super(key: key);

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
              'assets/background.jpg',
            ),
          ),
        ),
      );
    }

    Future<void> hitPost() async {
      if (ctrlNamaPerusahaan.text.isNotEmpty && ctrlNamaPIC.text.isNotEmpty) {
        cf.showLoaderDialog(context);
        var response = await http.post(Uri.parse(globals.API_URL + "trx_pmp"),
            body: ({
              'id_mahasiswa': globals.Sessions_UserID,
              'nama_perusahaan': ctrlNamaPerusahaan.text,
              'nama_pic': ctrlNamaPIC.text,
              'telp_pic': ctrlNamaPIC.text
            }));
        if (response.statusCode == 200) {
          MessageResult resultMessage =
              MessageResult.fromJson(jsonDecode(response.body));
          Navigator.pushNamed(context, '/SuccessSubmission');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(resultMessage.message)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Terjadi kesalahan di API !")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Harap isi data pengajuan !")));
      }
    }

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
                        'Program Magang\nPersonal',
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
                    'Berada di jalur jalan provinsi yang menghubungkan Denpasar Singaraja serta letaknya yang dekat dengan Kebun Raya Eka Karya menjadikan tempat Bali.',
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
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: TextFormField(
                            controller: ctrlNamaPerusahaan,
                            decoration: InputDecoration(
                              hintText: 'Nama Perusahaan',
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
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: TextFormField(
                            controller: ctrlTelpPIC,
                            decoration: InputDecoration(
                              hintText: 'Alamat Perusahaan',
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
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: TextFormField(
                            controller: ctrlNamaPIC,
                            decoration: InputDecoration(
                              hintText: 'Nama PIC',
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
                        ),
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
                    onPressed: () {
                      hitPost();
                      // Navigator.pushNamed(context, '/SuccessSubmission');
                    },
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
