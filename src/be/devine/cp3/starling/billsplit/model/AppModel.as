package be.devine.cp3.starling.billsplit.model {
import starling.events.Event;
import starling.events.EventDispatcher;


public class AppModel extends EventDispatcher {
    private static var instance:AppModel;

    private var _currentScreen:String;
    public var _oldScreenName:String;

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

        _currentScreen = _oldScreenName = "overview";
    }

    public function get currentScreen():String {
        return _currentScreen;
    }

    public function set currentScreen(value:String):void {
        if(_currentScreen != value){
            _oldScreenName = _currentScreen;
            _currentScreen = value;
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
}
internal class Enforcer {
}