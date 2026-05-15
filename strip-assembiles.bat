@echo off 

@REM Add all the assemblies you want to publicize in this list
set toPublicize=Assembly-CSharp.dll Assembly-CSharp-firstpass.dll Game.dll HawkNetworking.dll HawkNetworkingPlugins.dll Utils.dll Space.dll WobblyRun.dll ArcadeMachine.dll ArcadeMachineGamesOld.dll ArcadeMachine-Plumbers.dll ArcadeMachine-SuperShopping.dll HideAndSeek.dll InGameDebugConsole.Runtime.dll ModWobblyLife.dll Sandbox.dll TrashMan.dll UnityEngine.dll UnityEngine.CoreModule.dll UnityEngine.UI.dll UnityEngine.UIModule.dll UnityEngine.IMGUIModule.dll UnityEngine.AnimationModule.dll UnityEngine.AudioModule.dll UnityEngine.PhysicsModule.dll UnityEngine.Physics2DModule.dll UnityEngine.ParticleSystemModule.dll UnityEngine.TextRenderingModule.dll UnityEngine.TextCoreModule.dll UnityEngine.InputLegacyModule.dll UnityEngine.InputModule.dll UnityEngine.ImageConversionModule.dll UnityEngine.JSONSerializeModule.dll UnityEngine.AssetBundleModule.dll UnityEngine.DirectorModule.dll UnityEngine.AIModule.dll UnityEngine.TerrainModule.dll UnityEngine.VideoModule.dll UnityEngine.UnityWebRequestModule.dll UnityEngine.UnityWebRequestAssetBundleModule.dll UnityEngine.UnityWebRequestAudioModule.dll UnityEngine.UnityWebRequestTextureModule.dll UnityEngine.UnityWebRequestWWWModule.dll UnityEngine.SpriteShapeModule.dll UnityEngine.SpriteMaskModule.dll UnityEngine.TilemapModule.dll UnityEngine.GridModule.dll UnityEngine.UIElementsModule.dll UnityEngine.UIElementsNativeModule.dll UnityEngine.SubsystemsModule.dll UnityEngine.SharedInternalsModule.dll UnityEngine.ScreenCaptureModule.dll UnityEngine.LocalizationModule.dll UnityEngine.HotReloadModule.dll UnityEngine.ProfilerModule.dll UnityEngine.UNETModule.dll UnityEngine.VehiclesModule.dll UnityEngine.ClothModule.dll UnityEngine.VFXModule.dll UnityEngine.XRModule.dll UnityEngine.VRModule.dll UnityEngine.GIModule.dll UnityEngine.WindModule.dll UnityEngine.VirtualTexturingModule.dll Unity.Mathematics.dll Unity.Collections.dll Unity.Burst.dll Unity.TextMeshPro.dll Unity.Addressables.dll Unity.ResourceManager.dll Unity.Postprocessing.Runtime.dll Unity.Timeline.dll Unity.Animation.Rigging.dll Unity.Localization.dll

@REM Add all the assemblies you want to copy as-is to the package in this list
set dontTouch=

set exePath=%1
echo exePath: %exePath% 

@REM Remove quotes
set exePath=%exePath:"=%

set managedPath=%exePath:.exe=_Data\Managed%
echo managedPath: %managedPath%

set outPath=%~dp0\package\lib

@REM Strip all assembiles, but keep them private.
%~dp0\tools\NStrip.exe "%managedPath%" -o %outPath%

@REM Strip and publicize assemblies from toPublicize.
(for %%a in (%toPublicize%) do (
  echo a: %%a

  %~dp0\tools\NStrip.exe "%managedPath%\%%a" -o "%outPath%\%%a" -cg -p --cg-exclude-events
))

@REM Copy over original assemblies for ones we don't want to touch.
(for %%a in (%dontTouch%) do (
  echo a: %%a

  xcopy "%managedPath%\%%a" "%outPath%\%%a" /y /v
))

pause
