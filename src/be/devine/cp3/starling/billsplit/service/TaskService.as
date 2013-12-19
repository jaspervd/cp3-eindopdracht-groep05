package be.devine.cp3.starling.billsplit.service {


import be.devine.cp3.starling.billsplit.factory.TaskVOFactory;
import be.devine.cp3.starling.billsplit.vo.TaskVO;
import starling.events.Event;
import starling.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import starling.display.Image;


public class TaskService extends EventDispatcher {


    [Embed(source="/../assets/images/metalworks/bar.png")]
    public static const BarIcon:Class;

    [Embed(source="/../assets/images/metalworks/restaurant.png")]
    public static const ResIcon:Class;

    [Embed(source="/../assets/images/metalworks/cinema.png")]
    public static const CinemaIcon:Class;

    [Embed(source="/../assets/images/metalworks/overige.png")]
    public static const OtherIcon:Class;

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


    public static function icon(task:TaskVO):Image{

        var img:Image;

        switch(task.type) {
            case 'restaurant':
                img = Image.fromBitmap(new ResIcon());
                break;
            case 'cinema':
                img = Image.fromBitmap(new CinemaIcon());
                break;
            case 'bar':
                img = Image.fromBitmap(new BarIcon());
                break;
            default:
                img = Image.fromBitmap(new OtherIcon());
                break;
        }

        return img;

    }
}
}
