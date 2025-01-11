var rate:Int = 20;

function postCreate(){
    switch(SONG.meta.name){
        case 'too-slow' | 'endless' | 'cycles': rate = 15;
        case 'Deadly Steps': rate = 30;
        default: rate = 20;
    }
}

function postUpdate(){
    if(curCameraTarget == 0){
        switch(dad.getAnimName()){
            case 'singLEFT' | 'singLEFT-alt':   FlxG.camera.targetOffset.set(0 - rate, 0);
            case 'singDOWN' | 'singDOWN-alt':   FlxG.camera.targetOffset.set(0, 0 + rate);
            case 'singUP' | 'singUP-alt':       FlxG.camera.targetOffset.set(0, 0 - rate);
            case 'singRIGHT' | 'singRIGHT-alt': FlxG.camera.targetOffset.set(0 + rate, 0);
            case 'idle' | 'idle-alt':           FlxG.camera.targetOffset.set(0, 0);
        }
    } else {
        switch(boyfriend.getAnimName()){
            case 'singLEFT' | 'singLEFT-alt':   FlxG.camera.targetOffset.set(0 - rate, 0);
            case 'singDOWN' | 'singDOWN-alt':   FlxG.camera.targetOffset.set(0, 0 + rate);
            case 'singUP' | 'singUP-alt':       FlxG.camera.targetOffset.set(0, 0 - rate);
            case 'singRIGHT' | 'singRIGHT-alt': FlxG.camera.targetOffset.set(0 + rate, 0);
            case 'idle' | 'idle-alt':           FlxG.camera.targetOffset.set(0, 0);
        }
    }
}