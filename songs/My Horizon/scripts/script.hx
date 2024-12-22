function camoffsetshit(lol:String) {
	switch (lol) {
		case 'a':
			FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.quadOut});
			for (tag => sprite in stage.stageSprites) {
				if (!StringTools.startsWith(tag, 'spooky')) {
					FlxTween.tween(sprite, {alpha: 0.001}, 1, {ease: FlxEase.quadOut});
				}
			}
			case 'c':
			camHUD.flash();
			camHUD.alpha = 1;
			for (tag => sprite in stage.stageSprites) {
				if (StringTools.startsWith(tag, 'spooky') || tag == 'fg1' || tag == 'fg2') {
					sprite.alpha = 1;
				}
			}
	}
}