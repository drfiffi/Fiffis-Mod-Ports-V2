var shakeCam2:Bool = false;
var missNoteTimer:FlxTimer;
var camShakeTimer:FlxTimer;
var Static:FlxSprite;
var loadedMissStatic:Bool = false;

function onNoteCreation(e) {
	switch (e.noteType) {
		case 'Static Note':
		e.noteSprite = 'notes/StaticNote';
		e.noteScale = 0.73;
		e.mustHit = true;
		e.note.updateHitbox();
	}
}

function onPlayerMiss(e) {
	if (e.noteType == "Static Note") {
		FlxG.sound.play(Paths.sound('hitStatic'));
		health -= .3;
		shakeCam2 = true;
		if(camShakeTimer != null) camShakeTimer.cancel();
		camShakeTimer = new FlxTimer().start(0.8, function(tmr:FlxTimer){
			shakeCam2 = false;
			camShakeTimer = null;
		});

		if(!loadedMissStatic){
			loadedMissStatic = true;
			Static = new FlxSprite(0, 0);
			Static.frames = Paths.getSparrowAtlas('EXEAssets/hitStatic');
			Static.animation.addByPrefix('idle', 'staticANIMATION');
			Static.setGraphicSize(FlxG.width, FlxG.height);
			Static.screenCenter();
			Static.camera = camHUD;
			add(Static);
		} else {
			Static.alpha = 1;
		}
		Static.animation.play('idle');
		if(missNoteTimer != null) missNoteTimer.cancel();
		missNoteTimer = new FlxTimer().start(0.25, function(tmr:FlxTimer){
			Static.alpha = 0;
		});
	}
}

function update(){
	if(shakeCam2){
		FlxG.camera.shake(0.0025, 0.10);
	}
}