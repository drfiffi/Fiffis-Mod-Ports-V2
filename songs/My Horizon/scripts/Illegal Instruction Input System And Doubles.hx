//OMG THANK YOU supergaymario !!!

public var judgements = [
    {
        window: 45,
        score: 300,
        accuracy: 1,
        name: "sick"
    },
    {
        window: 90,
        score: 200,
        accuracy: 0.75,
        name: "good"
    },
    {
        window: 135,
        score: 100,
        accuracy: 0.25,
        name: "bad"
    },
    {
        window: 160,
        score: 50,
        accuracy: 0,
        name: "shit"
    }
];

function onNoteCreation(e){
    e.note.earlyPressWindow = 0.65; // to make it easier to get a ghost note above the strums
}

function onPlayerHit(e)
{
    var noteDiff = Math.abs(Conductor.songPosition - e.note.strumTime);

    // monster of monsters code no way????
    // (i just ported it to softcode, since its originally hardcoded from the mod itself, original code by nebula) - syrup
    for(j in judgements)
    {
        if(noteDiff <= j.window)
        {
            e.rating = j.name;
            e.score = j.score;
            e.accuracy = j.accuracy;

            break;
        }
    }

        if ((e.rating == 'bad' || e.rating == 'shit') && !e.note.isSustainNote)
    {
        trace('got a bad/shit rating, resetting combo :/');

        e.preventDeletion();
        
        if (e.note.shader != null) e.note.shader = null;
        e.note.blend = 0;
        e.note.alpha = 0.6;

        combo = 0;
    }

    // fixes a lil issue
}

public var disableGhosts:Bool = false;

var data:Map<Int, {colors:Array<FlxColor>, lastNote:{time:Float, id:Int}}> = [];


function postCreate() {
    for (sl in strumLines.members)  data[strumLines.members.indexOf(sl)] = {
        colors: [for (character in sl.characters) character.iconColor != null ? character.iconColor : switch(sl.data.position) {
            default: 0xFFFF0000;
            case 'boyfriend': 0xFF00FFFF;
        }],

        lastNote: {
            time: -9999,
            id: -1
        }
    };
}

function onNoteHit(_) {
    if (_.note.isSustainNote) return;

    var target = data[strumLines.members.indexOf(_.note.strumLine)];
    var doDouble = (_.note.strumTime - target.lastNote.time) <= 1 && _.note.noteData != target.lastNote.id;
    target.lastNote.time = _.note.strumTime;
    target.lastNote.id = _.note.noteData;

    if(doDouble && !disableGhosts)
        for (character in _.characters)
            if (character.visible) doGhostAnim(character, target.colors[_.characters.indexOf(character)]).playAnim(character.getAnimName(), true);
}

function doGhostAnim(char:Character) {

    var trail:Character = new Character(char.x, char.y, char.curCharacter, char.isPlayer);
    insert(members.indexOf(char), trail);
    FlxTween.tween(trail, {alpha: 0}, .75).onComplete = function() {
        trail.kill();
        remove(trail, true);
    };
    return trail;
}