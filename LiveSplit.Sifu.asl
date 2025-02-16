state("Sifu-Win64-Shipping")
{
	int loading: 0x05A5AEC8, 0x120;  // default
}

state("Sifu-Win64-Shipping", "Steam16022025")
{
	int loading: 0x05A5AEC8, 0x120;  // optional by versions
}


startup
{
	settings.Add("split_on_home", false, "split_on_home");
	settings.SetToolTip("split_on_home", "Check if you want autosplit on hideout sections");
}


init
{
	print(modules.First().ModuleMemorySize.ToString());
    switch (modules.First().ModuleMemorySize)
 	{
   		case 103370752:
   			version = "Steam16022025";
   			print("Steam16022025");
   			break;
 	}
	// buffer to store is we count home visit
	vars.count_home = 0;
}

split
{
    if (current.loading == 1 && old.loading == 0) {
		if (settings["split_on_home"]) {
			return true;
		} 
		if (vars.count_home == 1) {
			vars.count_home = 0;
			return true;
		} else {
			vars.count_home = 1;
			return false;
		}
    }
}

isLoading // Load remover
{

	if (current.loading == 1) {
        return true;
    }
    return false;
}

