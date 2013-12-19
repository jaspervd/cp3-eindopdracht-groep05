package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import starling.events.Event;

import starling.events.EventDispatcher;


public class TaskModel extends EventDispatcher {

    private static var instance:TaskModel;

    private var _tasks:Array;
    private var _task:TaskVO;
    private var _currentTask:TaskVO;
    private var _currency:Boolean = false;
    private var _totalPrice:Number;

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
    }

    public function get tasks():Array {
        return _tasks;
    }

    public function set tasks(value:Array):void {
        if (_tasks != value) {

            _tasks = value;

        }
    }

    public function getAllTasks():Array {
        return _tasks;
    }

    public function getTask(id:uint):TaskVO {
        for each(var task:TaskVO in _tasks) {
            if (task.id == id) {
                _task = task;
            }
        }
        return _task;
    }

    public function add(value:Object):Array {
        var lastTask:TaskVO = _tasks[_tasks.length - 1];
        var date:Date = new Date();
        if(_tasks.length == 0) {
            value.id = 1;
        } else {
            value.id = lastTask.id + 1;
        }
        value.timestamp = date.getTime();
        var newPrice:String = "";

        for(var i:uint = 0; i<value.price.length; i++){

            var char:String = value.price.charAt(i);
            if(value.price.charAt(i) == ","){

                char = ".";

            }

            trace(value.price.charAt(i));

            newPrice += char;

            trace(newPrice);

        }

        value.price = newPrice;
        trace(value.price);

        var task:TaskVO = TaskVOFactory.createTaskVOFromObject(value);
        _tasks.push(task);
        dispatchEvent(new Event(Event.CHANGE));
        return _tasks;
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
        _currentTask = value;
    }

    public function get currency():Boolean {
        return _currency;
    }

    public function set currency(value:Boolean):void {
        _currency = value;
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
}
}
internal class Enforcer {
}
