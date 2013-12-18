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


        app = new Content();
        addChild(app);


        header = new Header();
        addChild(header);

        if(_personModel.getModerator() == null) {
            _appModel.currentScreen = "register";
        }

        //this.addEventListener(FeathersEventType.INITIALIZE, intializerHandler);

    }

    private function resizeHandler(event:Event):void {

        trace("resize");
    }


    /*private function changeDockMode(drawer:DrawerView, dockMode:String):void
    {
        switch(drawer)
        {
            case this.topDrawer:
            {
                this.topDrawerDockMode = dockMode;
                break;
            }
            case this.rightDrawer:
            {
                this.rightDrawerDockMode = dockMode;
                break;
            }
            case this.bottomDrawer:
            {
                this.bottomDrawerDockMode = dockMode;
                break;
            }
            case this.leftDrawer:
            {
                this.leftDrawerDockMode = dockMode;
                break;
            }
        }
    }*/

    /* private function initializerHandler(event:Event):void {


     new DrawersExplorerTheme();

     //a drawer may be opened by dragging from the edge of the content
     //you can also set it to drag from anywhere inside the content
     //or you can disable gestures entirely and only open a drawer when
     //an event is dispatched by the content or by calling a function
     //on the drawer component to open a drawer programmatically.
     this.openGesture = Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE;

     this.content = new Content();
     //these events are dispatched by the content
     //Drawers listens for each of these events and opens the drawer
     //associated with an event when it is dispatched
     this.rightDrawerToggleEventType = Content.TOGGLE_RIGHT_DRAWER;


     var rightDrawer:DrawerView = new DrawerView("Right");
     rightDrawer.nameList.add(DrawersExplorerTheme.THEME_NAME_LEFT_AND_RIGHT_DRAWER);
     rightDrawer.addEventListener(DrawerView.CHANGE_DOCK_MODE_TO_NONE, drawer_dockNoneHandler);
     rightDrawer.addEventListener(DrawerView.CHANGE_DOCK_MODE_TO_BOTH, drawer_dockBothHandler);
     this.rightDrawer = rightDrawer;
     this.rightDrawerDockMode = Drawers.DOCK_MODE_NONE;



     }


     private function changeDockMode(drawer:DrawerView, dockMode:String):void
     {
     switch(drawer)
     {
     case this.topDrawer:
     {
     this.topDrawerDockMode = dockMode;
     break;
     }
     case this.rightDrawer:
     {
     this.rightDrawerDockMode = dockMode;
     break;
     }
     case this.bottomDrawer:
     {
     this.bottomDrawerDockMode = dockMode;
     break;
     }
     case this.leftDrawer:
     {
     this.leftDrawerDockMode = dockMode;
     break;
     }
     }
     }


     private function drawer_dockNoneHandler(event:Event):void
     {
     var drawer:DrawerView = DrawerView(event.currentTarget);
     this.changeDockMode(drawer, Drawers.DOCK_MODE_NONE);
     }

     private function drawer_dockBothHandler(event:Event):void
     {
     var drawer:DrawerView = DrawerView(event.currentTarget);
     this.changeDockMode(drawer, Drawers.DOCK_MODE_BOTH);
     }*/

}
}
