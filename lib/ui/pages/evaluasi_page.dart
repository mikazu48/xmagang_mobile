import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/pages/Intern_bumn.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';
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

var ctrlFileLaporan = TextEditingController();

String path_laporan = "";

FilePickerResult? result;
PlatformFile? file_laporan;
String fileName = "";
BuildContext? currentContext;

class EvaluasiPage extends StatelessWidget {
  const EvaluasiPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    currentContext = context;

    return MaterialApp(
      home: Scaffold(
        body: DropDown(),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  String spinnerLamaMagangValue = '1 bulan';
  String spinnerIdealValue = 'Sudah';
  var ctrlTempatMagang = TextEditingController();
  var ctrlPeriode = TextEditingController();
  var ctrlNilaiIdeal = TextEditingController();
  var ctrlNilaiTugas = TextEditingController();
  var ctrlNilaiAktif = TextEditingController();
  var ctrlNilaiTeori = TextEditingController();
  var ctrlNilaiPembimbing = TextEditingController();
  var ctrlNilaiAdministrasi = TextEditingController();
  var ctrlSaran = TextEditingController();

  List<String> spinnerLamaMagang = [
    '1 bulan',
    '2 bulan',
    '3 bulan',
    '> 3 bulan'
  ];
  List<String> spinnerIdeal = [
    'Sudah',
    'Belum',
  ];

  @override
  Widget build(BuildContext context) {
    Widget inputSection() {
      Widget tempatmagangInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tempat Magang',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlTempatMagang,
                decoration: InputDecoration(
                  hintText: 'Your Answer...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget periodMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Periode Pelaksanaan Magang',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlPeriode,
                decoration: InputDecoration(
                  hintText: 'Your Answer...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget waktuMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lama Pelaksanaan Magang',
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                value: spinnerLamaMagangValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? data) {
                  setState(() {
                    spinnerLamaMagangValue = data.toString();
                  });
                },
                items: spinnerLamaMagang
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }

      Widget idealMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah periode magang Anda sudah ideal pelaksanaannya?',
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                value: spinnerIdealValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? data) {
                  setState(() {
                    spinnerIdealValue = data.toString();
                  });
                },
                items:
                    spinnerIdeal.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }

      Widget latarbelakangPendiidkanmagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah periode magang Anda sudah ideal pelaksanaannya?',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlNilaiIdeal,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Isi 1 sampai 5...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget tugasMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tugas-tugas Saya selalu dijelaskan sehingga Saya dapat mengerti apa yang harus Saya lakukan',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlNilaiTugas,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Isi 1 sampai 5...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget peranMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saya didorong untuk selalu berperan aktif saat magang',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlNilaiAktif,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Isi 1 sampai 5...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget teoripendidikanMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saya dapat mengaplikasikan teori dalam perkuliahan pada pelaksanaan magang',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlNilaiTeori,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Isi 1 sampai 5...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget pembimbingMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pembimbing magang membantu Saya memahami tugas-tugas',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlNilaiPembimbing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Isi 1 sampai 5...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget adminmagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Secara keseluruhan, pengorganisasian, administrasi, dan penjadwalan ditangani dengan baik',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlNilaiAdministrasi,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Isi 1 sampai 5...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget saranMagang() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah Anda memiliki saran lain yang menurut Anda dapat meningkatkan kegiatan magang ini?',
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ctrlSaran,
                decoration: InputDecoration(
                  hintText: 'Your Answer...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget ddlPeriode() {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        );
      }

      Widget showFileLaporan() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: ctrlFileLaporan,
                textAlign: TextAlign.left,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Harap pilih file Laporan',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      }

      bool checkNilaiValid(String value) {
        try {
          if (value.isEmpty) {
            return false;
          }
          int nilai = int.parse(value);
          if (nilai < 1 && nilai > 5) {
            return false;
          }
          return true;
        } catch (e) {
          return false;
        }
      }

      bool checkValidation() {
        if (ctrlTempatMagang.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Harap isi tempat magang !")));
          return false;
        }
        if (ctrlPeriode.text.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Harap isi periode !")));
          return false;
        }
        if (!checkNilaiValid(ctrlNilaiIdeal.text) ||
            !checkNilaiValid(ctrlNilaiTugas.text) ||
            !checkNilaiValid(ctrlNilaiAktif.text) ||
            !checkNilaiValid(ctrlNilaiTeori.text) ||
            !checkNilaiValid(ctrlNilaiPembimbing.text) ||
            !checkNilaiValid(ctrlNilaiAdministrasi.text)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("Untuk nilai harap isi dengan angka 1 sampai 5 !")));
          return false;
        }
        if (ctrlSaran.text.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Harap isi saran !")));
          return false;
        }
        if (ctrlFileLaporan.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Harap pilih file laporan magang!")));
          return false;
        }
        return true;
      }

