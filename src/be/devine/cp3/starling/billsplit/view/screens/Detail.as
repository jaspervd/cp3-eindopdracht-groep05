package be.devine.cp3.starling.billsplit.view.screens {



import be.devine.cp3.starling.billsplit.format.DateFormat;
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.TaskVO;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import starling.events.Event;
import starling.text.TextField;





public class Detail extends Screen {


    private var _appModel:AppModel;
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _personList:List;
    private var _taskLayout:LayoutGroup;
    private var _detailGroup:LayoutGroup;
    private var _taskTitle:TextField;
    private var _currentTask:TaskVO;
    private var _type:Button;
    private var _total:Button;
    private var _people:Button;
    private var _addPerson:Button;
    private var _dateTime:TextField;



    public function Detail() {

        _appModel = AppModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();
        _currentTask = new TaskVO();

        _appModel.addEventListener(Event.CHANGE, updateTask);

        _personList = new List();
        _personList.itemRendererProperties.labelField = "name";
        addChild(_personList);

        _taskLayout = new LayoutGroup();
        addChild(_taskLayout);


        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _taskLayout.layout = layout;

        _type = new Button();
        _type.nameList.add("type");
        _type.iconPosition = Button.ICON_POSITION_LEFT;
        _taskLayout.addChild(_type);

        _taskTitle = new TextField(100, 30, "", "SourceSansProSemiBold", 28, 0xFFFFFF);
        _taskLayout.addChild(_taskTitle);


        _dateTime = new TextField(100, 30, "", "SourceSansProSemiBold", 18, 0xFFFFFF);
        _taskLayout.addChild(_dateTime);


        _detailGroup = new LayoutGroup();
        _taskLayout.addChild(_detailGroup);


        var horlayout:HorizontalLayout = new HorizontalLayout();
        horlayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
        horlayout.gap = 20;
        _detailGroup.layout = horlayout;



        _total = new Button();
        _total.nameList.add("total");
        _total.iconPosition = Button.ICON_POSITION_LEFT;
        _detailGroup.addChild(_total);



        _people = new Button();
        _people.nameList.add("people");
        _people.iconPosition = Button.ICON_POSITION_LEFT;
        _detailGroup.addChild(_people);



        _addPerson = new Button();
        _addPerson.nameList.add("addPerson");
        _addPerson.label = "add";
        _addPerson.iconPosition = Button.ICON_POSITION_LEFT;
        _detailGroup.addChild(_addPerson);


    }

    private function updateTask(event:Event):void {

        if(_taskModel.currentTask) {

            _currentTask = _taskModel.currentTask;

            trace('Current Task:', _currentTask.title);
            _taskTitle.text = _currentTask.title;
            _dateTime.text = DateFormat.timestampToUFDate(_currentTask.timestamp as Number);
            _total.label = String(_currentTask.price);
            _addPerson.label = String(_personList.selectedItems.length);
            _type.defaultIcon = TaskService.icon(_currentTask);
            trace(_personModel.getPersonsByTaskId(_currentTask.id));
            trace(_currentTask.id);
            _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));


        }
    }

    override protected function initialize():void {
        scherm();
        trace('[DETAIL]');
    }


    private function scherm():void {

        _taskTitle.width = stage.stageWidth;
        _dateTime.width = stage.stageWidth;
        _taskLayout.setSize(stage.stageWidth, stage.stageHeight * 0.5);
        _personList.setSize(stage.stageWidth, (stage.stageHeight - _taskLayout.height));
        _personList.y = _taskLayout.height;
    }

}
}
