/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 28/11/13
 * Time: 16:59
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.model {
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher {
    private static var instance:AppModel;
    private var _persons:Array;
    private var _tasks:Array;
    private var _iou:Array;

    public static var PERSON_CHANGED = 'PERSON_CHANGED';
    public static var TASK_CHANGED = 'TASK_CHANGED';
    public static var IOU_CHANGED = 'IOU_CHANGED';
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
    }

    public function load() {

    }

    public function get persons():Array {
        return _persons;
    }

    public function set persons(value:Array):void {
        _persons = value;
    }

    public function get tasks():Array {
        return _tasks;
    }

    public function set tasks(value:Array):void {
        _tasks = value;
    }

    public function get iou():Array {
        return _iou;
    }

    public function set iou(value:Array):void {
        _iou = value;
    }
}
}
internal class Enforcer {};