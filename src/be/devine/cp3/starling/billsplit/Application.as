package be.devine.cp3.starling.billsplit {



//IMPORTS
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.view.Content;
import be.devine.cp3.starling.billsplit.view.Header;
import feathers.themes.MetalWorksMobileTheme;
import starling.display.Sprite;
import starling.events.Event;




public class Application extends Sprite {
    private var _appModel:AppModel;
    private var _personModel:PersonModel;
    private var _taskModel:TaskModel;
    private var header:Header;
    private var app:Content;
    private var _theme:MetalWorksMobileTheme;


    public function Application() {
        _theme = new MetalWorksMobileTheme();

        _appModel = AppModel.getInstance();
        _personModel = PersonModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel.load();
        _taskModel.load();

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);

        app = new Content();
        addChild(app);

        header = new Header();
        addChild(header);
    }

    private function resizeHandler(event:Event):void {

    }
}
}
