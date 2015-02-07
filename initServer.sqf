#include "scripts\defines.hpp"

DEBUG_MSG("Started")
#ifdef DEBUG
    paramsarray = [-1,0,0,2,3,0,3,7,7,2,1];
#endif

// Don't fucking save the game
enableSaving [false, false];

// Broadcast time to every machine
// Use local variable first so init.sqf doesnt update prematurely on the server
// Should update dedicated server time too so AI is affected by lighting
private "_timeOfDay";
_timeOfDay = paramsarray select 0;
_timeOfDay = if (_timeOfDay == -1) then
{
    [1 + floor random 365, random 1440] // Random day of the year, random minute (24*60=1440)
}
else
{
    [157, _timeOfDay * 60] // Fixed date so that lighting is more predictable
};
TimeOfDay = _timeOfDay;
publicVariable "TimeOfDay";

// Broadcast starting weather to players (WIP, weather is not a priority now)
WeatherMode = paramsarray select 1;
publicVariable "WeatherMode";

// Broadcast NV availability
Use_NV = paramsarray select 2;
switch (Use_NV) do
{
    case -2: {Use_NV = floor random 4};
    case -1: {Use_NV = floor random 2};
};
Use_NV = switch (Use_NV) do
{
    case 0: {[false,false]};
    case 1: {[true,true]};
    case 2: {[true,false]};
    case 3: {[false,true]};
};
publicVariable "Use_NV";


// Find players starting position and broadcast it


// Start game loops
execVM "scripts\aiLoop.sqf";
execVM "scripts\gameLoop.sqf";

#ifdef DEBUG
    execVM "scripts\debugLoop.sqf";
#endif