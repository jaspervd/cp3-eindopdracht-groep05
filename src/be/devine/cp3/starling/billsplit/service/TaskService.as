/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 11/12/13
 * Time: 13:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.service {
import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;

import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class TaskService extends EventDispatcher {
    public var tasks:Array;

    public function load():void {
        var tasksFile:File = File.applicationStorageDirectory.resolvePath("tasks.json");
        if (!tasksFile.exists) {
            var writeStream:FileStream = new FileStream();
            writeStream.open(tasksFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([]));
            writeStream.close();
        }
        var readStream:FileStream = new FileStream();
        readStream.open(tasksFile, FileMode.READ);
        var str:String = readStream.readUTFBytes(readStream.bytesAvailable);
        var parsedJSON:Array = JSON.parse(str) as Array;
        readStream.close();
        var tasks:Array = [];
        for each(var task:Object in parsedJSON) {
            tasks.push(TaskVOFactory.createTaskVOFromObject(task));
        }
        this.tasks = tasks;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public static function write(tasks:Array):void {
        var tasksFile:File = File.applicationStorageDirectory.resolvePath("tasks.json");
        var writeStream:FileStream = new FileStream();
        writeStream.open(tasksFile, FileMode.WRITE);
        writeStream.writeUTFBytes(JSON.stringify(tasks));
        writeStream.close();
    }
}
}
