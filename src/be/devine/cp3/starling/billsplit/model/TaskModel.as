package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import starling.events.Event;

import starling.events.EventDispatcher;

public class TaskModel extends EventDispatcher {

    private static var instance:TaskModel;

    private var _tasks:Array;
    private var _task:TaskVO;
    private var _currentTask:TaskVO;
    private var _totalPrice:Number;
    private var _currency:Boolean;
    public static const CURRENT_TASK_SET:String = 'CURRENT_TASK_SET';

    public static function getInstance():TaskModel {
        if (instance == null) {
            instance = new TaskModel(new Enforcer());
        }
        return instance;
    }

    public function TaskModel(e:Enforcer) {
        if (e == null) {
            throw new Error('TaskModel is a singleton, use getInstance() instead');
        }
        _tasks = [];
        _currency = true;
    }

    public function load():void {
        var taskService:TaskService = new TaskService();
        taskService.addEventListener(Event.COMPLETE, tasksLoadCompleteHandler);
        taskService.load();
    }

    private function tasksLoadCompleteHandler(event:Event):void {
        var taskService:TaskService = event.target as TaskService;
        tasks = taskService.tasks;
    }

    public function get tasks():Array {
        _tasks.sortOn('id', Array.DESCENDING);
        return _tasks;
    }

    public function set tasks(value:Array):void {
        if (_tasks != value) {
            _tasks = value;
        }
    }

    public function getTask(id:uint):TaskVO {
        for each(var task:TaskVO in _tasks) {
            if (task.id == id) {
                _task = task;
            }
        }
        return _task;
    }

    public function add(value:Object):void {
        var lastTask:TaskVO = _tasks[0];
        var date:Date = new Date();
        if (_tasks.length == 0) {
            value.id = 1;
        } else {
            value.id = lastTask.id + 1;
        }
        value.timestamp = date.getTime();

        var task:TaskVO = TaskVOFactory.createTaskVOFromObject(value);
        _tasks.push(task);
        dispatchEvent(new Event(Event.CHANGE));
    }

    public function deleteById(id:uint):Array {
        for each(var task:TaskVO in _tasks) {
            if (task.id == id) {
                _tasks.splice(_tasks.indexOf(task), 1);
            }
        }
        dispatchEvent(new Event(Event.CHANGE));
        return _tasks;
    }

    public function get currentTask():TaskVO {
        return _currentTask;
    }

    public function set currentTask(value:TaskVO):void {
        if(_currentTask != value) {
            _currentTask = value;
            dispatchEvent(new Event(CURRENT_TASK_SET));
        }
    }

    public function updateTask(_currentTask:TaskVO, taskObj:Object):void {
        var index:uint = _tasks.indexOf(_currentTask);
        _tasks[index].title = taskObj.title;
        _tasks[index].price = taskObj.price;

        dispatchEvent(new Event(Event.CHANGE));
    }

    public function get totalPrice():Number {
        return _totalPrice;
    }

    public function set totalPrice(value:Number):void {
        _totalPrice = value;
    }

    public function get currency():Boolean {
        return _currency;
    }

    public function set currency(value:Boolean):void {
        if(_currency != value) {
            _currency = value;
        }
    }
}
}
internal class Enforcer {
}
