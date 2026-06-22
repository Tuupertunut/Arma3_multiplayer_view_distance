class CfgPatches
{
	class multiplayer_view_distance
	{
		author="Tuupertunut";
		name="multiplayer_view_distance";
		requiredAddons[] = {};
		requiredVersion = 2.14;
		units[] = {};
		weapons[] = {};
	};
};

class CfgFunctions
{
	class mpvd
	{
		class base
		{
			file = "\z\multiplayer_view_distance\addons\main";
			class initMPVD
			{
				preInit = 1;
			};
			class updateViewDistance {};
			class processRemoteUpdate {};
		};
	};
};
