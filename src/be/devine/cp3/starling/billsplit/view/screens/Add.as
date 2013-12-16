/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 12/12/13
 * Time: 16:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.model.AppModel;
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Radio;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.core.ToggleGroup;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class Add extends Screen {
    private var _addLayout:LayoutGroup;
    private var _inputTitle:TextInput;
    private var _inputPrice:TextInput;
    private var _submitBtn:Button;
    private var _appModel:AppModel;
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _group:ToggleGroup;
    private var _arrTypes:Array;

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
        var radioContainer:ScrollContainer = new ScrollContainer();
        radioContainer.layout = radioLayout;
        _addLayout.addChild(radioContainer);
        _group = new ToggleGroup();
        _arrTypes = ["other", "restaurant", "bar", "cinema"];

        for each(var type:String in _arrTypes) {
            var radio:Radio = new Radio();
            var taskVO:TaskVO = TaskVOFactory.createTaskVOFromObject({"type":type});
            radio.defaultIcon = TaskService.icon(taskVO);
            radio.iconPosition = "left";
            radio.toggleGroup = _group;
            if (type == "Other") {
                _group.selectedItem = radio;
            }
            radioContainer.addChild(radio);
        }

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

    override protected function initialize():void{

        trace('[HEADER]');

        draw();
    }

    override protected function draw():void{

        _addLayout.width = stage.stageWidth;

    }

    private function buttonHandler(event:Event):void {
        var error:Boolean = false;
        var moderator:PersonVO = _personModel.getModerator();

        var alert:Alert;

        if(_inputPrice.text.length == 0 && _inputTitle.text.length == 0){
             alert = Alert.show("Please fill in all textboxes",  moderator.name , new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }else  if (_inputPrice.text.length == 0) {
            alert = Alert.show("Please fill in a price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }else if (_inputTitle.text.length == 0) {
            alert = Alert.show("Please fill in a title", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }else  if (isNaN(_inputPrice.text as Number)) {
            alert = Alert.show("Please fill in a valid price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }


        if (!error) {
            var obj:Object = {};
            var radio:Radio = _group.selectedItem as Radio;
            obj.title = _inputTitle.text;
            obj.price = _inputPrice.text;
            obj.type = String(radio.label).toLowerCase();

            _taskModel.add(obj);
            TaskService.write(_taskModel.tasks);

            _taskModel.currentTask = _taskModel.tasks[_taskModel.tasks.length - 1];
            _appModel.currentScreen = "detail";
        }
    }
}
}
