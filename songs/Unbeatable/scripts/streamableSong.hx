var useMultimemberVocals:Bool = false;
var allowSongStart:Bool = false;

function create(){
    if(FlxG.save.data.streamableMusic){
        switch(SONG.meta.name){
            case 'Unbeatable':
                inst = FlxG.sound.stream("https://files.catbox.moe/sa6nbc.ogg", 0, false, true);
                if(!useMultimemberVocals){
                    vocals = FlxG.sound.stream("https://files.catbox.moe/sca0s8.ogg", 0, false, true);
                } else {
                    strumLines.members[0].vocals = FlxG.sound.stream(/*voices-opponent.ogg link*/);
                    strumLines.members[1].vocals = FlxG.sound.stream(/*voices-player.ogg link*/);
                }
            }
    } else {
        switch(SONG.meta.name){
            case 'Unbeatable':
                inst = FlxG.sound.load(Paths.file('songs/' + SONG.meta.name + '/song/Low Quality/Inst.ogg', null));
                if(!useMultimemberVocals){
                    vocals = FlxG.sound.load(Paths.file('songs/' + SONG.meta.name + '/song/Low Quality/Voices.ogg', null));
                } else {
                    strumLines.members[0].vocals = FlxG.sound.load(Paths.file('songs/' + SONG.meta.name + '/song/Low Quality/Voices-Opponent.ogg', null));
                    strumLines.members[1].vocals = FlxG.sound.load(Paths.file('songs/' + SONG.meta.name + '/song/Low Quality/Voices-Player.ogg', null));
                }
            }
    }
}

function onStartCountdown(_) if(FlxG.save.data.streamableMusic) _.cancelled = true;

function update(){
    if(FlxG.save.data.streamableMusic){
        if(inst.playing && vocals.playing){
            if(!allowSongStart){
                allowSongStart = true;
                startedCountdown = true;
            }
        }
    }
}

function postCreate(){
    if(FlxG.save.data.streamableMusic){
        paused = true;
        persistentUpdate = false;
        persistentDraw = true;
        openSubState(new ModSubState("LoadingStreamable"));
    }
}

function onSongStart(){
    if(FlxG.save.data.streamableMusic){
        inst.volume = 1;
        if(!useMultimemberVocals) vocals.volume = 1;
        else for(strumLine in 0...strumLines.members[0].length) strumLine.vocals.volume = 1;
    }
}