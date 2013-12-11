package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.factory.IouVOFactory;
import be.devine.cp3.starling.billsplit.factory.PersonVOFactory;
import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.json.JsonHandler;
import be.devine.cp3.starling.billsplit.vo.IouVO;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.filesystem.File;

public class AppModel extends EventDispatcher {

    private static var instance:AppModel;

    private var _personsData:Object;
    private var _tasksData:Object;
    private var _iousData:Object;


    private var _persons:Array;
    private var _tasks:Array;
    private var _ious:Array;


    private var _completed:Boolean;
    private var _jsonHandler:JsonHandler;



    public static var PERSONS_CHANGED = 'PERSONS_CHANGED';
    public static var TASKS_CHANGED = 'TASKS_CHANGED';
    public static var IOUS_CHANGED = 'IOUS_CHANGED';
    public static var CALCULATION_CHANGED = 'CALCULATION_CHANGED';
    public static var COMPLETE_BITCH:String = 'COMPLETE_BITCH';

    public static function getInstance():AppModel {
        if (instance == null) {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function AppModel(e:Enforcer) {
        if (e == null) {
            throw new Error('AppModel is a singleton, use getInstance() instead');
        }

        _persons = [];
        _tasks = [];
        _ious = [];
        _jsonHandler = new JsonHandler();
    }

    public function load():void {

        var persons:File = File.applicationStorageDirectory.resolvePath("persons.json");
        var tasks:File = File.applicationStorageDirectory.resolvePath("tasks.json");
        var ious:File = File.applicationStorageDirectory.resolvePath("ious.json");

        _jsonHandler.insertJson(persons);
        _jsonHandler.insertJson(tasks);
        _jsonHandler.insertJson(ious);

        _personsData = _jsonHandler.loadJson(persons);
        _tasksData = _jsonHandler.loadJson(tasks);
        _iousData = _jsonHandler.loadJson(ious);


        completeHandler();

    }


    private function completeHandler():void {


        for each(var thisPerson:Object in _personsData) {

            addPerson(thisPerson);
        }


        for each(var thisTask:Object in _tasksData) {

            addTask(thisTask);
        }


        for each(var thisIou:Object in _iousData) {

            addIou(thisIou);
        }

        if(_persons && _tasks && _ious){

            completed = true;
        }

    }














    //add

    public function addPerson(value:Object):void {
        var person:PersonVO = PersonVOFactory.createPersonVOFromObject(value);
        _persons.push(person);

        if (completed) {
            dispatchEvent(new Event(PERSONS_CHANGED));
        }
    }


    public function addTask(value:Object):void {
        var task:TaskVO = TaskVOFactory.createTaskVOFromObject(value);
        _tasks.push(task);

        if (completed) {
            dispatchEvent(new Event(TASKS_CHANGED));
        }
    }


    public function addIou(value:Object):void {
        var iou:IouVO = IouVOFactory.createIouVOFromObject(value);
        _ious.push(iou);

        if (completed) {
            dispatchEvent(new Event(IOUS_CHANGED));
        }
    }





    //write json when app Closes
    public function closeApp():void {
        _jsonHandler.write();
    }


    public function get persons():Array {
        return _persons;
    }
    public function get tasks():Array {
        return _tasks;
    }
    public function get ious():Array {
        return _ious;
    }










    public function get completed():Boolean {
        return _completed;
    }

    public function set completed(value:Boolean):void {
        _completed = value;

        trace("[COMPLETE] = "+_completed);

        trace(PersonVO(_persons[0]).name);

        if(_completed){

            dispatchEvent(new Event(COMPLETE_BITCH,true));
        }

    }


}
}
internal class Enforcer {
}