/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 28/11/13
 * Time: 16:59
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.model {
import be.devine.cp3.queue.Queue;
import be.devine.cp3.queue.URLLoaderTask;
import be.devine.cp3.starling.billsplit.json.JsonHandler;
import be.devine.cp3.starling.billsplit.vo.IouVO;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import flash.events.Event;

import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher {
    private static var instance:AppModel;
    private var _queue:Queue;
    private var _persons:Array;
    private var _person:PersonVO;
    private var _task:TaskVO;
    private var _tasks:Array;
    private var _iou:IouVO;
    private var _ious:Array;
    private var completed:Boolean;
    private var _jsonHandler:JsonHandler;

    public static var PERSONS_CHANGED = 'PERSONS_CHANGED';
    public static var TASKS_CHANGED = 'TASKS_CHANGED';
    public static var IOUS_CHANGED = 'IOUS_CHANGED';
    public static var CALCULATION_CHANGED = 'CALCULATION_CHANGED';

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
        _queue = new Queue();
        _queue.add(new URLLoaderTask('/assets/json/persons.json'));
        _queue.add(new URLLoaderTask('/assets/json/tasks.json'));
        _queue.add(new URLLoaderTask('/assets/json/ious.json'));

        _queue.start();
        _queue.addEventListener(Event.COMPLETE, completeHandler);
    }

    public function closeApp():void {
        _jsonHandler.write();
    }

    private function completeHandler(event:Event):void {
        var personsData:Object = JSON.parse(_queue.loadedItems[0].data);
        for each(var thisPerson:Object in personsData) {
            person = thisPerson;
        }

        var tasksData:Object = JSON.parse(_queue.loadedItems[1].data);
        for each(var thisTask:Object in tasksData) {
            task = thisTask;
        }

        var iousData:Object = JSON.parse(_queue.loadedItems[2].data);
        for each(var thisIou:Object in iousData) {
            iou = thisIou;
        }

        completed = true;
    }

    public function get person():Object {
        return _person;
    }

    public function set person(value:Object):void {
        _person = new PersonVO();
        _person.ID = value.id;
        _person.NAME = value.name;
        _person.IMAGE = value.image;
        _person.TASK_ID = value.task_id;
        _person.MODERATOR = value.moderator;
        _persons.push(_person);
        if (completed) {
            dispatchEvent(new Event(PERSONS_CHANGED));
        }
    }

    public function get task():Object {
        return _tasks;
    }

    public function set task(value:Object):void {
        _task = new TaskVO();
        _task.ID = value.id;
        _task.TITLE = value.title;
        _task.TYPE = value.type;
        _task.PRICE = value.price;
        _task.PRICE_ID = value.price_id;
        _task.TIMESTAMP = value.timestamp;
        _task.PAID = value.paid;
        _tasks.push(_task);

        if (completed) {
            dispatchEvent(new Event(TASKS_CHANGED));
        }
    }

    public function get iou():Object {
        return _ious;
    }

    public function set iou(value:Object):void {
        _iou = new IouVO();
        _iou.ID = value.id;
        _iou.PRICE = value.price;
        _iou.PERSON_ID = value.id;
        _iou.TASK_ID = value.id;
        _iou.PAID = value.paid;
        _ious.push(_iou);

        if (completed) {
            dispatchEvent(new Event(IOUS_CHANGED));
        }
    }
}
}
internal class Enforcer {
}