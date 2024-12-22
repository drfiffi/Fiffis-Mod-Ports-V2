var rate:Float = 20;

var boyfriendPosition = [1026, 696.5];
var dadPosition = [510.5, 662];

var timeAmount:Float = 0.35;

var camType:Int = 0;

var returnTimer = new FlxTimer();

var camZoomTween:FlxTween;
var camPosTween:FlxTween;

function onEvent(_){
    switch (_.event.name){
        case "Reroy Events":
            switch(_.event.params[0]){
                case 'Set Camera Position (A)': camFollow.setPosition(_.event.params[1], _.event.params[2]);
                case 'Tween Camera Zoom (B)':
                    if(camZoomTween != null) camZoomTween.cancel();
                    camZoomTween = FlxTween.tween(this, {defaultCamZoom: _.event.params[1]}, _.event.params[3], {ease: FlxEase.sineOut});
                case 'Tween Camera Position (C)':
                    if(camPosTween != null) camPosTween.cancel();
                    camPosTween = FlxTween.tween(camFollow, {x: _.event.params[1], y: _.event.params[2]}, _.event.params[3], {ease: FlxEase.sineInOut});
                case 'Camera Focus Change (D)':
                    switch(_.event.params[1]){
                        case 'dad' | '0':
                            curCameraTarget = 0;
                            trace('Dad Cam');
                        case 'bf' | 'boyfriend' | '1':
                            curCameraTarget = 1;
                            trace('BF Cam');
                    }
            }
        case "Camera Movement":
            if(_.event.params[0] == 0) camFollow.setPosition(dadPosition[0], dadPosition[1]);
            if(_.event.params[0] != 0) camFollow.setPosition(boyfriendPosition[0], boyfriendPosition[1]);
    }
}

function create() camFollow.setPosition(dadPosition[0], dadPosition[1]);

function onCameraMove(e) e.cancel();

function onPlayerHit(_) {
    if(curCameraTarget != 0) {
        if(returnTimer != null) returnTimer.cancel();
        returnTimer = new FlxTimer().start(timeAmount, function(timer){
            FlxG.camera.targetOffset.set(0, 0);
        });

        moveCameraOnNotes(_.direction);
    }
}

function onDadHit(_) {
    if(curCameraTarget == 0) {
        if(returnTimer != null) returnTimer.cancel();
        returnTimer = new FlxTimer().start(timeAmount, function(timer){
            FlxG.camera.targetOffset.set(0, 0);
        });

        moveCameraOnNotes(_.direction);
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