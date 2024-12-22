function onEvent(_){
    if (_.event.name == 'setProperty') {
        var types = switch(_.event.params[1]){
            case 'alpha': _.event.params[0].alpha = _.event.params[2];
            case 'visible': _.event.params[0].visible = _.event.params[2];
            case 'x': _.event.params[0].x = _.event.params[2];
            case 'y': _.event.params[0].y = _.event.params[2];
        };
    }
}