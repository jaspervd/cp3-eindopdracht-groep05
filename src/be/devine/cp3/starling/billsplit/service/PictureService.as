/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 18/12/13
 * Time: 12:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.media.Camera;
import flash.media.Video;

import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;

public class PictureService extends Sprite {
    private var _camera:Camera;
    private var _video:Video;
    public var screenShot:Bitmap;

    public function PictureService() {
    }

    public function init():void {
        _video = new Video(stage.stageWidth, stage.stageWidth * .75);
        _camera = Camera.getCamera();
        _camera.setMode(_video.width, _video.height, 30);
        _video.attachCamera(_camera);
        Starling.current.nativeOverlay.addChild(_video);
        addEventListener(TouchEvent.TOUCH, triggerHandler);
    }

    private function triggerHandler(event:Event):void {
        var screen:BitmapData = new BitmapData(_camera.width, _camera.height);
        screenShot = new Bitmap(screen);
        screen.draw(_video);
        dispatchEvent(new Event(TouchEvent.TOUCH));
    }
}
}
