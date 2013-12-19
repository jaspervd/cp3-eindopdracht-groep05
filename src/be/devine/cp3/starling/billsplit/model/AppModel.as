package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.TaskService;

import starling.events.Event;

import starling.events.EventDispatcher;


public class AppModel extends EventDispatcher {
    private static var instance:AppModel;

    private var _persons:Array;
    private var _tasks:Array;
    private var _currentScreen:String = "overview";
    public var _oldScreenName:String = "overview";

    private var _completed:Boolean;

    public static var PERSONS_CHANGED:String = 'PERSONS_CHANGED';
    public static var TASKS_CHANGED:String = 'TASKS_CHANGED';
    public static var CALCULATION_CHANGED:String = 'CALCULATION_CHANGED';
    public static var COMPLETED:String = 'COMPLETED';

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
    }

    public function load():void {
        var personService:PersonService = new PersonService();
        personService.addEventListener(Event.COMPLETE, personsLoadCompleteHandler);
        personService.load();

        var taskService:TaskService = new TaskService();
        taskService.addEventListener(Event.COMPLETE, tasksLoadCompleteHandler);
        taskService.load();

        completed = true;
    }

    private function personsLoadCompleteHandler(event:Event):void {
        var personService:PersonService = event.target as PersonService;
        _persons = personService.persons;
    }

    private function tasksLoadCompleteHandler(event:Event):void {
        var taskService:TaskService = event.target as TaskService;
        _tasks = taskService.tasks;
    }

    //write json when app Closes
    public function closeApp():void {
        PersonService.write(_persons);
        TaskService.write(_tasks);
    }


    public function get persons():Array {
        return _persons;
    }
    public function get tasks():Array {
        return _tasks;
    }










    public function get completed():Boolean {
        return _completed;
    }

    public function set completed(value:Boolean):void {
        _completed = value;

        trace("[COMPLETE] = "+_completed);

        if(_completed){

            dispatchEvent(new Event(COMPLETED,true));
        }

    }


    public function get currentScreen():String {
        return _currentScreen;
    }

    public function set currentScreen(value:String):void {

        if(_currentScreen != value){

            _oldScreenName = _currentScreen;
            _currentScreen = value;

            dispatchEvent(new Event(Event.CHANGE));

        }
    }
}
}
internal class Enforcer {
}