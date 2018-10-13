This folder is for putting folders containing scripts, sounds and more necessary for running your mission in OpUs. Make sure
you have gone through the following checklist to ensure that all parameters for the mission have been
properly defined:

Defenders:
(random enemy nation, strongest, none(if transport/logistical etc))

Area:
[
    (inside territory([(enemy, friendly or any), yes or no]), 
    (random location[sea, air, land or any] or pre-defined(with WorldName or array of WorldNames to avoid errors)),
]

Objective:
What will you do in the mission? Seems pretty obvious, but worth taking into consideration,
feel free to add trivia in the mission description to enhance the experiance of your operation.
    Intel(Recommended):
    to add in the intel box of your MissionMenu display(Call Function with following indexes):
    //ROT_fnc_IntelBox, spawn
    0. Recommended player count(ex 1-4 players, 4-8 players), number
    1. Reward, String
    2. Recommended or Forced class for join and/or start, string
    3.
    
Rewards:
Script or integer with call of predefined function
ex:
1: {player setVariable ["Garage", OldVehicles + APC}
2: [(Units in mission),"32K"] call PRE_fnc_RewardCash;
 


Script Description of the standard scripts/files in this folder(//DO NOT REMOVE THEM//):

RootInc:
For referencing to custom sounds, music, FSMs etc for use in your mission. Add a separate Functions.hpp,Music.hpp,Sounds.hpp etc and reference to that 
through RootInc in your own folder to lower clutter for others creating missions after you.