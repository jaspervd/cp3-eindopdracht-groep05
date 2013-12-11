/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 5/12/13
 * Time: 14:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.json {
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class JsonHandler {

    private var _tasks:Array;
    private var _persons:Array;
    private var _ious:Array;


    private var _tasksfile:File;
    private var _personsfile:File;
    private var _iousfile:File;

    private var _fileStream:FileStream;


    public function JsonHandler() {

        _tasks = [];
        _persons = [];
        _ious = [];

    }

    public function updatePersons(persons:Array):void{

        if(_persons.length < 0){

            if(_persons != persons){

                _persons = persons;
            }

        }else{

            _persons = persons;
        }

    }

    public function updateTasks(tasks:Array):void{

        if(_persons.length < 0){

            if(_persons != tasks){

                _persons = tasks;
            }

        }else{

            _persons = tasks;
        }

    }


    public function updateIous(ious:Array):void{

        if(_ious.length < 0){

            if(_ious != ious){

                _ious = ious;
            }

        }else{

            _ious = ious;
        }

    }


    public function write():void{

        _tasksfile = File.applicationStorageDirectory.resolvePath ("tasks.json");
        _personsfile = File.applicationStorageDirectory.resolvePath ("persons.json");
        _iousfile = File.applicationStorageDirectory.resolvePath ("ious.json");

        filestream(_tasksfile,_tasks);
        filestream(_personsfile,_persons);
        filestream(_iousfile,_ious);

    }

    private function filestream(file:File,json:Array):void{

        var _json:String = JSON.stringify(json);

        _fileStream = new FileStream ();
        _fileStream.openAsync (file, FileMode.WRITE);
        _fileStream.writeUTFBytes (_json);
        _fileStream.addEventListener (Event.CLOSE, fileStreamClosed);
        _fileStream.close ();


    }

    private function fileStreamClosed(event:Event):void {

        trace("Closed");

    }

    public function insertJson(f:File):void{

        var fs:FileStream;

        if(!f.exists) {
            fs = new FileStream();
            fs.open(f, FileMode.WRITE);
            fs.writeUTFBytes(JSON.stringify([
                {
                    "id": 1,
                    "name": "Justin Timberlake",
                    "image": "url",
                    "task_id": 1,
                    "moderator": true
                }
            ]));
            fs.close();
        }

    }

    public function loadJson(f:File):Object{

        var fs:FileStream;
        fs = new FileStream();
        fs.open(f, FileMode.READ);
        var data:Object = JSON.parse(fs.readUTFBytes(fs.bytesAvailable));
        fs.close();

        return data;
    }




}
}
