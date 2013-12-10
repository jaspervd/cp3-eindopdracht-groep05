package be.devine.cp3.starling.billsplit.model {


import be.devine.cp3.starling.billsplit.vo.TaskVO;


public class TaskModel {

    private static var instance:TaskModel;

    private var _tasks:Array;
    private var _task:TaskVO;

    public static function getInstance():TaskModel {

        if (instance == null) {  instance = new TaskModel(new Enforcer());  }

        return instance;

    }

    public function TaskModel(e:Enforcer) {

        if (e == null) { throw new Error('AppModel is a singleton, use getInstance() instead');}

        _tasks = [];
    }

    public function get tasks():Array {
        return _tasks;
    }

    public function set tasks(value:Array):void {
        if(_tasks != value) {

            _tasks = value;

        }
    }

    public function getAllTasks():Array{

        return _tasks;
    }

    public function getTask(id:uint):TaskVO {
        for each(var task:TaskVO in _tasks) {
            if(task.id = id) {
                _task = task;
            }
        }
        return _task;
    }
}
}
internal class Enforcer {
}
