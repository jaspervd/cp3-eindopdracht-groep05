/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 12/12/13
 * Time: 16:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {


import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.controls.ToggleSwitch;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.renderers.TypesListRenderer;
import starling.events.Event;

public class Add extends Screen {
    private var _addLayout:LayoutGroup;
    private var _inputTitle:TextInput;
    private var _inputPrice:TextInput;
    private var _submitBtn:Button;
    private var _appModel:AppModel;
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _typesList:List;
    private var _toggle:ToggleSwitch;

    public function Add() {


        _appModel = AppModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();

        _addLayout = new LayoutGroup();
        addChild(_addLayout);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _addLayout.layout = layout;

        var radioLayout:HorizontalLayout = new HorizontalLayout();
        radioLayout.gap = 30;

        _typesList = new List();
        _typesList.layout = radioLayout;
        _typesList.itemRendererType = TypesListRenderer;
        _addLayout.addChild(_typesList);

        _typesList.dataProvider = new ListCollection([
            {"type": "other"},
            {"type": "restaurant"},
            {"type": "bar"},
            {"type": "cinema"}
        ]);
        _typesList.addEventListener(Event.TRIGGERED, selectedButton);
        _typesList.selectedIndex = 0;

        _inputTitle = new TextInput();
        _inputTitle.prompt = "Title";
        _addLayout.addChild(_inputTitle);

        _inputPrice = new TextInput();
        _inputPrice.prompt = "Price";
        _inputPrice.restrict = "0-9.,";
        _addLayout.addChild(_inputPrice);

        _submitBtn = new Button();
        _submitBtn.label = "Save";
        _addLayout.addChild(_submitBtn);

        _submitBtn.addEventListener(Event.TRIGGERED, buttonHandler);
    }

    override protected function initialize():void {

        trace('[HEADER]');

        draw();
    }

    override protected function draw():void {

        _addLayout.width = stage.stageWidth;

    }

    private function buttonHandler(event:Event):void {
        var error:Boolean = false;
        var moderator:PersonVO = _personModel.getModerator();

        var alert:Alert;

        if (_inputPrice.text.length == 0 && _inputTitle.text.length == 0) {
            alert = Alert.show("Please fill in all textboxes", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_inputPrice.text.length == 0) {
            alert = Alert.show("Please fill in a price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_inputTitle.text.length == 0) {
            alert = Alert.show("Please fill in a title", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (isNaN(_inputPrice.text as Number)) {
            alert = Alert.show("Please fill in a valid price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }


        if (!error) {
            var taskObj:Object = {};
            taskObj.title = _inputTitle.text;
            taskObj.price = _inputPrice.text.split(',').join('.');
            taskObj.type = _typesList.selectedItem.type;

            _taskModel.currency = _toggle.isSelected;

            _taskModel.add(taskObj);
            TaskService.write(_taskModel.tasks);

            _taskModel.currentTask = _taskModel.tasks[_taskModel.tasks.length - 1];

            var personObj:Object = {};
            personObj.name = moderator.name;
            personObj.image = moderator.image;
            personObj.task_id = _taskModel.currentTask.id;
            personObj.label = personObj.name + "  -  € " + taskObj.price;
            _personModel.add(personObj);
            trace(personObj);
            trace(_personModel.persons);
            PersonService.write(_personModel.persons);

            _inputTitle.text = _inputPrice.text = "";

            _appModel.currentScreen = "detail";
        }
    }

    private function toggleHandler(event:Event):void {

        trace(_toggle.isSelected);
    }

    private function selectedButton(event:Event):void {

        trace("UPDATE TYPES");
        var _dataLen:int = _typesList.dataProvider.length;
        for(var i:int = 0; i < _dataLen; i++) {
            trace(_typesList.dataProvider.updateItemAt(i));
        }

    }
}
}
