import flixel.camera.FlxCameraFollowStyle;

var lockOnSpeed:Float = 0.45;

function postCreate(){
    FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, lockOnSpeed);
}