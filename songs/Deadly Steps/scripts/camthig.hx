var rate = 30;

import flixel.camera.FlxCameraFollowStyle;

var timeAmount:Float = 0.35;
var lockOnSpeed:Float = 0.45;

var returnTimer = new FlxTimer();
var enabled:Bool = true;

function onCameraMove(e) e.cancel();

function onEvent(_){
    switch (_.event.name){
        case "Camera Movement":
            if(_.event.params[0] == 0) camFollow.setPosition(dad.getCameraPosition().x, dad.getCameraPosition().y);
            if(_.event.params[0] != 0) camFollow.setPosition(boyfriend.getCameraPosition().x, boyfriend.getCameraPosition().y);
            FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, 0.1);
            enabled = false;
            returnTimer = new FlxTimer().start((Conductor.stepCrochet / 1000) * 5, function(timer){
                enabled = true;
                FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, lockOnSpeed);
            });
            
    }
}

function postCreate(){
    camFollow.setPosition(dad.getCameraPosition().x, dad.getCameraPosition().y);
    FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, lockOnSpeed);
}

function onNoteHit(_) {
    if(enabled){
        if(_.player){
            if(curCameraTarget != 0) {
                if(returnTimer != null) returnTimer.cancel();
                returnTimer = new FlxTimer().start(timeAmount, function(timer) FlxG.camera.targetOffset.set(0, 0));
                moveCameraOnNotes(_.direction);
            }
        }
        if(!_.player){
            if(curCameraTarget == 0) {
                if(returnTimer != null) returnTimer.cancel();
                returnTimer = new FlxTimer().start(timeAmount, function(timer) FlxG.camera.targetOffset.set(0, 0));
                moveCameraOnNotes(_.direction);
            }
        }
    }

}

function moveCameraOnNotes(noteDirection) {
    switch(noteDirection){
        case 0: FlxG.camera.targetOffset.set(0 - rate, 0);
        case 1: FlxG.camera.targetOffset.set(0, 0 + rate);
        case 2: FlxG.camera.targetOffset.set(0, 0 - rate);
        case 3: FlxG.camera.targetOffset.set(0 + rate, 0);
    }
}