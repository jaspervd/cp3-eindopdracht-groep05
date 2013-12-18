/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 18/12/13
 * Time: 12:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import com.adobe.images.JPGEncoder;
import com.adobe.images.PNGEncoder;

import feathers.controls.ScrollContainer;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.media.Camera;
import flash.media.Video;
import flash.net.FileReference;
import flash.utils.ByteArray;

import starling.core.Starling;
import starling.display.Image;

import flash.display.Sprite;

import starling.events.Event;

public class PictureService extends ScrollContainer {
    private var _camera:Camera;
    private var _video:Video;
    public var bitmapData:BitmapData;
    private var _mask:Shape;

    public function PictureService() {
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void {
        _mask = new Shape();
        _mask.graphics.beginFill(0xFF00FF);
        _mask.graphics.drawCircle(stage.stageWidth / 2, (stage.stageWidth * .75) / 2 + 100, 240);
        _mask.graphics.endFill();
        _mask.cacheAsBitmap = true;

        _video = new Video(stage.stageWidth, stage.stageWidth * .75);
        _camera = Camera.getCamera();
        _camera.setQuality(0, 100);
        _camera.setMode(_video.width, _video.height, 30);
        _video.attachCamera(_camera);
        _video.y = 100;
        _video.mask = _mask;
        _video.cacheAsBitmap = true;
        Starling.current.nativeOverlay.addChild(_video);
    }

    public function takePicture():String {
        bitmapData = new BitmapData(_camera.width, _camera.height);
        bitmapData.draw(_video);
        Starling.current.nativeOverlay.removeChild(_video);

        var pngEncoder:PNGEncoder = new PNGEncoder();
        var byteArray:ByteArray = PNGEncoder.encode(bitmapData);

        var date:Date = new Date();
        var url:String = "images/scr_" + date.time + ".png";
        var file:File = File.applicationStorageDirectory.resolvePath(url);
        var newFile:File = new File(file.nativePath);
        var stream:FileStream = new FileStream();
        stream.open(newFile, FileMode.WRITE);
        stream.writeBytes(byteArray, 0, byteArray.length);
        stream.close();

        return url;
    }
}
}
