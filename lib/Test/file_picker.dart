import 'package:flutter/material.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
 import 'package:open_file_safe/open_file_safe.dart' as open_file;
import 'package:path/path.dart' as path;
class TestCase extends StatefulWidget {
  @override
  _TestCaseState createState() => _TestCaseState();
}
class _TestCaseState extends State<TestCase> {
  var fileList = [];
  String extractFileName(String filePath) {
    return path.basename(filePath);
  }

  alterItem(type,index)async{
    if(type ==1||type ==2){
      final file = await pickFile(
        allowedExtensions: ['zip','pdf'],
        allowedMimeTypes: ['pdf', 'doc', 'docx'],
      );

      if (file != null) {
        final path = file.path;
        if(type ==1){
          fileList.add(path);
        }
        else{
          fileList[index] = path;
        }

        setState(() {});
      }
      else {
      }
    }
    else{
      fileList.removeAt(index);
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Picker Example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: Text('Pick File'),
                onPressed: () async {
                  alterItem(1,0);
                },
              ),
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width/1.2,
                child: ListView.builder(
                  itemCount: fileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        onTap: () async{
                          await open_file.OpenFile.open(fileList[index]);
                        },
                        onLongPress: (){
                          alterItem(2,index);
                        },
                        trailing: IconButton(
                          onPressed: (){
                            alterItem(3,index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        title: Text(extractFileName(fileList[index])));
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );


  }

}
