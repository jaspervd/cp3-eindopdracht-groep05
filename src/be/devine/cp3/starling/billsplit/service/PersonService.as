/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 11/12/13
 * Time: 13:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import be.devine.cp3.starling.billsplit.factory.PersonVOFactory;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;

import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class PersonService extends EventDispatcher {
    public var persons:Array;

    public function load():void {
        var songsFile:File = File.applicationStorageDirectory.resolvePath("persons.json");
        if (!songsFile.exists) {
            var writeStream:FileStream = new FileStream();
            writeStream.open(songsFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([
                {
                    "id": 1,
                    "name": "Justin Timberlake",
                    "image": "url",
                    "task_id": 0,
                    "moderator": true
                }
            ]));
            writeStream.close();
        }
        var readStream:FileStream = new FileStream();
        readStream.open(songsFile, FileMode.READ);
        var str:String = readStream.readUTFBytes(readStream.bytesAvailable);
        var parsedJSON:Array = JSON.parse(str) as Array;
        readStream.close();
        var persons:Array = [];
        for each(var iou:Object in parsedJSON) {
            persons.push(PersonVOFactory.createPersonVOFromObject(iou));
        }
        this.persons = persons;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function write():void {

    }
}
}
