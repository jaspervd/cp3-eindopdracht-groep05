/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 11/12/13
 * Time: 13:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import be.devine.cp3.starling.billsplit.factory.IouVOFactory;

import starling.events.Event;`
import starling.events.EventDispatcher;
import flash.filesystem.File;

import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class IouService extends EventDispatcher {
    public var ious:Array;

    public function load():void {
        var iousFile:File = File.applicationStorageDirectory.resolvePath("ious.json");
        if (!iousFile.exists) {
            var writeStream:FileStream = new FileStream();
            writeStream.open(iousFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([]));
            writeStream.close();
        }
        var readStream:FileStream = new FileStream();
        readStream.open(iousFile, FileMode.READ);
        var str:String = readStream.readUTFBytes(readStream.bytesAvailable);
        var parsedJSON:Array = JSON.parse(str) as Array;
        readStream.close();
        var ious:Array = [];
        for each(var iou:Object in parsedJSON) {
            ious.push(IouVOFactory.createIouVOFromObject(iou));
        }
        this.ious = ious;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public static function write(ious:Array):void {
        var personsFile:File = File.applicationStorageDirectory.resolvePath("ious.json");
        var writeStream:FileStream = new FileStream();
        writeStream.open(personsFile, FileMode.WRITE);
        writeStream.writeUTFBytes(JSON.stringify(ious));
        writeStream.close();
    }
}
}
