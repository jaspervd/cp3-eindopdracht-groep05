package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.factory.PersonVOFactory;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import starling.events.Event;
import starling.events.EventDispatcher;

public class PersonModel extends EventDispatcher {
    private static var instance:PersonModel;

    private var _persons:Array;
    private var _moderator:PersonVO;
    private var _currentPerson:PersonVO;
    public static const MODERATOR_SET:String = "MODERATOR_SET";
    public static const CURRENT_PERSON_SET:String = "CURRENT_PERSON_SET";

    public static function getInstance():PersonModel {
        if (instance == null) {
            instance = new PersonModel(new Enforcer());
        }
        return instance;
    }

    public function PersonModel(e:Enforcer) {
        if (e == null) {
            throw new Error('PersonModel is a singleton, use getInstance() instead');
        }

        _persons = [];
    }

    public function get persons():Array {
        return _persons;
    }

    public function set persons(value:Array):void {
        if (_persons != value) {

            _persons = value;

        }
    }

    public function getModerator():PersonVO {
        for each(var person:PersonVO in _persons) {
            if (person.moderator) {
                _moderator = person;
            }
        }
        return _moderator;
    }

    public function add(value:Object):Array {
        var lastPerson:PersonVO = _persons[_persons.length - 1];
        if (_persons.length == 0) {
            value.id = 1;
        } else {
            value.id = lastPerson.id + 1;
        }
        var personVO:PersonVO = PersonVOFactory.createPersonVOFromObject(value);
        _persons.push(personVO);
        dispatchEvent(new Event(Event.CHANGE));

        if (value.moderator) {
            dispatchEvent(new Event(MODERATOR_SET));
        }

        return _persons;
    }

    public function deleteById(id:uint):Array {
        for each(var person:PersonVO in _persons) {
            if (person.id == id) {
                _persons.splice(_persons.indexOf(person), 1);
            }
        }
        dispatchEvent(new Event(Event.CHANGE));

        return _persons;
    }

    public function getPersonsByTaskId(id:uint):Array {
        var tempArr:Array = [];
        for each(var person:PersonVO in _persons) {
            if (person.task_id == id) {
                tempArr.push(person);
            }
        }
        return tempArr;
    }

    public function updateIou(taskId:uint, iou:Number):void {

        for each(var person:PersonVO in persons) {
            trace(person.name);
            trace(_persons.indexOf(person));

            if (person.task_id == taskId) {
                _persons.splice(_persons.indexOf(person), 1);
                person.iou = Number(iou.toFixed(2));
                _persons.push(person);
            }

        }


    }

    public function get currentPerson():PersonVO {
        return _currentPerson;
    }

    public function set currentPerson(value:PersonVO):void {
        if (_currentPerson != value) {
            _currentPerson = value;
            dispatchEvent(new Event(CURRENT_PERSON_SET));
        }
    }

    public function updatePerson(_currentPerson:PersonVO, personObj:Object):void {
        var index:uint = _persons.indexOf(_currentPerson);
        _persons[index].name = personObj.name;
        _persons[index].iou = personObj.iou;

        dispatchEvent(new Event(Event.CHANGE));
    }

    public function deletePersonsByTaskId(taskId:uint):void {
        for each(var person:PersonVO in _persons) {
            if (person.task_id == taskId) {
                _persons.splice(_persons.indexOf(person), 1);
            }
        }
        dispatchEvent(new Event(Event.CHANGE));
    }
}
}
internal class Enforcer {
}