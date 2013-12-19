package be.devine.cp3.starling.billsplit.service {

import com.adobe.images.PNGEncoder;

import feathers.controls.ScrollContainer;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.media.Camera;
import flash.media.Video;
import flash.utils.ByteArray;
import starling.core.Starling;
import starling.events.Event;

public class PictureService extends ScrollContainer {
    private var _camera:Camera;
    private var _video:Video;
    public var bitmapData:BitmapData;
    private var _mask:Shape;
    private var _container:Sprite;

    public function PictureService() {
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void {
        _container = new Sprite();
        _container.graphics.beginFill(0xFFFFFF);
        _container.graphics.drawCircle(stage.stageWidth / 2, (stage.stageWidth * .75) / 2, 240);
        _container.graphics.endFill();
        _container.y = 100;
        Starling.current.nativeOverlay.addChild(_container);

        _mask = new Shape();
        _mask.graphics.beginFill(0xFF00FF);
        _mask.graphics.drawCircle(stage.stageWidth / 2, (stage.stageWidth * .75) / 2, 220);
        _mask.graphics.endFill();
        _mask.y = 100;
        _mask.cacheAsBitmap = true;

        _video = new Video(stage.stageWidth, stage.stageWidth * .75);
        _camera = Camera.getCamera();
        _camera.setQuality(0, 100);
        _camera.setMode(_video.width, _video.height, 30);
        _video.attachCamera(_camera);
        _video.mask = _mask;
        _video.cacheAsBitmap = true;
        _container.addChild(_video);
    }

    public function takePicture():String {
        _mask.y = 0;
        bitmapData = new BitmapData(_camera.width, _camera.height + 70, true, 0);
        bitmapData.draw(_container);
        _video.attachCamera(null);
        Starling.current.nativeOverlay.removeChild(_container);
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
