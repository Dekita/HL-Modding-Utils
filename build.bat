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

:: pak_chunk_id=the pak chunk to copy into your game directory
set pak_chunk_id=111

:: new_pak_name=the name to give the copied .pak, .ucas, and .utoc
set new_pak_name=Dek%pak_chunk_id%_TEST_P

:: ================= ::
:: DO NOT EDIT BELOW ::
:: ================= ::
set REAL_OUTPATH=%output_path%\WindowsNoEditor\phoenix\Content\Paks\pakchunk%pak_chunk_id%-WindowsNoEditor
set MODS_OUTPATH=%game_path%\Phoenix\Content\Paks\~mods\%new_pak_name%
call %engine_path%\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -nocompileeditor -nop4 -project=%project_path%/phoenix.uproject -cook -stage -archive -archivedirectory=%output_path% -package -ddc=DerivedDataBackendGraph -iostore -pak -iostore -prereqs -manifests -targetplatform=Win64 -target=phoenix -clientconfig=Shipping -utf8output -compile
copy /Y "%REAL_OUTPATH%.pak" "%MODS_OUTPATH%.pak"
copy /Y "%REAL_OUTPATH%.ucas" "%MODS_OUTPATH%.ucas"
copy /Y "%REAL_OUTPATH%.utoc" "%MODS_OUTPATH%.utoc"
"%game_path%\Phoenix\Binaries\Win64\HogwartsLegacy.exe"
