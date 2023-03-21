## Making your HL mod both UE4SS and Apparate Modloader compatible

Create a custom folder for housing all of your mods, and their logic and content. Lets pretend this has been called /DekitaRPG. Within this folder, create another folder for each specific mod. For this example its called /MyDopeMod. Now create an actor object in this folder for handling all of your mods logic. Lets pretend its called MyModLogic (full path: '/Content/DekitaRPG/MyDopeMod/MyModLogic')

Create /CustomContent folder in your uproject /Content folder if doesnt exist. Create an empty level (no lighting etc) within /CustomContent. The name of this level is what users will type into apparate modloader to load your mod. 

Create /Mods folder in your uproject /Content folder if doesnt exist. Create a folder with a name matching EXACTLY what you will call your mod files, ie, MyDopeMod_P. Create an actor blueprint within your new custom folder and name it ModActor

Add /Mods/YourModName/ModActor to your level at /CustomContent/ModNameForApparate

In your ModActor, perform a check to make sure that there are none of the same class already running and destroy self / existing instances as desired. 

Finally Spawn an instance of your 'MyModLogic' actor within your ModActor.  


This approach ensures that all of your logic is handled entirely seperate from the entry point of both apparate and ue4ss. It also ensures that only a single instance of your mod logic will be running at any one time. 

Any additional widgets, blueprrints, textures, etc for your mod should do into your custom folder created in step 1, ie 'Content/DekitaRPG/MyDopeMod'