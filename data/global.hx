import openfl.Lib;
import openfl.system.Capabilities;
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.NativeAPI;

static var redirectStates:Map<FlxState, String> = [

];

function preStateSwitch(){
	FlxG.camera.bgColor = 0xFF000000;
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function update(){
	keyPressed = FlxG.keys.pressed;
	keyJustPressed = FlxG.keys.justPressed;

	if(keyPressed.L){
		if(keyJustPressed.ONE) FlxG.switchState(new ModState('PartyState'));
		if(keyJustPressed.TWO) FlxG.switchState(new ModState('HallibooTestState')); 
		if(keyJustPressed.THREE) FlxG.switchState(new ModState('DSBIOSState'));
	}

	if(FlxG.keys.pressed.ALT && FlxG.keys.justPressed.A) FlxG.switchState(new ModState('CustomStates/ExeFreeplayState'));
}