package be.devine.cp3.starling.billsplit.view.popups {

import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.model.TaskModel;
import be.devine.cp3.starling.billsplit.service.PersonService;
import be.devine.cp3.starling.billsplit.service.TaskService;
import be.devine.cp3.starling.billsplit.vo.PersonVO;
import be.devine.cp3.starling.billsplit.vo.TaskVO;
import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.display.Quad;
import starling.events.Event;


public class EditTask extends ScrollContainer {
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _popupLayout:LayoutGroup;
    private var _titleInput:TextInput;
    private var _priceInput:TextInput;
    private var _currentTask:TaskVO;
    private var _container:Quad;

    public function EditTask() {
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        _container = new Quad(400, 500, 0x5b7f73);
        this.backgroundSkin = _container;

        _taskModel = TaskModel.getInstance();
        _personModel = PersonModel.getInstance();

        _popupLayout = new LayoutGroup();
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.gap = 15;
        layout.paddingTop = 100;
        _popupLayout.layout = layout;
        addChild(_popupLayout);

        _titleInput = new TextInput();
        _popupLayout.addChild(_titleInput);

        _priceInput = new TextInput();
        _priceInput.restrict = "0-9.,";
        _popupLayout.addChild(_priceInput);

        var buttonLayout:LayoutGroup = new LayoutGroup();
        buttonLayout.layout = new HorizontalLayout();
        _popupLayout.addChild(buttonLayout);

        var saveButton:Button = new Button();
        saveButton.label = "Save";
        saveButton.addEventListener(Event.TRIGGERED, saveButtonHandler);
        buttonLayout.addChild(saveButton);

        var deleteButton:Button = new Button();
        deleteButton.label = "Delete";
        deleteButton.addEventListener(Event.TRIGGERED, deleteButtonHandler);
        buttonLayout.addChild(deleteButton);

        _taskModel.addEventListener(TaskModel.CURRENT_TASK_SET, currentTaskSetHandler);
        if (_taskModel.currentTask != null) {
            _currentTask = _taskModel.currentTask;
            _titleInput.text = _currentTask.title;
            _priceInput.text = String(_currentTask.price);
        }
    }

    private function currentTaskSetHandler(event:TaskModel):void {
        _currentTask = _taskModel.currentTask;
        _titleInput.text = _currentTask.title;
        _priceInput.text = String(_currentTask.price);
    }

    private function addedToStageHandler(event:Event):void {
        _container.width = stage.stageWidth * .85;
        _container.height = stage.stageHeight * .3;
        _popupLayout.x = (_container.width - _popupLayout.width) / 4;
        _popupLayout.y = (_container.height - _popupLayout.height) / 4;
    }

    private function deleteButtonHandler(event:Event):void {
        _taskModel.deleteById(_currentTask.id);
        _personModel.deletePersonsByTaskId(_currentTask.id);
        TaskService.write(_taskModel.tasks);
        PersonService.write(_personModel.persons);
        dispatchEvent(new Event(Event.CLOSE));
    }

    private function saveButtonHandler(event:Event):void {
        var error:Boolean = false;
        var moderator:PersonVO = _personModel.getModerator();

        var alert:Alert;

        if (_titleInput.text.length == 0 && _priceInput.text.length == 0) {
            alert = Alert.show("Please fill in all textboxes", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_titleInput.text.length == 0) {
            alert = Alert.show("Please fill in a title", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (_priceInput.text.length == 0) {
            alert = Alert.show("Please fill in a price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        } else if (isNaN(_priceInput.text as Number)) {
            alert = Alert.show("Please fill in a valid price", moderator.name, new ListCollection([
                { label: "OK" }
            ]));
            error = true;
        }

        if (!error) {
            var taskObj:Object = {};
            taskObj.title = _titleInput.text;
            taskObj.price = _priceInput.text;
            _taskModel.updateTask(_currentTask, taskObj);
            TaskService.write(_taskModel.tasks);

            _titleInput.text = _priceInput.text = "";
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
}
