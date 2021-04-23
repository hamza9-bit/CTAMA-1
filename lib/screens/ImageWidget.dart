/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:provider/provider.dart';

class RelatedImage extends StatefulWidget {

  RelatedImage({Key key}) : super(key: key);

  @override
  _RelatedImageState createState() => _RelatedImageState();
}

class _RelatedImageState extends State<RelatedImage> {


 List<String> _paths;
  String _extension;

  List<storage.UploadTask> _tasks = <storage.UploadTask>[];
    void openFileExplorer() async {
      perm.Permission.storage.request().then((value)async{
          if (value==perm.PermissionStatus.granted){
        _paths=null;
      try {
        _paths = (await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.image)).paths;
            setState(() {});
            print(_paths);
        } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
       }
      if (!mounted) return;
      }else{
        return;
      }
  });
    }
  uploadToFirebase() {
      _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
    } 
  upload(fileName, filePath) {
    _extension = fileName.toString().split('.').last;
    storage.Reference storageRef =
    storage.FirebaseStorage.instance.ref().child(fileName);
    final storage.UploadTask uploadTask = storageRef.putFile(
      File(filePath),
      storage.SettableMetadata(
        contentType: 'image/$_extension',
      ),
    );
    setState(() {
      _tasks.add(uploadTask);
    });
    _extension = null;
  }

  @override
  Widget build(BuildContext context) {
    final ImagePRO imagePRO=Provider.of(context,listen: false);
    print("image is here !!!!");
    imagePRO.azero();
    final List<Widget> children = <Widget>[];
    if (_tasks.length>0){
    _tasks.forEach((storage.UploadTask task) {
      final Widget tile = UploadTaskListTile(
        imagePRO: imagePRO,
        task: task,
      );
      children.add(tile);
    });
    }else{
      print("no tasks yettttttttttttttttt");
    }
    return Container(
       child: Column(
         children: [
               _paths == null || _paths.length==0 ? OutlineButton(
                onPressed: (){ 
                  openFileExplorer();
                  setState(() {
                  });
                  },
                child: new Text("Open file picker"),
              ):Column(
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 5.0,
                    children: List.generate(_paths.length, (index){
                      return Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width/2-5
                        ),
                        child: Image.file(File(_paths[_paths.keys.toList()[index]]),),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlineButton(
                onPressed: ()=>openFileExplorer(),
                child: new Text("Open file picker",style: TextStyle(color: Colors.red),),
                  ),
                   OutlineButton(
                onPressed: ()=>uploadToFirebase(),
                child: new Text("UPLOAD IMAGES TO DATABASE",style: TextStyle(color: Colors.red),),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
               Column(
                  children: children
                )
       ],
       ),
    );
  }
}



class UploadTaskListTile extends StatelessWidget {

  const UploadTaskListTile(
      {Key key, this.task, this.imagePRO})
      : super(key: key);

  final storage.UploadTask task;
  final ImagePRO imagePRO;
  String get status {
    String result;
    if (task.snapshot.state==storage.TaskState.success) {
        result = 'Complete';
      } else if (task.snapshot.state==storage.TaskState.canceled) {
        result = 'Canceled';
      } 
    else if (task.snapshot.state==storage.TaskState.running) {
      result = 'Uploading';
    } else if (task.snapshot.state==storage.TaskState.paused) {
      result = 'Paused';
    }
    return result;
  }

  String _bytesTransferred(storage.TaskSnapshot snapshot) {
    return '${((snapshot.bytesTransferred/snapshot.totalBytes)*100)} % Completed';
  }

  @override
  Widget build(BuildContext context) {
  //  ImagePRO imagePRO = Provider.of<ImagePRO>(context,listen: false);
    return StreamBuilder<storage.TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (BuildContext context,
          AsyncSnapshot<storage.TaskSnapshot> asyncSnapshot) {

        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final  storage.TaskSnapshot snapshot = asyncSnapshot.data;
          subtitle = Text('$status: ${_bytesTransferred(snapshot)} ');
          if (status=="Complete"){
              imagePRO.addaUrl(snapshot.ref);
          }
        } else {
          subtitle = const Text('Starting...');
        }
        return ListTile(
            title: Text('Upload Task #${task.hashCode}'),
            subtitle: subtitle,
          );
      },
    );
  }
}*/