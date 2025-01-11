var useSteps:Bool = false;

function onEvent(_){
    switch (_.event.name){
        case 'Screen Shake':
            var valuesArray:Array<String> = [_.event.params[0], _.event.params[1]];
            var targetsArray:Array<FlxCamera> = [camGame, camHUD];
            for (i in 0...targetsArray.length) {
                var split:Array<String> = valuesArray[i].split(',');
                var duration:Float = 0;
                var intensity:Float = 0;
                if (split[0] != null) duration = Std.parseFloat(StringTools.trim(split[0]));
                if (split[1] != null) intensity = Std.parseFloat(StringTools.trim(split[1]));
                if (Math.isNaN(duration)) duration = 0;
                if (Math.isNaN(intensity)) intensity = 0;

                switch(_.event.params[2].toLowerCase()){
                    case "seconds": useSteps = false;
                    case "steps": useSteps = true;
                }

                if(duration > 0 && intensity != 0) {
                    targetsArray[i].shake(intensity, useSteps ? ((Conductor.stepCrochet / 1000) * duration) : duration);
                }
            }
    }
}