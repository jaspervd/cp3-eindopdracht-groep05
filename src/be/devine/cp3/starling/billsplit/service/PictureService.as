/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 18/12/13
 * Time: 12:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import com.adobe.images.JPGEncoder;

import feathers.controls.ScrollContainer;

import flash.display.BitmapData;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.media.Camera;
import flash.media.Video;
import flash.net.FileReference;
import flash.utils.ByteArray;

import starling.core.Starling;
import starling.display.Sprite;

import starling.events.Event;

public class PictureService extends ScrollContainer {
    private var _camera:Camera;
    private var _video:Video;
    public var bitmapData:BitmapData;
    private var _mask:Sprite;

    public function PictureService() {
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void {
        _video = new Video(stage.stageWidth, stage.stageWidth * .75);
        _camera = Camera.getCamera();
        _camera.setQuality(0, 100);
        _camera.setMode(_video.width, _video.height, 30);
        _video.attachCamera(_camera);
        _video.y = 100;
        Starling.current.nativeOverlay.addChild(_video);
    }

    public function takePicture():String {
        bitmapData = new BitmapData(_camera.width, _camera.height);
        bitmapData.draw(_video);

        var jpgEncoder:JPGEncoder = new JPGEncoder();
        var byteArray:ByteArray = jpgEncoder.encode(bitmapData);
        Starling.current.nativeOverlay.removeChild(_video);

        var date:Date = new Date();
        var url:String = "images/scr_" + date.time + ".jpg";
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
