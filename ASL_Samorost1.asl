state("Samorost1") // This tells LiveSplit which process to connect to.
{
    uint Value: "Adobe AIR.dll", 0x00DCD3B8, 0xCFC, 0x4, 0x1B4, 0x1C, 0x99C; // Value that does it all. Ends the timer and does all the splits (even the unwanted ones)
    uint Start: "Adobe AIR.dll", 0xDCBDA0; // Value that starts the run. Found by Streetbackguy. No clue how it behaves.
}

startup
{
    //This value increases with every Value change. All of the settings below are tied to a specific SetChecker value.
    vars.SetChecker = 0;
    //sets up a tree of split options. Birst batch are the level splits, under that are the optional splits.    
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

update
{
    //Checks on the Value. If it changes, adds 1 to the SetChecker. Note that one change happens on the game startup, so the initial value is practically not 0, but 1
    if (current.Value != old.Value)
    {
     vars.SetChecker++;
    }
}

start // If the Start value was previously 5 and changes to 8, that means the run can start. Again, no clue how this value behaves apart from this bit.
{
    if (current.Start == 8 && old.Start == 5)
    {
        return true;
    }
}

split //If the setting is checked, the AS splits when the SetChecker reaches a specific number. Code is structured in the order in which the value changes occur.
{
    if(vars.SetChecker == 3 && old.Value != 1) //Split to Level 1
    {
        return settings["LEVEL1"];
    }

    if(vars.SetChecker == 4 && old.Value == 1) //Split to Level 2
    {
        return settings["LEVEL2"];
    }

    if(vars.SetChecker == 5 && old.Value != 1) //Split to Level 3
    {
        return settings["LEVEL3"];
    }

    if(vars.SetChecker == 6 && old.Value == 1) //Ladder split
    {
        return settings["OPT2"];
    }

    if(vars.SetChecker == 7 && old.Value != 1) //Split to Level 4
    {
        return settings["LEVEL4"];
    }

    if(vars.SetChecker == 8 && old.Value == 1) //Squirrel split
    {
        return settings["OPT3"];
    }

    if(vars.SetChecker == 9 && old.Value != 1) //Split to Level 5
    {
        return settings["LEVEL5"];
    }

    if(vars.SetChecker == 11 && old.Value != 1) //Split to Level 6
    {
        return settings["LEVEL6"];
    }

    if(vars.SetChecker == 12 && old.Value == 1) //Ending split
    {
        return settings["END"];
    }
}

//These reset the SetChecker if the counter is reset or the game is exited.
onReset
{
    vars.SetChecker = 0;
}

exit
{
    vars.SetChecker = 0;
}