      void hitPost() async {
        try {
          if (checkValidation()) {
            cf.showLoaderDialog(context);
            var postUri = Uri.parse(globals.API_URL + "trx_evaluasi");
            var request = new http.MultipartRequest("POST", postUri);
            request.fields['id_mahasiswa'] = globals.Sessions_UserID;
            request.fields['eval_tempat_magang'] = ctrlTempatMagang.text;
            request.fields['eval_periode'] = ctrlPeriode.text;
            request.fields['eval_lama_magang'] = spinnerLamaMagangValue;
            request.fields['eval_ideal'] = spinnerIdealValue;
            request.fields['eval_nilai_ideal'] = ctrlNilaiIdeal.text;
            request.fields['eval_nilai_tugas'] = ctrlNilaiTugas.text;
            request.fields['eval_nilai_aktif'] = ctrlNilaiAktif.text;
            request.fields['eval_nilai_teori'] = ctrlNilaiTeori.text;
            request.fields['eval_nilai_pembimbing'] = ctrlNilaiPembimbing.text;
            request.fields['eval_nilai_administrasi'] =
                ctrlNilaiAdministrasi.text;
            request.fields['eval_saran'] = ctrlSaran.text;
            request.files.add(await http.MultipartFile.fromPath(
                'file_laporan', file_laporan!.path.toString()));

            final streamedResponse = await request.send();
            var response = await http.Response.fromStream(streamedResponse);

            if (response.statusCode == 200) {
              MessageResult resultMessage =
                  MessageResult.fromJson(jsonDecode(response.body));
              Navigator.of(currentContext!)
                  .pushNamedAndRemoveUntil('/MainPage', (route) => false);
              ScaffoldMessenger.of(currentContext!)
                  .showSnackBar(SnackBar(content: Text(resultMessage.message)));
            } else {
              ScaffoldMessenger.of(currentContext!).showSnackBar(SnackBar(
                  content:
                      Text("Terjadi kesalahan di API ! " + response.body)));
              Navigator.pop(currentContext!);
            }
          }
        } catch (e) {
          ScaffoldMessenger.of(currentContext!).showSnackBar(SnackBar(
              content: Text("Terdapat kesalahan pada code : " + e.toString())));
          Navigator.pop(currentContext!);
        }
      }

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kBackGroundColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keterangan Evaluasi',
              style: textBlackStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            Text(
              '1. Sangat Tidak setuju\n2.Tidak Setuju\n3.Kurang Setuju\n4.Setuju\n5.Sangat Setuju',
              style: textBlackStyle.copyWith(
                color: kRedColor,
                fontSize: 10,
                fontWeight: reguler,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Evaluasi Magang',
              style: textBlackStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            tempatmagangInput(),
            periodMagang(),
            waktuMagang(),
            idealMagang(),
            latarbelakangPendiidkanmagang(),
            tugasMagang(),
            peranMagang(),
            teoripendidikanMagang(),
            pembimbingMagang(),
            adminmagang(),
            saranMagang(),
            ddlPeriode(),
            showFileLaporan(),
            Center(
              child: CustomButton(
                title: 'Upload Lap Magang',
                width: 300,
                onPressed: () {
                  pickFiles();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                title: 'Submit',
                width: 200,
                onPressed: () {
                  hitPost();
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            // title(),
            inputSection(),
          ],
        ),
      ),
    );
  }

  void pickFiles() async {
    result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    file_laporan = result!.files.first;
    ctrlFileLaporan.text = file_laporan!.name;
  }
}
