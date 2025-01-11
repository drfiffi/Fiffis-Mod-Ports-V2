var shakeCam = false;

var stageDefaultZoom = 1.05;

var defaultStrumPositions = [];

function postCreate() {
	stageDefaultZoom = defaultCamZoom;

	for (strum in strumLines)
		for (note in strum)
			defaultStrumPositions.push({x: note.x, y: note.y});
}

function tweenCameraAndSetDefaultCamZoom(camera, zoom, duration, ?ease, ?onComplete)
	return FlxTween.tween(camera, {zoom: zoom}, duration, {ease: ease, onComplete: twn -> {
		defaultCamZoom = zoom;
		if (onComplete != null) onComplete(twn);
	}});

function stepHit(curStep) {
	switch(curStep) {
		case 760:
			tweenCameraAndSetDefaultCamZoom(camGame, 1.2, 0.5);
		case 765:
			shakeCam = true;
			FlxG.camera.flash(FlxColor.RED, 4);
		case 785:
			tweenCameraAndSetDefaultCamZoom(camGame, stageDefaultZoom, 0.5);
		case 791:
			// GYATT
			shakeCam = false;
		// not used even though it was in the modchart, lol????
		//case 1392:
		//	tweenCameraAndSetDefaultCamZoom(camGame, 1.2, 0.5);
		//case 1427:
		//	tweenCameraAndSetDefaultCamZoom(camGame, stageDefaultZoom, 0.5);
	}
}

function postUpdate(elapsed) {
	if (shakeCam)
		FlxG.camera.shake(0.005, 0.1);

	final case1 = curStep >= 789 && curStep < 924;
	final case2 = curStep >= 924 && curStep < 1049;
	final case3 = curStep >= 1049 && curStep < 1176;
	final case4 = curStep >= 1176 && curStep < 1959;

	final kadeBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 84);

	var i = 0;
	for (strum in strumLines) {
		for (note in strum) {
			if (note == null) continue;

			var realSpeed = Math.sin((kadeBeat + i * 0.25) * Math.PI);
			var defaultStrumPos = defaultStrumPositions[i];

				 if (case1) note.y = defaultStrumPos.y + 5 * realSpeed;
			else if (case2) note.y = defaultStrumPos.y - 5 * realSpeed;
			else if (case3) note.x = defaultStrumPos.x + 2 * realSpeed;
			else if (case4) note.x = defaultStrumPos.x - 6 * realSpeed;
			else note.setPosition(defaultStrumPos.x, defaultStrumPos.y);

			i++;
		}
	}
}