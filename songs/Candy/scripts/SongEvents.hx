function SongEvent(eventName){
    switch(eventName){
        case '0':
            for (i in 0...strumLines.members[0].length){
                strumLines.members[1].members[i].visible = true;
            }
        case '1':
            for (i in 0...strumLines.members[0].length){
                FlxTween.tween(strumLines.members[2].members[i], {y: 50}, (Conductor.stepCrochet / 250) * 2, {ease: FlxEase.elasticOut});
            }
        case 'gameOff':
            camGame.alpha = 0;
        case 'gameOn':
            camGame.alpha = 1;
        case 'allOff':
            camGame.alpha = 0;
            for (i in 0...strumLines.members[0].length){
                strumLines.members[1].members[i].visible = false;
                strumLines.members[2].members[i].visible = false;
            }
        case 'allOn':
            camGame.alpha = 1;
            for (i in 0...strumLines.members[0].length){
                strumLines.members[1].members[i].visible = true;
                strumLines.members[2].members[i].visible = true;
            }
    }
}