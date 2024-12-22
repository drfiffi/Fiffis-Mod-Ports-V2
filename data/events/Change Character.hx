import funkin.game.Character;

var charList:Array<Map<String, Character>> = [];

var opponentMode:Bool = false;

function postCreate() {
    strumLines.forEach(function(strLine)
    {
        var charThing:Map<String, Character> = [];
        for(char in strLine.characters)
        {
            charThing.set(char.curCharacter, char);
        }
        charList.push(charThing);
    });
    for (event in PlayState.SONG.events){
        if(event.name == "Change Character"){
            if (!charList[event.params[0]].exists(event.params[2])){
                trace(strumLines.members[event.params[0]].opponentSide);
                var daChar = new Character(strumLines.members[event.params[0]].characters[0].x, strumLines.members[event.params[0]].characters[0].y, event.params[2], !strumLines.members[event.params[0]].opponentSide);
                daChar.visible = false;
                daChar.drawComplex(FlxG.camera); // Push to GPU
                daChar.visible = true;
                charList[event.params[0]].set(event.params[2], daChar);
            }
        }
    }
    for (thing in charList)
        trace(thing);
}

function onEvent(daEvent) {
    if (daEvent.event.name == "Change Character") {
        remove(strumLines.members[daEvent.event.params[0]].characters[daEvent.event.params[1]]);
        strumLines.members[daEvent.event.params[0]].characters[daEvent.event.params[1]] = charList[daEvent.event.params[0]].get(daEvent.event.params[2]);
        insert(members.indexOf(boyfriend) - 1, strumLines.members[daEvent.event.params[0]].characters[daEvent.event.params[1]]);
        if(daEvent.event.params[0] < 2 && daEvent.event.params[1] == 0)
            if(SONG.meta.name != 'REROY')
                updateHealthBarColors();
    }
}
    
function updateHealthBarColors() {
    iconP1.setIcon(boyfriend != null ? boyfriend.getIcon() : "face");
    iconP2.setIcon(dad != null ? dad.getIcon() : "face");

    var leftColor:Int = dad != null && dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : (opponentMode ? 0xFF66FF33 : 0xFFFF0000);
    var rightColor:Int = boyfriend != null && boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : (opponentMode ? 0xFFFF0000 : 0xFF66FF33); // switch the colors
    healthBar.createFilledBar(leftColor, rightColor);
}