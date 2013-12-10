/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 10/12/13
 * Time: 14:29
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.model {
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
            throw new Error('AppModel is a singleton, use getInstance() instead');
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
}
}
internal class Enforcer {
}