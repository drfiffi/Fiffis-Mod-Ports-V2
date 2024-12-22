import flixel.util.FlxTimer;
import flixel.text.FlxTextBorderStyle;

function create(){
    lyrics1 = new FlxText(0, downscroll ? FlxG.height/2 + 220 : FlxG.height/2 + 180, FlxG.width, '', 20);
    lyrics1.setFormat(Paths.font('cheri.ttf'), 30, 0xFFFFFFFF, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    lyrics1.camera = camHUD;
    add(lyrics1);

    lyrics2 = new FlxText(0, downscroll ? FlxG.height/2 + 180 : FlxG.height/2 + 220, FlxG.width, '', 20);
    lyrics2.setFormat(Paths.font('cheri.ttf'), 30, 0xFFFFFFFF, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    lyrics2.camera = camHUD;
    add(lyrics2);
}

function postUpdate(){
    lyrics1.screenCenter(FlxAxes.X);
    lyrics2.screenCenter(FlxAxes.X);
}

function onEvent(_){
    if(_.event.name == 'setLyrics'){
        switch(_.event.params[0]){
            case 'sing1':
                lyrics1.text = _.event.params[1];
                lyrics2.text = '';
            case 'sing2':
                lyrics2.text = _.event.params[1];
                lyrics2.screenCenter(FlxAxes.X);
            case 'yell':
                lyrics1.scale.set(2, 2);
                lyrics1.text = _.event.params[1];
                lyrics2.text = '';
                lyrics1.screenCenter(FlxAxes.X);
                curNotesTimer = new FlxTimer().start(0.1, function(timer){
                    lyrics1.scale.set(1, 1);
                    lyrics1.screenCenter(FlxAxes.X);
                });
            case 'done':
                for(i in [lyrics1, lyrics2]){
                    i.kill();
                    remove(i, true);
                }
        }
    }
}  