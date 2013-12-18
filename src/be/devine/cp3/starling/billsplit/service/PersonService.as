/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 11/12/13
 * Time: 13:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import be.devine.cp3.starling.billsplit.factory.PersonVOFactory;

import starling.events.Event;
import starling.events.EventDispatcher;
import flash.filesystem.File;

import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class PersonService extends EventDispatcher {
    public var persons:Array;

    public function load():void {
        var personsFile:File = File.applicationStorageDirectory.resolvePath("persons.json");
        if (!personsFile.exists) {
            var writeStream:FileStream = new FileStream();
            writeStream.open(personsFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([]));
            writeStream.close();
        }
        var readStream:FileStream = new FileStream();
        readStream.open(personsFile, FileMode.READ);
        var str:String = readStream.readUTFBytes(readStream.bytesAvailable);
        var parsedJSON:Array = JSON.parse(str) as Array;
        readStream.close();
        var persons:Array = [];
        for each(var person:Object in parsedJSON) {
            persons.push(PersonVOFactory.createPersonVOFromObject(person));
        }
        this.persons = persons;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public static function write(persons:Array):void {
        var personsFile:File = File.applicationStorageDirectory.resolvePath("persons.json");
        var writeStream:FileStream = new FileStream();
        writeStream.open(personsFile, FileMode.WRITE);
        writeStream.writeUTFBytes(JSON.stringify(persons));
        writeStream.close();
    }
}
}
