import openfl.Lib;
import openfl.system.Capabilities;
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.NativeAPI;
import openfl.net.NetConnection;

import openfl.text.TextFormat;
import openfl.text.TextField;
import funkin.backend.system.Main;
import funkin.backend.utils.DiscordUtil;

var userLoggedOn:String = '';

static var redirectStates:Map<FlxState, String> = [

];

function preStateSwitch(){
	FlxG.camera.bgColor = 0xFF000000;
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

/*
function postGameStart(){
	discordChecker = new TextField();
    discordChecker.defaultTextFormat = new TextFormat("_sans", 12, FlxColor.RED);
    discordChecker.x = 10;
    discordChecker.y = 130;
    discordChecker.selectable = false;
    discordChecker.width = 500;
    discordChecker.autoSize = 1;
    Main.instance.addChild(discordChecker);

	if(FlxG.save.data.streamableMusic == null) FlxG.save.data.streamableMusic = true;
}

function postUpdate(){
	keyPressed = FlxG.keys.pressed;
	keyJustPressed = FlxG.keys.justPressed;
	if (DiscordUtil.user != null) userLoggedOn = 'is';
	else userLoggedOn = 'is NOT';
	discordChecker.text = 'Discord ' + userLoggedOn + ' connected!';

	if(FlxG.keys.pressed.ALT && FlxG.keys.justPressed.A) FlxG.switchState(new ModState('CustomStates/ExeFreeplayState'));
	if(FlxG.keys.justPressed.L){
		FlxG.sound.music.stop();
		FlxG.sound.stream("https://ia803003.us.archive.org/3/items/CottonEyedJoeSong/Cotton%20Eyed%20Joe%20Song.ogg");
	}
}
*/