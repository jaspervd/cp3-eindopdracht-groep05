/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 9/12/13
 * Time: 13:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.LayoutGroup;

import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.display.Image;
import starling.text.TextField;

public class Overview extends Screen {
    private var _personModel:PersonModel;
    private var _moderator:PersonVO;
    private var _profile:Image;
    private var _fullName:TextField;
    private var _profileLayout:LayoutGroup;

    public function Overview() {

        _personModel = PersonModel.getInstance();

        _moderator = _personModel.getModerator();


        _profileLayout = new LayoutGroup();
        addChild(_profileLayout);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _profileLayout.layout = layout;



        _fullName = new TextField(actualWidth,actualHeight,_moderator.name,null,28,0xffffff);
        _profileLayout.addChild(_fullName);


    }



    override protected function initialize():void{

        draw();
        trace('[OVERVIEW]');
    }


    override protected function draw():void{

        _profileLayout.setSize(stage.stageWidth,stage.stageHeight);

    }
}
}
