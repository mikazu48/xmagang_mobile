import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magangskipsi/file_list.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '/../../globals.dart' as globals;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const TestUpload());
}

class TestUpload extends StatelessWidget {
  const TestUpload({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UploadFilePage(),
    );
  }
}

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({Key? key}) : super(key: key);

  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'Audio', 'MultipleFile'];

  FilePickerResult? result;
  PlatformFile? file;
  String fileName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selected File Type:  ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                DropdownButton(
                  value: fileType,
                  items: fileTypeList.map((String type) {
                    return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(fontSize: 20),
                        ));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      fileType = value!;
                      file = null;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                pickFiles(fileType);
              },
              child: Text('Pick file'),
            ),
            if (file != null) fileDetails(file!),
            if (file != null)
              ElevatedButton(
                onPressed: () {
                  viewFile(file!);
                },
                child: Text('View Selected File'),
              ),
            if (fileName.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  uploadFile();
                },
                child: Text('Post Files'),
              )
          ],
        ),
      ),
    );
  }

  void uploadFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    File fileSend = File(fileName);
    var postUri = Uri.parse(globals.API_URL + "trx_pmb");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['id_mahasiswa'] = '1';
    request.fields['nama_perusahaan'] = 'PT Google';
    request.fields['total_ipk'] = '3.60';
    request.files.add(await http.MultipartFile.fromPath('file_khs', fileName));
    request.files
        .add(await http.MultipartFile.fromPath('file_surat', fileName));

    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Berhasil kirim file!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Terjadi kesalahan di API ! " + response.body)));
    }
  }

  Widget fileDetails(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    fileName = file.path.toString();
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );
  }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;

      case 'Audio':
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        loadSelectedFiles(result!.files);
        break;
    }
  }

  // multiple file selected
  // navigate user to 2nd screen to show selected files
  void loadSelectedFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FileList(files: files, onOpenedFile: viewFile)));
  }

  // open the picked file
  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
