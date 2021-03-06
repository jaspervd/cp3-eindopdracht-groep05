package be.devine.cp3.starling.billsplit.view.screens {


import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;
import feathers.controls.ImageLoader;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;
import feathers.renderers.TaskListRenderer;
import flash.filesystem.File;
import starling.events.Event;
import starling.text.TextField;


public class Overview extends Screen {


    private var _personModel:PersonModel;
    private var _taskModel:TaskModel;
    private var _appmodel:AppModel;
    private var _moderator:PersonVO;
    private var _tasks:Array;
    private var _profile:ImageLoader;
    private var _fullName:TextField;
    private var _infoText:TextField;
    private var _profileLayout:LayoutGroup;
    private var _taskList:List;
    private var _layout:VerticalLayout;


    [Embed(source="/../assets/images/circle_mask.png")]
    private var CircleMask:Class;

    public function Overview() {

        _personModel = PersonModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _appmodel = AppModel.getInstance();
        _tasks = _taskModel.tasks;
        _moderator = _personModel.getModerator();

        _taskModel.addEventListener(Event.CHANGE, tasksChangedHandler);

        _profileLayout = new LayoutGroup();
        addChild(_profileLayout);

        _taskList = new List();
        _taskList.itemRendererType = TaskListRenderer;
        _taskList.itemRendererProperties.labelField = "title";
        _taskList.itemRendererProperties.accessoryField = "accessory";
        addChild(_taskList);

        _layout = new VerticalLayout();
        _layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        _layout.gap = 5;
        _profileLayout.layout = _layout;

        _profile = new ImageLoader();
        _profileLayout.addChild(_profile);

        _fullName = new TextField(100, 30, "", "SourceSansProSemiBold", 26, 0xFFFFFF);
        _infoText = new TextField(400, 30, "You have created " + 0 + " bills with a total of " + 0 + " euros", "SourceSansPro", 18, 0xFFFFFF);

        _profileLayout.addChild(_fullName);
        _profileLayout.addChild(_infoText);

        _personModel.addEventListener(PersonModel.MODERATOR_SET, setModeratorHandler);

        if(_moderator != null) {
            setModeratorHandler();
        }
    }

    private function setModeratorHandler(event:Event = null):void {
        _moderator = _personModel.getModerator();
        var image:File = File.applicationStorageDirectory.resolvePath(_moderator.image);
        _profile.source = image.url;
        _profile.addEventListener(Event.COMPLETE, imageCompleteHandler);

        _fullName.text = _moderator.name;

        tasksChangedHandler();
    }

    private function tasksChangedHandler(event:Event = null):void {
        var totalPrice:Number = 0;
        for each(var task:TaskVO in _tasks) {
            totalPrice += task.price;
        }

        _infoText.text = "You have created " + _tasks.length + " bills with a total of " + totalPrice + " euros";
        _taskList.dataProvider = new ListCollection(_tasks);
    }

    private function imageCompleteHandler(event:Event):void {

        _profile.setSize(stage.stageWidth * 0.35, stage.stageWidth * 0.35);

    }


    override protected function initialize():void {
        layout();
    }


    private function layout():void {


        _layout.paddingTop = stage.stageHeight * 0.12;
        _fullName.width = stage.stageWidth * 0.5;

        _profileLayout.setSize(stage.stageWidth, stage.stageHeight / 2);
        _profile.x = (stage.stageWidth + _profile.width) / 2;
        _taskList.setSize(stage.stageWidth, (stage.stageHeight - _profileLayout.height));
        _taskList.y = _profileLayout.height;
        _taskList.dataProvider = new ListCollection(_tasks);
        _taskList.itemRendererProperties.gap = 1;
        _taskList.addEventListener(Event.CHANGE, triggeredHandler);


    }

    private function triggeredHandler(event:Event):void {

        if (_taskList.selectedItem) {
            _taskModel.currentTask = TaskVO(_taskList.selectedItem);
            _appmodel.currentScreen = "detail";
            _taskList.selectedIndex = -1;
        }

    }
}
}
