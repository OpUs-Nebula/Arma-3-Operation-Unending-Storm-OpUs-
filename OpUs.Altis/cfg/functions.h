// Client
class Nebula_Functions_Client
{
    tag = "client";
	class functions 
	{
		file = "bin\client";
		class CreateTimer {};
        class showGunShopDialog {};
        class MissionMenu {};
        class Init {};
        class GetVar {};
        class SaveGear {};
        class SaveArsenal {};
        class SavePosition {};
        class SaveFunds {};			
	};
};
class Nebula_Functions_Server
{
    tag = "server";
	class functions 
	{
		file = "bin\server";
        class Init {};
		class WorldScan {};
        class SpawnMarkers {};
        class DefineZones {};
        class DefaultNatParams {};	
	};	
};
class Nebula_Functions_Dev
{
    tag = "Dev";
	class functions 
	{
		file = "Dev";
		class BaseExtractor {};
        class Extractor {};
        class rptDump {};		
	};	
};
class Nebula_PostInit_Server
{
    tag = "PI";
	class functions 
	{
		file = "bin\server\PostInit";
        class CommandNucleus {};
		class ZonePopulation {};
        class ZoneTimer {};
        class CreateNation {};
        class ZoneGuardian {};
        class ZoneTracker {};
        class ObjectiveCreator {};
        class ZoneObjClean {};
        class AnimHandler {};
        class DynTrig {};
        class Resistance {};
        class Territory {};
        class SetSkill {};
        class AiLoadout {};
        class AiAmmo {};
        class QRF {};
        class Boot {};		
	};	
};
class Nebula_Atmosphere_PostInit
{
    tag = "AMB";
	class functions 
	{
		file = "bin\server\PostInit\Atmosphere";
        class CloseLoss {};
        class CloseWin {};
        class ZoneEnter {};
        class ZoneDefeat {};
        class ZoneWin {};		
	};	
};
class Nebula_Objectives_PostInit
{
    tag = "OBJ";
	class functions 
	{
		file = "bin\server\PostInit\Objectives";
        class CommDisrupt {};
		class StrategicBuilding {};
        class Sabotage {};
        class Elimination {};	
	};	
};
class Nebula_Bases_PostInit
{
    tag = "BAS";
	class functions 
	{
		file = "bin\server\PostInit\Bases";
        class BaseStorage {};
		class BasePop {};
		class AliveHandler {};
		class Decs {};
		class IntelObjs {};
		class PoseSelec {};
		class Staff {};
		class Commander {};
		class Engineer {};
		class Armory {};
	};	
};
class Nebula_AI_PostInit
{
    tag = "AI";
	class functions 
	{
		file = "bin\server\PostInit\AI";
        class ClearArea {};
		class SetWaypoint {};
		class CombEject {};
	};	
};
class Nebula_Events_PostInit
{
    tag = "EH";
	class functions 
	{
		file = "bin\server\PostInit\Events";
        class OnKillDam {};
		class UnitKillDam {};
	};	
};
class Nebula_Building_Bases
{
	tag = "CON";
	class functions 
	{
		file = "bin\server\PostInit\Bases\Building";
        class BuildMenu {};
		class Assemble {};
		class Factory {};
	};
};
class Nebula_Setup_Objectives
{
    tag = "SET";
	class functions 
	{
		file = "bin\server\PostInit\Objectives\Setup";
		class Furniture {};
		class Guards {};
		class HvT {};
		class Intel {};
		class Props {};
        class IntelHandler {};
        class SabHandler {};
        class Supplies {};		
	};	
};
class Nebula_Objectives_Cfgs
{
	tag = "CFG";
	class functions
	{
		file = "cfg\Objectives";
		class BuildingParams {};
		class BaseParams {};
		class BaseLoadouts {};
		class FactoryParams {};
		class VehicleParams {};
		class MoneyDisplay {};
		class PriceCalc {};
		class VehPurch {};
		class VehReg {};
		class VehConst {};
		class DispFlag {};
		class InfiniAmmo {};
		class WeaponParams {};
		class Trivia {};
		class ArmoryPurch {};
		class Arsenal {};
	};
};
class Nebula_Utils_fncs
{
	tag = "UTL";
	class functions
	{
		file = "cfg\util-Fncs";
		class GodTillComb {};
		class NearestZone {};
		class GetSide {};
		class NationAOupdt {};
		class PopulBuil {};
		class LBpopul {};
		class EarnFunds {};
		class IsKindOf {};
		class GetAttach {};
		class SQLdtype {};
	};
};
class BI_Forums_Fncs
{
	tag = "BIF";
	class functions
	{
		file = "BIForums";
		class UpdateInContainer {};
	};
};
class Client_DataBase_Functions
{
	tag = "DBC";
	class functions
	{
		file = "Database\client";
		class GetPlayer {};
		class SetPlayer {};
	};
};
class Server_DataBase_Functions
{
	tag = "DBS";
	class functions
	{
		file = "Database\server";
		class Connect {};
		class GetData {};
		class SetData {};
		class EntryExists {}
		class asyncCall {}
		class PrepString {}
	};
};
class Server_DataBase_Responses
{
	tag = "RESP";
	class functions
	{
		file = "Database\server\Responses";
		class SetVariable {};
	};
};

