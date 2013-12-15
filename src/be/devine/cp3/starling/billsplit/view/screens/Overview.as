/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 9/12/13
 * Time: 13:41
 * To change this template use File | Settings | File Templates.
 */
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
import flash.filesystem.File;

import starling.core.Starling;

import starling.display.MovieClip;
import starling.display.Sprite;

import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;


public class Overview extends Screen {


    private var _personModel:PersonModel;
    private var _taskModel:TaskModel;
    private var _appmodel:AppModel;
    private var _moderator:PersonVO;
    private var _tasks:Array;
    private var _profile:ImageLoader;
    private var _fullName:TextField;
    private var _profileLayout:LayoutGroup;
    private var _taskList:List;
    private var _layout:VerticalLayout;



    [Embed(source="/../assets/images/circle_mask.png")]
    private var CircleMask:Class;

    public function Overview() {

        _personModel = PersonModel.getInstance();
        _taskModel = TaskModel.getInstance();
        _appmodel = AppModel.getInstance();
        _moderator = _personModel.getModerator();
        _tasks = _taskModel.getAllTasks();






        _profileLayout = new LayoutGroup();
        addChild(_profileLayout);

        _taskList = new List();
        _taskList.itemRendererProperties.labelField = "title";
        addChild(_taskList);






        _layout = new VerticalLayout();
        _layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        _layout.gap = 15;
        _profileLayout.layout = _layout;


        var image:File = File.applicationStorageDirectory.resolvePath(_moderator.image);
        _profile = new ImageLoader();
        _profile.source = image.url;
        _profile.addEventListener(Event.COMPLETE, imageCompleteHandler);
        mask();
        _profileLayout.addChild(_profile);


        _fullName = new TextField(100, 30, _moderator.name, "SourceSansProSemiBold", 28, 0xFFFFFF);
        _profileLayout.addChild(_fullName);

        this.backButtonHandler = onBack;

    }

    private function onBack():void{
        trace("on back");
    }

    private function imageCompleteHandler(event:Event):void {

        _profile.setSize(stage.stageWidth*0.3,stage.stageWidth*0.3);

    }


    override protected function initialize():void {
        layout();
        trace('[OVERVIEW]');
    }


    private function layout():void {


        _layout.paddingTop = stage.stageHeight*0.1;
        _fullName.width = stage.stageWidth*0.5;

        _profileLayout.setSize(stage.stageWidth, stage.stageHeight/2);
        _profile.x = (stage.stageWidth + _profile.width) / 2;
        _taskList.setSize(stage.stageWidth, (stage.stageHeight - _profileLayout.height));
        _taskList.y = _profileLayout.height;
        _taskList.dataProvider = new ListCollection(_tasks);
        _taskList.itemRendererProperties.gap = 1;
        _taskList.addEventListener( Event.CHANGE, triggeredHandler );


    }

    private function mask():void{

        

    }

    private function triggeredHandler(event:Event):void {

        if(_taskList.selectedItem){
            var listItem:TaskVO = TaskVO(_taskList.selectedItem);

            _taskModel.currentTask = listItem;
            _appmodel.currentScreen = "detail";

        }

    }
}
}
