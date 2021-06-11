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

## Fundamentals

### Overview
In previous part you created simple gui, however we talked about features only slightly. In this part, we will talk more about framework and how it everything works together. We will cover all important parts of framework.

We usually build basic looks of our GUI using Content Browser and Archetypes. Archetypes are templates of some objects. We create archetypes using Actor Classes and then link them each other. Every archetype has some name but that name does not matter. What matters is Tag of our archetype.

Tags have to be unique for every object. Tags are usually specified in properties and represent name of real object which will be created on beginning of game from our archetype. Tags are especially very important in kismet. Let's say that you want to create variable in kismet which refers to some image. You can not use name of archetype because you can have unlimited count of objects based on same archetype but what is unique for every object is its Tag. That is why we use Tag to get reference to some specific object.

When we have our archetypes ready we can then link them to rendering process using kismet. We use kismet for dynamic and runtime events and actions only. Main rule of kiscan is that everything you can create and set up in editor you can also do during gameplay using kismet, so most of custom kismet nodes are simple SetProperty and GetProperty actions.

### Concept
![kiscan_hierarchy_2](https://github.com/Skylonxe/kiscan/blob/main/Resources/kiscan_hierarchy_2.png)
There are four types of objects that you can work with:

- Settings
- Scenes
- Components
- Canvas Objects

#### Settings
Provides default settings for framework during initilization. These are relevant only during development and you can not access them during gameplay.

See Settings page for more informations.

#### Scenes
Represent transparent layer where you can place components or subscenes. Subscenes are same objects as common scenes, however they are affected by their parent scenes (they move together and so on).

See Scene page for more informations.

#### Components
Components are containers for graphics (Canvas Objects). They do not contain graphics because graphics is just linked to them by developer. They can process input and dynamically update various graphics based on situation. E.g. button, radio button, checkbox, text field.

See Component page for more informations.

#### Canvas Objects
Manage only visual part (rendering) and can not process input because input is processed by their parent - component. They are directly linked to assets like textures, fonts, materials.

See Canvas Object page for more informations.

### Properties types
#### Static
Regular properties like color and so on. These do not need additional logic and can be used internally by framework in same form as they are stored in property.

Static properties are accessible in kismet using actions XY_SetProperty, XY_GetProperty.

#### Dynamic/Output
Many properties requires to be dynamically updated by framework during gameplay. Good example is position. We can not simply implement logic like ImagePosition.X = Position.X because it will work good with default resolution, however it will not update when you change your resolution and want to have image on same place.

That is why we decided to break these properties into two:

- Dynamic
- Output

Dynamic properties represent input values specified by developer.

Output properties represent output values that is used by framework, internally calculated from Dynamic ones based on current resolution and aspect ratio (You can see these calculations here: Draw Mode).

Note: For easier reading we do not prefix properties with “Dynamic” in editor. Output properties always contain prefix “Output”.

Dynamic properties are accessible in kismet using actions XY_SetProperty, XY_GetProperty.

Output properties are accessible in kismet using actions XY_GetOutputProperty.

### Position
Usually we discuss properties of objects at separate pages but Position is often used and a bit more complicated than simple one line properties, so we will explain it here.

Position is Dynamic/Output property composed from three different types of specifying of position.

- Dynamic
- Relative
- Offset

#### Dynamic
Result is calculated by Draw Mode. Most usual position type. Usually it means that `1 Dynamic Unit = 1 Pixel` when your resolution same as Native Resolution.

#### Relative
1.0 Relative Unit = Full size of region allowed by Draw Mode.

0.5 Relative Unit = Half size of region allowed by Draw Mode.


Usually = 0.5 middle of screen.

#### Offset
1 Offset Unit = 1 Pixel (always).

When these three position types are calculated, they are summed into one property Output Position. It represents final position of object in pixels.

### Size
All sizes in Kiscan work like Dynamic position type.

1 Size Unit = 1 Pixel only when you use same resolution as Native Resolution. Otherwise, result is calculated by Draw Mode.

### Draw Mode
Draw Mode allows you to specify how the scene and subscenes should be scaled/fit to the screen as resolution changes occur.

- No Scale
- Exact Fit
- Show All
- No Border
- Relative

#### No Scale
Scene remains the same size and aspect ratio (AR) as it was originally created.

![no_scale](https://github.com/Skylonxe/kiscan/blob/main/Resources/no_scale.png)

#### Exact Fit
Scene is stretched, or non-uniform scaled, to fit the screen resolution, altering its AR; this causes movie clip distortion on either the X or Y; clipping will not occur.

Relative Position is calculated from Native Resolution.

![exact_fit](https://github.com/Skylonxe/kiscan/blob/main/Resources/exact_fit.png)

#### Show All
Entire scene is always visible, no matter what resolution you set in UDK; uniform scaling is performed to ensure this, keeping the original AR; clipping will not occur, but letter boxing will.

Relative Position is calculated from letter boxed screen.

![show_all](https://github.com/Skylonxe/kiscan/blob/main/Resources/show_all.png)

#### No Border
Scene is always displayed at the original AR, but it is scaled depending on the resolution; clipping will occur at game resolutions with different AR.

![no_border](https://github.com/Skylonxe/kiscan/blob/main/Resources/no_border.png)

#### Relative
Absoulutly same as No Scale, however Relative Positions are calculated from current screen resolution.

![no_scale](https://github.com/Skylonxe/kiscan/blob/main/Resources/no_scale.png)

Remember that Draw Modes are inherited by child objects. So Draw Mode of subscenes does not have any effect! If you want to know more about math behind Draw Modes here are calculations:

```javascript
final static function IntPoint GetAdjustedPosition(KISGUIPosition Pos, EKISDrawMode DM, KISHandle Handle)
{
	local float ShowAllSizeY, NoBorderSizeX;
	local IntPoint Result;
 
	//Handle.ScreenRatio
	//ScreenRatio.X = HUD.SizeX / Settings.NativeResolution.X;
	//ScreenRatio.Y = HUD.SizeY / Settings.NativeResolution.Y;
 
	if(Handle != none && Handle.Settings != none && Handle.HUD != none)
	{
		switch(DM)
		{
			case DM_NoScale:
				Result.X = Pos.Dynamic.X + Pos.Relative.X * Handle.Settings.NativeResolution.X + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y + Pos.Relative.Y * Handle.Settings.NativeResolution.Y + Pos.Offset.Y;
				break;
			case DM_ExactFit:
				Result.X = Pos.Dynamic.X * Handle.ScreenRatio.X + Pos.Relative.X * Handle.HUD.SizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y * Handle.ScreenRatio.Y + Pos.Relative.Y * Handle.HUD.SizeY + Pos.Offset.Y;
				break;
			case DM_ShowAll:
				ShowAllSizeY = Handle.HUD.SizeX * (float(Handle.Settings.NativeResolution.Y) / Handle.Settings.NativeResolution.X);
 
				Result.X = Pos.Dynamic.X * Handle.ScreenRatio.X + Pos.Relative.X * Handle.HUD.SizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y * Handle.ScreenRatio.X + Pos.Relative.Y * ShowAllSizeY + Pos.Offset.Y;
				break;
			case DM_NoBorder:
				NoBorderSizeX = Handle.HUD.SizeY * (float(Handle.Settings.NativeResolution.X) / Handle.Settings.NativeResolution.Y);
 
				Result.X = Pos.Dynamic.X * Handle.ScreenRatio.Y + Pos.Relative.X * NoBorderSizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y * Handle.ScreenRatio.Y + Pos.Relative.Y * Handle.HUD.SizeY + Pos.Offset.Y;
				break;
			case DM_Relative:
				Result.X = Pos.Dynamic.X + Pos.Relative.X * Handle.HUD.SizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y + Pos.Relative.Y * Handle.HUD.SizeY + Pos.Offset.Y;
				break;
			default:
				break;
		}
	}
 
	return Result;
}
 
final static function Vector2D GetAdjustedSize(KISVector2DUnsigned S, EKISDrawMode DM, KISHandle Handle)
{
	local Vector2D Result;
 
	S.X = Abs(S.X);
	S.Y = Abs(S.Y);
 
	if(Handle != none)
	{
		switch(DM)
		{
			case DM_NoScale:
				Result.X = S.X;
				Result.Y = S.Y;
				break;
			case DM_ExactFit:
				Result.X = S.X * Handle.ScreenRatio.X;
				Result.Y = S.Y * Handle.ScreenRatio.Y;
				break;
			case DM_ShowAll:
				Result.X = S.X * Handle.ScreenRatio.X;
				Result.Y = S.Y * Handle.ScreenRatio.X;
				break;
			case DM_NoBorder:
				Result.X = S.X * Handle.ScreenRatio.Y;
				Result.Y = S.Y * Handle.ScreenRatio.Y;
				break;
			case DM_Relative:
				Result.X = S.X;
				Result.Y = S.Y;
				break;
			default:
				break;
		}
	}
 
	return Result;
}
```

#### Priority
With objects like scenes, components, canvas objects you will want to ensure that some object will be rendered under some other object and some other one will be on top. This is easily doable using Priority property. Priority is common integer and you can put there any number. Difference between two priorities does not matter, PriorityOfX=1, PriorityOfZ=2 is absolutly same as PriorityOfX=-500, PriorityOfZ=1000.

When values are same, you can not assume order of rendering, so if you want to ensure order of rendering always specify desired priority.

Example:

Left Image - Scene which contains cursor - Priority=2

Left Image - Scene which contains image - Priority=5

Right Image - Scene which contains cursor - Priority=10

Right Image - Scene which contains image - Priority=5

![priority](https://github.com/Skylonxe/kiscan/blob/main/Resources/priority.png)
