::silencio 
@echo off

:: ================== ::
:: Editable Variables ::
:: ================== ::

:: NOTE: Do NOT have spaces after variablename=
:: WRONG Example: set engine_path= D:\UE_PheonixEngine
:: RIGHT Example: set engine_path=D:\UE_PheonixEngine

:: engine_path=the path to your phoenix engine install
set engine_path=D:\UE_PheonixEngine

:: project_path=the path to your phoenix project
set project_path=D:\UE_PheonixProject

:: output_path=the path where you want to output your files, can be %project_path%
set output_path=D:\UE_PhoenixOutput

:: game_path=the path where your game is installed
set game_path=D:\SteamLibrary\steamapps\common\Hogwarts Legacy

:: launch_game_after_copy=set to "true" to auto launch game
set launch_game_after_copy="true"

:: name_prefix=the name to prefix along with chunk id onto pak/ucas/utoc
set name_prefix=Dek

:: mod_data[]=an array of {chunk_id, name} for each mod to copy over
set mod_data[0].chunk_id=100
set mod_data[0].name=MyAwesomeModOne

set mod_data[1].chunk_id=101
set mod_data[1].name=MyAwesomeModTwo

set mod_data[2].chunk_id=102
set mod_data[2].name=MyAwesomeModThree


:: ================= ::
:: DO NOT EDIT BELOW ::
:: ================= ::

:: rebuild uproject files
call %engine_path%\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -nocompileeditor -nop4 -project=%project_path%/phoenix.uproject -cook -stage -archive -archivedirectory=%output_path% -package -ddc=DerivedDataBackendGraph -iostore -pak -iostore -prereqs -manifests -targetplatform=Win64 -target=phoenix -clientconfig=Shipping -utf8output -compile

:: simple loop to get length of mods_data array
set length=0

:Loop 
:: check if array element exists and increase length
if defined mod_data[%length%].name ( 
    set /a length+=1
    GOTO :Loop 
)
:: reduce length by for loop
set /a length-=1


:: allow local variables to be set within loops
SetLocal EnableDelayedExpansion

:: loop to iterate over each defined mod_data
for /l %%x in (0, 1, %length%) do (
    :: setting various variables
    call set name=!mod_data[%%x].name!
    call set chunk=!mod_data[%%x].chunk_id!
    call set temp_outpath=%output_path%\WindowsNoEditor\phoenix\Content\Paks\pakchunk!chunk!-WindowsNoEditor
    call set temp_modpath=%game_path%\Phoenix\Content\Paks\~mods\%name_prefix%!chunk!_!name!_P
    
    :: echo for information
    echo Copying %name_prefix%!chunk!_!name!_P.pak/.ucas/.utoc
    echo from: !temp_outpath!
    echo to: !temp_modpath!
    
    :: actually copy files
    copy /Y "!temp_outpath!.pak" "!temp_modpath!.pak" 
    copy /Y "!temp_outpath!.ucas" "!temp_modpath!.ucas" 
    copy /Y "!temp_outpath!.utoc" "!temp_modpath!.utoc" 
)

@echo Finished Copying files, now launching game...

if %launch_game_after_copy% == "true" (
    "%game_path%\Phoenix\Binaries\Win64\HogwartsLegacy.exe"
)
