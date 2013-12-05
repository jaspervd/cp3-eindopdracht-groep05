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

        _tasksfile = File.desktopDirectory.resolvePath ("/assets/json/tasks.json");
        _personsfile = File.desktopDirectory.resolvePath ("/assets/json/persons.json");
        _iousfile = File.desktopDirectory.resolvePath ("/assets/json/ious.json");

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




}
}
