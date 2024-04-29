class CfgPatches
{
	class multiplayer_view_distance
	{
		author="Tuupertunut";
		name="multiplayer_view_distance";
	};
};

class CfgFunctions
{
	class mpvd
	{
		class base
		{
			file = "\multiplayer_view_distance";
			class initMPVD
			{
				preInit = 1;
			};
		};
	};
};
