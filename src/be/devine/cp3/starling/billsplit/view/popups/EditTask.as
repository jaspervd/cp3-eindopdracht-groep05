/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 19/12/13
 * Time: 16:02
 * To change this template use File | Settings | File Templates.
 */
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

import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class EditTask extends Screen {
    private var _taskModel:TaskModel;
    private var _personModel:PersonModel;
    private var _popupLayout:LayoutGroup;
    private var _titleInput:TextInput;
    private var _priceInput:TextInput;
    private var _buttonLayout:LayoutGroup;
    private var _saveButton:Button;
    private var _deleteButton:Button;
    private var _currentTask:TaskVO;

    public function EditTask() {
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
        _popupLayout.addChild(_priceInput);

        _buttonLayout = new LayoutGroup();
        _buttonLayout.layout = new HorizontalLayout();
        _popupLayout.addChild(_buttonLayout);

        _saveButton = new Button();
        _saveButton.label = "Save";
        _saveButton.addEventListener(Event.TRIGGERED, saveButtonHandler);
        _buttonLayout.addChild(_saveButton);

        _deleteButton = new Button();
        _deleteButton.label = "Delete";
        _deleteButton.addEventListener(Event.TRIGGERED, deleteButtonHandler);
        _buttonLayout.addChild(_deleteButton);

        if(_taskModel.currentTask != null) {
            _currentTask = _taskModel.currentTask;
            _titleInput.text = _currentTask.title;
            _priceInput.text = String(_currentTask.price);
        }
    }

    private function deleteButtonHandler(event:Event):void {
        _taskModel.deleteById(_currentTask.id);
        _personModel.deletePersonsByTaskId(_currentTask.id);
        TaskService.write(_taskModel.tasks);
        TaskService.write(_personModel.persons);
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
