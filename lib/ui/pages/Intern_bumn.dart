// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';
import 'package:magangskipsi/ui/widget/interest_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart';
import '/../../globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'dart:typed_data';
import 'package:flutter/foundation.dart';

var dio = new Dio();
CoreFacade cf = new CoreFacade();

var ctrlNilaiIPK = TextEditingController();
var ctrlNamaPerusahaan = TextEditingController();
var ctrlFileKHS = TextEditingController();
var ctrlFileOrtu = TextEditingController();

String path_khs = "";
String path_ortu = "";

FilePickerResult? result;
PlatformFile? file_khs;
PlatformFile? file_ortu;
String fileName = "";

class MagangBumn extends StatelessWidget {
  const MagangBumn({Key? key}) : super(key: key);

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
              'assets/image_bumn.png',
            ),
          ),
        ),
      );
    }

    // }

    Future downloadfromUrl(Dio dio, String url, String savePath) async {
      try {
        Response response = await dio.get(
          url,
          onReceiveProgress: cf.showLoaderDialog(context),
          //Received data with List<int>
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
        );
        print(response.headers);
        if (response.headers.value("content-disposition") == null ||
            !response.headers
                .value("content-disposition")
                .toString()
                .contains("attachment")) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Download gagal, format API salah ! ")));
          Navigator.pop(context);
          return;
        }
        File file = File(savePath);
        var raf = file.openSync(mode: FileMode.write);
        // response.data is List<int> type
        raf.writeFromSync(response.data);
        await raf.close();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Download file sukses! " + file.path.toString())));
      } catch (e) {
        print(e);
      }
      Navigator.pop(context);
      OpenFile.open(savePath);
    }

    void hitPost() async {
      if (ctrlNilaiIPK.text.isNotEmpty &&
          ctrlNamaPerusahaan.text.isNotEmpty &&
          ctrlFileKHS.text.isNotEmpty &&
          ctrlFileOrtu.text.isNotEmpty) {
        cf.showLoaderDialog(context);
        var postUri = Uri.parse(globals.API_URL + "trx_pmb");
        var request = new http.MultipartRequest("POST", postUri);
        request.fields['id_mahasiswa'] = globals.Sessions_UserID;
        request.fields['nama_perusahaan'] = ctrlNamaPerusahaan.text;
        request.fields['total_ipk'] = ctrlNilaiIPK.text;
        request.files.add(await http.MultipartFile.fromPath(
            'file_khs', file_khs!.path.toString()));
        request.files.add(await http.MultipartFile.fromPath(
            'file_surat', file_ortu!.path.toString()));

        final streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          MessageResult resultMessage =
              MessageResult.fromJson(jsonDecode(response.body));
          Navigator.pushNamed(context, '/SuccessSubmission');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(resultMessage.message)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Terjadi kesalahan di API ! " + response.body)));
          Navigator.pop(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Harap isi data & pilih file!!")));
      }
    }

//button download file Pakta Integritas
    Widget downloadFileortu() {
      return Container(
        // margin: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                String urlDownload = globals.BASE_URL +
                    "public/pubsdownload/pakta_integritas.pdf";
                // if (await canLaunch(url)) {
                //   await launch(url);
                // } else {
                //   throw 'Link tidak bisa dibuka $url';
                // }
                print(urlDownload);
                var tempDir = await getApplicationDocumentsDirectory();
                String fullPath = tempDir.path + "/pakta_integritas.pdf";

                downloadfromUrl(dio, urlDownload, fullPath);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
              ),
              child: Text(
                'Download Pakta Integritas',
                style: textWhiteStyle.copyWith(
                  color: kRedColor,
                  fontSize: 10,
                  fontWeight: light,
                ),
              ),
            ),
          ],
        ),
      );
    }

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
                onPressed: () {
                  pickFiles("KHS");
                },
                width: 250,
                height: 50,
              ),
            ),
          ],
        ),
      );
    }

    Widget showFileKHS() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: ctrlFileKHS,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Harap pilih file KHS',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    //button upload file Pakta Integritas
    Widget uploadFileortu() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 2,
        ),
        height: 50,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomButton(
                title: 'Upload File izin ortu',
                onPressed: () {
                  pickFiles("Ortu");
                },
                width: 280,
                height: 50,
              ),
            ),
          ],
        ),
      );
    }

    Widget showFileOrtu() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: ctrlFileOrtu,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Harap pilih file Izin Ortu',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
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
                        'Program Magang BUMN',
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
                    'PMMB merupakan program yang bertujuan untuk memberikan pengayaan wawasan dan keterampilan mahasiswa untuk mempersiapkan dan menciptakan SDM Indonesia Unggul terutama dalam menghadapi persaingan global melalui link and match kurikulum industri dan Perguruan Tinggi.',
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
                          controller: ctrlNilaiIPK,
                          keyboardType: TextInputType.number,
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
                        TextFormField(
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
                        downloadFileortu(),
                        uploadFileKHS(),
                        uploadFileortu(),
                        showFileKHS(),
                        showFileOrtu(),
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

  void pickFiles(String? uploadType) async {
    if (uploadType == "KHS") {
      result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      file_khs = result!.files.first;
      ctrlFileKHS.text = file_khs!.name;
    }
    if (uploadType == "Ortu") {
      result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      file_ortu = result!.files.first;
      ctrlFileOrtu.text = file_ortu!.name;
    }
  }
}
