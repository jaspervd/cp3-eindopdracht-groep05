package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.vo.TaskVO;


public class TaskModel {

    private static var instance:TaskModel;

    private var _tasks:Array;
    private var _task:TaskVO;

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
            if (task.id = id) {
                _task = task;
            }
        }
        return _task;
    }

    public function add(value:Object):Array {
        var lastTask:TaskVO = _tasks[_tasks.length - 1];
        value.id = lastTask.id + 1;
        var task:TaskVO = TaskVOFactory.createTaskVOFromObject(value);
        _tasks.push(task);
        return _tasks;
    }

    public function deleteById(id:uint):Array {
        for each(var task:TaskVO in _tasks) {
            if (task.id == id) {
                _tasks.splice(_tasks.indexOf(task), 1);
            }
        }
        return _tasks;
    }
}
}
internal class Enforcer {
}
