;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_AcheronDefaultCommon_0500592D Extends Quest Hidden

;BEGIN ALIAS PROPERTY currentLoc
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_currentLoc Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EdgeMarkerHold
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EdgeMarkerHold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY currentHold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_currentHold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FallbackMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FallbackMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OutsideMarkerHold
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OutsideMarkerHold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OutsideMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OutsideMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EdgeMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EdgeMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
RegisterForSingleUpdate(5)
FadeToBlackImod.Apply()
Utility.Wait(2)

ObjectReference player = Alias_Player.GetReference()
ReferenceAlias[] locs = new ReferenceAlias[4]
If(player.IsInInterior())
  locs[0] = Alias_OutsideMarker
  locs[1] = Alias_OutsideMarkerHold
  locs[2] = Alias_EdgeMarkerHold
Else
  locs[0] = Alias_EdgeMarkerHold
  locs[1] = Alias_EdgeMarker
  locs[2] = Alias_OutsideMarkerHold
EndIf
locs[3] = Alias_FallbackMarker

int i = 0
While(i < locs.Length)
  ObjectReference marker = locs[i].GetReference()
  If (marker)
    player.MoveTo(marker)
    return
  EndIf
  i += 1
EndWhile

Debug.Trace("[Acheron] Default Common could not execute correctly, unable to find a valid location", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Actor player = Alias_Player.GetReference() as Actor
If(Acheron.IsDefeated(player))
  Acheron.RescueActor(player, false)
  Utility.Wait(3)
  Acheron.ReleaseActor(player)
ElseIf(Acheron.IsPacified(player))
  Acheron.ReleaseActor(player)
  Debug.SendAnimationEvent(player, "IdleForceDefaultState")
EndIf

Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Event OnUpdate()
  SetStage(25)
EndEvent

ImageSpaceModifier Property FadeToBlackImod  Auto  
