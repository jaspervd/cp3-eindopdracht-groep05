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
    private var content:Content;
    private var _theme:MetalWorksMobileTheme;

    public function Application() {
        _theme = new MetalWorksMobileTheme();

        _appModel = AppModel.getInstance();
        _appModel.load();

        _personModel = PersonModel.getInstance();
        _taskModel = TaskModel.getInstance();

        addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }


    private function closeHandler(event:Event):void {
        trace('main close');
        _appModel.closeApp();
    }

    private function addedHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        stage.addEventListener(Event.CLOSE, closeHandler);

        _personModel.persons = _appModel.persons;
        _taskModel.tasks = _appModel.tasks;


        content = new Content();
        addChild(content);

        header = new Header();
        addChild(header);


    }

    private function resizeHandler(event:Event):void {

        trace("resize");
    }

}
}
