package be.devine.cp3.starling.billsplit.model {

import be.devine.cp3.starling.billsplit.factory.PersonVOFactory;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

public class PersonModel {
    private static var instance:PersonModel;

    private var _persons:Array;
    private var _moderator:PersonVO;

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
        if(_persons != value) {

            _persons = value;

        }
    }

    public function getModerator():PersonVO {
        for each(var person:PersonVO in _persons) {
            if(person.moderator) {
                _moderator = person;
            }
        }
        if(_moderator == null) {
            trace('account aanmaken');
        }
        return _moderator;
    }

    public function add(value:Object):Array {
        var personTask:PersonVO = _persons[_persons.length - 1];
        value.id = personTask.id + 1;
        if(_persons.length == 0) {
            value.id = 1;
        } else {
            value.id = personTask.id + 1;
        }

        var person:PersonVO = PersonVOFactory.createPersonVOFromObject(value);
        _persons.push(person);
        return _persons;
    }

    public function deleteById(id:uint):Array {
        for each(var person:PersonVO in _persons) {
            if (person.id == id) {
                _persons.splice(_persons.indexOf(person), 1);
            }
        }
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
}
}
internal class Enforcer {
}