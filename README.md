# About (2021)
Kiscan is GUI Framework for Unreal Development Kit (Unreal Engine 3). I released it in March 2014 and since then it was self hosted on my domain. I moved it to GitHub in 2021 to find more persistent place for it. Framework architecture and the way UI authoring works can be compared to UMG of UE4, although there were significant limitations as there was no C++ access or editor customization in UDK.
As this framework was created quite some time ago, it does not represent my present code quality. All the folowing sections are mostly copied from my self hosted page. Documentation is not complete because at the time of the release of Kiscan, Unreal Engine 4 came out and I migrated shortly too. 

### Main pillars
- Utilize Full Power of Kismet: All dynamic actions and events are managed in Kismet. You don't need to touch single line of code.
- Designer Friendly: Good looking and fully functional user interface using just UDK editor.
- Saves You Time: Create high-quality GUI in a few minutes.

### What is Kiscan
Kiscan is GUI framework for Unreal Develoment Kit. It is a tool which allows developers to create fully interactive and dynamic user interface. It offers more than 80 custom UnrealScript classes. It primary focuses on designers, so It requires no programming knowledge. All features are accessible in the Unreal Editor and the Unreal Kismet.

### Why Kiscan
UDK supported only two solutions until the release of Kiscan. First is Scaleform which connects UDK and Flash Professional (costs hundreds of dollars). Second solution is Canvas which is pretty old UnrealScript class usable only by programmers. I made this framework on top of Canvas and added custom algorithms to expose its power to Unreal Editor. Working with Kiscan is fast and reliable because everything is visual and easy to debug. You can create menus, inventories, overlays, cursors or even 2D Games in a few minutes.

### Author
Made by Ondrej Hrusovsky. At the time of Kiscan release (March 2014) I had four years of experience with development in UDK.

## Installation

### Overview
Installation of Kiscan is very simple and fast. Kiscan uses as default gametype `GameInfo` which supports only flying with invisible character. We will change gametype in third part of this page.

### Basic installation
1. Unpack zip package which contains Kiscan GUI Framework.
2. Copy folders `Development` and `UDKGame` from zip to root folder of your UDK. There are folders with same name.
3. Open `UDKGame/Config/DefaultEngine.ini`.
4. Find block `[UnrealEd.EditorEngine]`.
5. Add `+EditPackages=Kiscan` after last `+EditPackages` line:

```
[UnrealEd.EditorEngine]
+EditPackages=UTGame
+EditPackages=UTGameContent
+EditPackages=Kiscan
```
When you will launch editor it will ask for recompile, press `Yes`.

### Setting up editor
Framework requires some initialization and settings to be set first. In this part we will set up editor for using Kiscan and then test it with debug implemented in Kismet.

1. Open up UDK Editor
2. Go into `View > World Properties` and set `Default Game Type` and `Game Type for PIE` to `KISGame`:
![gametype](https://github.com/Skylonxe/kiscan/blob/main/Resources/gametype.png)
3. Open Kismet and create new event `Kiscan - Main > HUD Initialized` and action `Kiscan - Main > Init Kiscan`:
![initkiscan](https://github.com/Skylonxe/kiscan/blob/main/Resources/initkiscan.png)
4. Now, we need to assign default settings of framework to `Main > Init Kiscan`. Go to `View > Browser Windows > Actor Classes` and find `KISSettings`. You will probably need to uncheck three checkboxes to see that:
![actorclasses](https://github.com/Skylonxe/kiscan/blob/main/Resources/actorclasses.png)
5. Right click on KISSettings and select Create Archetype….
6. Enter name of package of your GUI project, for example MyGUI. Group can be empty, however it is good to use if you do not want to have there chaos later. Use any Name, for example FrameworkSettings.
7. Click OK and find your new settings archetype in Content Browser.
8. Select your new settings, open it and check Draw Debug Cursor. This will draw cross as cursor in our game. It is useful for debugging and we can use it to check if framework works:
![settingsarchetype](https://github.com/Skylonxe/kiscan/blob/main/Resources/settingsarchetype.png)
9. With selected archetype go into Kismet and assign it to Settings in Main > Init Kiscan using green arrow. Optionally you can select archetype, press Ctrl+C and then paste it with Ctrl+V into Settings:
![assignsettings](https://github.com/Skylonxe/kiscan/blob/main/Resources/assignsettings.png)

We are done. You should see cross which shows your current cursor position:
![debugcursor](https://github.com/Skylonxe/kiscan/blob/main/Resources/debugcursor.png)
It indicates that framework is ready.

### Changing gametype to some default UDK one
In this part we will show you how to change gametype, so you will be able to utilize Kiscan during gameplay of other gametypes. Right now, you can just fly in your map and you can see debug cursor. We fly because kiscan is based on GameInfo gametype which is just “fly mode” or some kind of empty project.

If you want to use kiscan on top of some other gametype go to UDK/Development/Src/Kiscan/Globals.uci and open this file with any text editor.

Find line \`define KISParentProject_GameInfo and change it to one of desired gametype:

- `KISParentProject_GameInfo`
- `KISParentProject_UTGame_ClassicHUD`
- `KISParentProject_UTGame_ScaleformHUD`
- `KISParentProject_UDKGame`
There are two for UTGame because we can use only one type of UT HUD as base class for kiscan.

When you are done, open `UDK/Binaries/UnrealFrontend.exe`, select `Script` button and press `Full Recompile`.

### Changing gametype to custom one
Adding new gametypes to list is very easy. All names of required classes are defined in `Globals.uci`. Find line \`define KISParentProject_GameInfo and change `GameInfo` to name of your project (name does not matter). Find line `Default case:` and change names of default unrealscript classes to your classes:

- `Default case:`
- `define KiscanGameInfoClass MyProjectGameInfo`
- `define KiscanPlayerControllerClass MyProjectPlayerController`
- `define KiscanHUDClass MyProjectHUD`
- `define KiscanPlayerInputClass MyProjectPlayerInput`
When you are done, open `UDK/Binaries/UnrealFrontend.exe`, select `Script` button and press `Full Recompile`.
