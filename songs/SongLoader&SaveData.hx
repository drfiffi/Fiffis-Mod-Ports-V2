function onSongEnd(){
    switch(SONG.meta.name){
        case 'too-slow' | 'endless' | 'cycles' | 'My Horizon' | 'REROY' | 'Eye To Eye':
            FlxG.switchState(new ModState('CustomStates/ExeFreeplayState'));
        default:
            FlxG.switchState(new FreeplayState());
    }
}