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

## Getting Started
### Overview
In this short tutorial we will show you how to create simple scene with one image and one button. We will use default textures included in `KIS_Resource` package.
Purpose of this tutorial is not to learn you how framework works but show you how creation of GUI looks. We will talk more about framework later.

### Preparation of framework
First, we need to add framework to our level. Follow Setting up editor instructions and create empty project with debug cursor enabled.

### Framework - quick overview
Working with Kiscan is very easy. In this section we will talk about some most basic fundamentals of framework. Our objects are divided into three levels: Scenes, Components, Canvas Objects.
In Content Browser we can create templates (archetypes) of these object and then link them each other. When game starts, real objects are created from these templates.

![kiscan_hierarchy](https://github.com/Skylonxe/kiscan/blob/main/Resources/kiscan_hierarchy.png)

- Scenes represent transparent layer where components can be placed. It is similar to Adobe Photoshop layer.
- Components are objects that process input from player but do not contain references to any graphics. They contain only empty lists for canvas objects. Various components use various lists. For example, component button uses three lists: Idle, Hover, Clicked. Every list is rendered in some other situation.
- Canvas Objects define only references to graphics but do not do anything interactive or dynamic because components are there for their management.

### First scene
Find `KISScene` in Actor Classes and `Create Archetype`. Open it and set `Draw Tag` to true. This will help us to see if scene work as expected because it will display tag (name) of scene on screen.
Create new sequence `Scene > Create New` and connect it with `Main > Init Kiscan`. Then, create new string variable and connect it to `New Scene Tags`. Enter there name for your scene which will be created on start of game from our archetype/template, for example MyScene. Set `Scene Archetype` to your newly created scene.

![firstscene](https://github.com/Skylonxe/kiscan/blob/main/Resources/firstscene.png)

When you are done, you can launch game and check if you see tag of your scene in top left corner.

![scenetag](https://github.com/Skylonxe/kiscan/blob/main/Resources/scenetag.png)

### First component
Find `KISComponent` in Actor Classes and create new archetype. Open it and set `Draw OutputPosition` to true, this will draw current position of component, so we will be able to see if component works as expected. We will also move it a bit to the left, so set `Position > Dynamic > X` to 150.

Now we need to assign our newly created component to our scene. Open our scene and find line `Component Archetype`. Click on green plus to create new slot for component. Assign there our component using green arrow and set some tag for it, for example MyComponent.

![firstcomponent](https://github.com/Skylonxe/kiscan/blob/main/Resources/firstcomponent.png)

You can then launch game and check if you can see output position of your component. It indicates that component is ready for further work.

![componentoutputpos](https://github.com/Skylonxe/kiscan/blob/main/Resources/componentoutputpos.png)

### First canvas object
Now when we have working component we can attach some graphics to it. We will start with simple image which will use default kiscan texture (yellow checker). Open our component and expand `CO List - Static` line. Create new slot and specify some `Tag`, for example MyImage. Click blue arrow and select `KISCanvasObject_Image`.

![colist](https://github.com/Skylonxe/kiscan/blob/main/Resources/colist.png)

Launch game and see ! Our new image is there with default yellow texture. You can play a bit with canvas object and change texture or some other properties if you want, however we will cover this in part later.

![firstcanobj](https://github.com/Skylonxe/kiscan/blob/main/Resources/firstcanobj.png)

### Making of button
Making of button is very easy and you already know how to do it!

Create new component `KISComponent_Button`, assign it to scene, and create three different canvas objects (you can change their color in properties of each canvas object) in three lists - `CO List - Idle`, `CO List - Hover`, `CO List - Clicked`.
Tags of canvas objects have to be unique, for example Image1, Image2, Image3. You can also move your button a bit down by `Position > Dynamic > Y`. When you did all this steps, set value `Shape Enabled` in every canvas object to true. This will allow our button to process input and make it “visible” for input processing.

![buttonproperties](https://github.com/Skylonxe/kiscan/blob/main/Resources/buttonproperties.png)

You can launch game and test your button. If you move cursor on your button it should change its visual to Hover list. When you click it, it should change to canvas object specified in `COList - Clicked`.

Now, we need to link this button with some kismet action. Open kismet and create new event `Comp > Button > Activated` and link it with some action, for example `Log`. Create new string variable and link it to our event. Write tag of your button component to this variable.

We are done ! When you press button it will print your log to screen.

### Conclusion
You should now understand how GUI creation in kiscan looks. Feel free to experiment with all available properties because experimentíng is best way how to learn something. Almost all properties have tooltips available!

