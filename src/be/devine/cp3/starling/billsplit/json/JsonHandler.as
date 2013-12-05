/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 5/12/13
 * Time: 14:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.json {

public class JsonHandler {

    private var _tasks:Array;
    private var _persons:Array;
    private var _ious:Array;


    public function JsonHandler() {

        _tasks = [];
        _persons = [];
        _ious = [];

    }

    public function upadtePersons(persons:Array):void{

        if(_persons.length < 0){

            if(_persons != persons){

                _persons = persons;
            }

        }else{

            _persons = persons;
        }

    }

    public function upadteTasks(tasks:Array):void{

        if(_persons.length < 0){

            if(_persons != tasks){

                _persons = tasks;
            }

        }else{

            _persons = tasks;
        }

    }


    public function upadteIous(ious:Array):void{

        if(_ious.length < 0){

            if(_ious != ious){

                _ious = ious;
            }

        }else{

            _ious = ious;
        }

    }


    public function write():void{





    }




}
}
