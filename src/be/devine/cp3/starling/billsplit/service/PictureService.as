/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 18/12/13
 * Time: 12:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import com.adobe.images.JPGEncoder;

import feathers.controls.Button;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.media.Camera;
import flash.media.Video;
import flash.net.FileReference;
import flash.utils.ByteArray;

import starling.core.Starling;

import starling.events.Event;

public class PictureService extends Button {
    private var _camera:Camera;
    private var _video:Video;
    public var bitmapData:BitmapData;

    public function PictureService() {
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void {
        _video = new Video(stage.stageWidth, stage.stageWidth * .75);
        _camera = Camera.getCamera();
        _camera.setMode(_video.width, _video.height, 30);
        _video.attachCamera(_camera);
        Starling.current.nativeOverlay.addChild(_video);
    }

    public function takePicture():void {
        bitmapData = new BitmapData(_camera.width, _camera.height);
        bitmapData.draw(_video);

        var jpgEncoder:JPGEncoder = new JPGEncoder();
        var byteArray:ByteArray = jpgEncoder.encode(bitmapData);
        Starling.current.nativeOverlay.removeChild(_video);

        /*var fileReference:FileReference = new FileReference();
        fileReference.save(byteArray, "test1.jpg");*/

        trace('picture taken');


        /*var personsFile:File = File.applicationStorageDirectory.resolvePath("persons.json");
        var writeStream:FileStream = new FileStream();
        writeStream.open(personsFile, FileMode.WRITE);
        writeStream.writeUTFBytes(JSON.stringify(persons));
        writeStream.close();*/
    }
}
}
