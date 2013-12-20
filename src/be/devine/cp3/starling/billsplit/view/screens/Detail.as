package be.devine.cp3.starling.billsplit.view.screens {


import be.devine.cp3.starling.billsplit.format.DateFormat;
import be.devine.cp3.starling.billsplit.format.PriceFormat;
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.view.popups.EditPerson;
import be.devine.cp3.starling.billsplit.view.popups.EditTask;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import feathers.controls.Alert;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.ToggleSwitch;
import feathers.core.PopUpManager;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.renderers.PersonListRenderer;

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
    private var _taskTitle:TextField;
    private var _currentTask:TaskVO;
    private var _type:Button;
    private var _total:Button;
    private var _addPerson:Button;
    private var _editTaskBtn:Button;
    private var _dateTime:TextField;
    private var _editPerson:EditPerson;
    private var _editTask:EditTask;
    private var _toggleSwitch:ToggleSwitch;

    public function Detail() {

        _appModel = AppModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();
        _currentTask = new TaskVO();

        _taskModel.addEventListener(TaskModel.CURRENT_TASK_SET, currentTaskSetHandler);

        _personList = new List();
        _personList.itemRendererType = PersonListRenderer;
        _personList.itemRendererProperties.gap = 1;
        _personList.itemRendererProperties.labelField = "label";
        _personList.itemRendererProperties.accessoryField = "accessory";
        _personList.addEventListener(Event.CHANGE, personEditPopUpHandler);
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

        var detailGroup:LayoutGroup = new LayoutGroup();
        _taskLayout.addChild(detailGroup);

        var horlayout:HorizontalLayout = new HorizontalLayout();
        horlayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
        horlayout.gap = 20;
        detailGroup.layout = horlayout;

        _total = new Button();
        _total.nameList.add("total");
        _total.labelOffsetX = -15;
        _total.iconPosition = Button.ICON_POSITION_LEFT;
        detailGroup.addChild(_total);

        _addPerson = new Button();
        _addPerson.nameList.add("addPerson");
        _addPerson.iconPosition = Button.ICON_POSITION_LEFT;
        _addPerson.addEventListener(Event.TRIGGERED, addPerson);
        detailGroup.addChild(_addPerson);

        _editTaskBtn = new Button();
        _editTaskBtn.addEventListener(Event.TRIGGERED, editTaskHandler);
        detailGroup.addChild(_editTaskBtn);

        _toggleSwitch = new ToggleSwitch();
        _toggleSwitch.onText = "€";
        _toggleSwitch.offText = "%";
        _toggleSwitch.isSelected = true;
        _toggleSwitch.addEventListener(Event.CHANGE, toggleHandler);
        detailGroup.addChild(_toggleSwitch);

        var divideEvenBtn:Button = new Button();
        divideEvenBtn.label = "50/50";
        divideEvenBtn.addEventListener(Event.TRIGGERED, divideHandler);
        detailGroup.addChild(divideEvenBtn);
    }

    private function currentTaskSetHandler(event:Event):void {
        _personModel.addEventListener(Event.CHANGE, updateTask);
        _currentTask = _taskModel.currentTask;
        updateTask(null);
    }

    private function toggleHandler(event:Event):void {
        _taskModel.currency = _toggleSwitch.isSelected;
        var newArr:Array = [];
        for each(var person:PersonVO in _personModel.getPersonsByTaskId(_currentTask.id)) {
            if (_toggleSwitch.isSelected) {
                person.label = person.name + "  -  € " + Number(person.iou);
            } else {
                person.percentage = PriceFormat.priceToPercentage(person.iou, _currentTask.price);
                person.label = person.name + "  -  " + Number(person.percentage) + " %";
            }
            newArr.push(person);
        }

        _personList.dataProvider = null;
        _personList.validate();
        _personList.dataProvider = new ListCollection(newArr);
    }

    private function divideHandler(event:Event):void {
        var iou:Number = PriceFormat.calculatePricesEvenly(_currentTask.price, _personModel.getPersonsByTaskId(_currentTask.id).length);
        _personModel.updateIou(_currentTask.id, iou);

        _personList.dataProvider = null;
        _personList.validate();
        _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));
        updateTask(null);
    }

    private function updateTask(event:Event):void {
        _taskModel.totalPrice = _currentTask.price;

        _taskTitle.text = _currentTask.title;

        _dateTime.text = DateFormat.timestampToUFDate(_currentTask.timestamp as Number);

        _total.defaultIcon = Image.fromBitmap(new Task());
        _addPerson.defaultIcon = Image.fromBitmap(new PersonAdd());
        _editTaskBtn.defaultIcon = Image.fromBitmap(new Edit());

        calculateTotal();
        _total.label = "€" + String(_taskModel.totalPrice.toFixed(2));

        _type.defaultIcon = TaskService.icon(_currentTask);

        _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));
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

            _personList.dataProvider = null;
            _personList.validate();
            _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));

            PersonService.write(_personModel.persons);
        } else {
            var alert:Alert = Alert.show("You can only add a person if the total is greater than zero.", "Notice", new ListCollection([
                { label: "OK" }
            ]));
        }
    }

    private function calculateTotal():void {
        var total:Number = _taskModel.currentTask.price;
        for each(var person:PersonVO in _personModel.getPersonsByTaskId(_currentTask.id)) {
            total -= person.iou;
        }
        if (total < 0) {
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
        }
        updateTask(null);
        toggleHandler(null);
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
        updateTask(null);
        toggleHandler(null);

        _personList.dataProvider = null;
        _personList.validate();
        _personList.dataProvider = new ListCollection(_personModel.getPersonsByTaskId(_currentTask.id));
        PopUpManager.removePopUp(_editPerson, true);
    }
}
}
