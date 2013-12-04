package {

import be.devine.cp3.starling.billsplit.Application;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;

[SWF(frameRate=60)]
public class Main extends Sprite {
    private var _starling:Starling;

    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        _starling = new Starling(Application, stage);
        _starling.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:flash.events.Event):void {
        _starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;
        _starling.stage.dispatchEvent(new starling.events.Event(starling.events.Event.RESIZE));
    }
}
}
