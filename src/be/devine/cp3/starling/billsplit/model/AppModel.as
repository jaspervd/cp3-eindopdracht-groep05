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
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import flash.events.Event;

import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher {
    private static var instance:AppModel;
    private var _queue:Queue;
    private var _persons:Array;
    private var _person:PersonVO;
    private var _tasks:Array;
    private var _ious:Array;

    public static var PERSON_CHANGED = 'PERSON_CHANGED';
    public static var TASK_CHANGED = 'TASK_CHANGED';
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
    }

    public function load() {
        _queue = new Queue();
        _queue.add(new URLLoaderTask('/assets/json/persons.json'));
        _queue.add(new URLLoaderTask('/assets/json/tasks.json'));
        _queue.add(new URLLoaderTask('/assets/json/ious.json'));

        _queue.start();
        _queue.addEventListener(Event.COMPLETE, completeHandler);
    }

    private function completeHandler(event:Event):void {
        //trace(_queue.loadedItems[0], _queue.loadedItems[1], _queue.loadedItems[2]);
        var data:Object = JSON.parse(_queue.loadedItems[0].data);
        for each(var thisPerson:Object in data) {
            person = thisPerson;
        }
        trace(PersonVO(_persons[0]).NAME);
        /*tasks = _queue.loadedItems[1].data;
        ious = _queue.loadedItems[2].data;*/
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
    }

    public function get tasks():Array {
        return _tasks;
    }

    public function set tasks(value:Array):void {
        _tasks = value;
        trace(_tasks);
    }

    public function get ious():Array {
        return _ious;
    }

    public function set ious(value:Array):void {
        _ious = value;
        trace(_ious);
    }
}
}
internal class Enforcer {};