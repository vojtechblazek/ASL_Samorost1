//Samorost 1 Auto Splitter by vojtechblazek
//version 1.2.0, date 7. 9. 2024
//Fixes: Fixed autosplitter not working while resetting the game at the incorrect time, wihch was a small window.
state("Samorost1"){
    uint Value: "Adobe AIR.dll", 0x00DCD3B8, 0xCFC, 0x4, 0x1B4, 0x1C, 0x99C;
    uint Start: "Adobe AIR.dll", 0xDCBDA0; //It's a direct adress, why it works, don't ask me
}

startup{
    vars.SetChecker = 1;
    vars.isTiming = false;

    settings.Add("MAIN", true, "Splits");
        settings.Add("Tree1", true, "Levels", "MAIN");
            settings.Add("LEVEL1", true, "Skiing Hill", "Tree1");
            settings.Add("LEVEL2", true, "Fishing Rock", "Tree1");
            settings.Add("LEVEL3", true, "Bee Rock", "Tree1");
            settings.Add("LEVEL4", true, "Worm Tree", "Tree1");
            settings.Add("LEVEL5", true, "Anteater", "Tree1");
            settings.Add("LEVEL6", true, "Engine Room", "Tree1");
            settings.Add("END", true, "Lever (final input, stops the timer)", "Tree1");     
        
        settings.Add("Tree2", true, "Optional splits", "MAIN");
            settings.Add("OPT2", true, "Ladder Split (When lightbulb man climbs the ladder)", "Tree2");
            settings.Add("OPT3", true, "Squirrel Split (When the squirrel is clicked)", "Tree2"); 
}

update{
    if (current.Value != old.Value && vars.isTiming == true){
        vars.SetChecker++;
    }
    
    if(current.Value != old.Value){
        print("SetChecker = "+vars.SetChecker+", Value changed from ["+old.Value+"] to ["+current.Value); 
    }
    if(current.Start != old.Start){
        print("Start changed from ["+old.Start+"] to ["+current.Start); 
    }
}

start{
    if (current.Start == 8 && old.Start == 5 && vars.SetChecker == 1){
        vars.isTiming = true;
        return true;
    }
}

split{
    if(vars.SetChecker == 3 && old.Value != 1){ //Split to Level 1   
        return settings["LEVEL1"];
    }

    if(vars.SetChecker == 4 && old.Value == 1){ //Split to Level 2
        return settings["LEVEL2"];
    }

    if(vars.SetChecker == 5 && old.Value != 1){ //Split to Level 3
        return settings["LEVEL3"];
    }

    if(vars.SetChecker == 6 && old.Value == 1){ //Ladder split
        return settings["OPT2"];
    }

    if(vars.SetChecker == 7 && old.Value != 1){ //Split to Level 4
        return settings["LEVEL4"];
    }

    if(vars.SetChecker == 8 && old.Value == 1){ //Squirrel split
        return settings["OPT3"];
    }

    if(vars.SetChecker == 9 && old.Value != 1){ //Split to Level 5
        return settings["LEVEL5"];
    }

    if(vars.SetChecker == 11 && old.Value != 1){ //Split to Level 6
        return settings["LEVEL6"];
    }

    if(vars.SetChecker == 12 && old.Value == 1){ //Ending split (click on the lever)
        vars.isTiming = false;
        vars.SetChecker = 1;
        return settings["END"];
    }
}

onReset{
    vars.isTiming = false;    
    vars.SetChecker = 1;
}

exit{
    vars.isTiming = false;    
    vars.SetChecker = 1;
}
