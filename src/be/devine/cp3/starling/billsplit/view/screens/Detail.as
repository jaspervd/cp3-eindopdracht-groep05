package be.devine.cp3.starling.billsplit.view.screens {


import be.devine.cp3.starling.billsplit.format.DateFormat;
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.view.popups.EditPerson;
import be.devine.cp3.starling.billsplit.view.popups.EditTask;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.core.PopUpManager;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.renderers.PersonListRenderer;
import feathers.renderers.TaskListRenderer;

import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;


public class Detail extends Screen {

    [Embed(source="/../assets/images/person_icon.png")]
    public static const Person:Class;


    [Embed(source="/../assets/images/person_add_icon.png")]
    public static const PersonAdd:Class;


    [Embed(source="/../assets/images/edit_big.png")]
    public static const Edit:Class;


    [Embed(source="/../assets/images/task_icon.png")]
    public static const Task:Class;


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
    private var _editTaskBtn:Button;
    private var _dateTime:TextField;
    private var _editPerson:EditPerson;
    private var _editTask:EditTask;

    public function Detail() {

        _appModel = AppModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();
        _currentTask = new TaskVO();

        _appModel.addEventListener(Event.CHANGE, updateTask);
        _personModel.addEventListener(Event.CHANGE, updateTask);

        _personList = new List();
        _personList.itemRendererType = PersonListRenderer;
        _personList.itemRendererProperties.gap = 1;
        _personList.itemRendererProperties.labelField = "label";
        _personList.itemRendererProperties.accessoryField = "accessory";
        _personList.addEventListener(Event.CHANGE, personEditPopUpHandler);
        addChild(_personList);


        /* _taskList = new List();
         _taskList.itemRendererType = TaskListRenderer;
         _taskList.itemRendererProperties.labelField = "title";
         _taskList.itemRendererProperties.accessoryField = "accessory";
         addChild(_taskList);*/

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
        _total.labelOffsetX = -15;
        _total.iconPosition = Button.ICON_POSITION_LEFT;
        _detailGroup.addChild(_total);


        _people = new Button();
        _people.labelOffsetX = -15;
        _people.nameList.add("people");
        _people.iconPosition = Button.ICON_POSITION_LEFT;
        _detailGroup.addChild(_people);


        _addPerson = new Button();
        _addPerson.nameList.add("addPerson");
        _addPerson.iconPosition = Button.ICON_POSITION_LEFT;
        _addPerson.addEventListener(Event.TRIGGERED, addPerson);
        _detailGroup.addChild(_addPerson);

        _editTaskBtn = new Button();
        //_editTask.nameList.add("editTask");
        _editTaskBtn.addEventListener(Event.TRIGGERED, editTaskHandler);
        _detailGroup.addChild(_editTaskBtn);
    }

    private function updateTask(event:Event):void {

        if (_taskModel.currentTask) {
            _currentTask = _taskModel.currentTask;

            _taskModel.totalPrice = _currentTask.price;

            _taskTitle.text = _currentTask.title;

            _dateTime.text = DateFormat.timestampToUFDate(_currentTask.timestamp as Number);

            _people.defaultIcon = Image.fromBitmap(new Person());
            _total.defaultIcon = Image.fromBitmap(new Task());
            _addPerson.defaultIcon = Image.fromBitmap(new PersonAdd());
            _editTaskBtn.defaultIcon = Image.fromBitmap(new Edit());

            calculateTotal();
            _total.label = "€" + String(_taskModel.totalPrice);

            _people.label = String(_personModel.getPersonsByTaskId(_currentTask.id).length);

            _type.defaultIcon = TaskService.icon(_currentTask);

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

    private function addPerson(event:Event):void {
        if (_taskModel.totalPrice > 0) {
            var person:Object = {};
            person.name = "person" + String(_personModel.getPersonsByTaskId(_currentTask.id).length + 1);
            person.image = "no Image";
            person.task_id = _currentTask.id;
            person.iou = 0;
            _personModel.add(person);

            /* var iou:Number = PriceFormat.calculatePrices(_currentTask.price,_personModel.getPersonsByTaskId(_currentTask.id));
             _personModel.updateIou(_currentTask.id,iou);*/

            PersonService.write(_personModel.persons);

            /*for each(var personVo:PersonVO in _personModel.persons){
             trace(personVo.iou);
             }*/
        }
    }

    private function calculateTotal():void {
        var total:Number = _taskModel.currentTask.price;
        for each(var person:PersonVO in _personModel.getPersonsByTaskId(_currentTask.id)) {
            total -= person.iou;
        } if(total < 0) {
            total = 0;
        }
        _taskModel.totalPrice = total;
    }


    private function editTaskHandler(event:Event):void {
        _editTask = new EditTask();
        _editTask.addEventListener(Event.CLOSE, closeTaskEditPopUpHandler);
        PopUpManager.addPopUp(_editTask);
    }

    private function closeTaskEditPopUpHandler(event:Event):void {
        PopUpManager.removePopUp(_editTask, true);
        if (_taskModel.getTask(_currentTask.id) == null) {
            _appModel.currentScreen = "overview";
        } else {
            updateTask(null);
        }
    }

    private function personEditPopUpHandler(event:Event):void {
        if (_personList.selectedItem) {
            _personModel.currentPerson = PersonVO(_personList.selectedItem);
            _editPerson = new EditPerson();
            _editPerson.addEventListener(Event.CLOSE, closePersonEditButtonHandler);
            PopUpManager.addPopUp(_editPerson);
        }
    }

    private function closePersonEditButtonHandler(event:Event):void {
        _personList.dataProvider = null;
        _personList.validate();
        _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));
        trace(_personModel.getPersonsByTaskId(_currentTask.id)[0].iou);
        PopUpManager.removePopUp(_editPerson, true);
    }
}
}
