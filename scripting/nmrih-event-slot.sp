#pragma semicolon 1
#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <autoexecconfig>

public Plugin myinfo = 
{	
	name        = "[NMRiH] Event Slot",
	author      = "newpsw",
	description = "An event occurs when zombies are killed every X times",
	version     = "1.0",
	url         = "https://github.com/newpsw/nmrih-event-slot"
};

ConVar KilledMax;
int zkcount;
int stslot;
int mranint = 6;
float slotspe = 0.1;

public OnPluginStart()
{
	HookEvent("npc_killed", Event_NPCKilled);
	HookEvent("zombie_killed_by_fire", Event_ZombieKilledByFire);
}

public OnMapStart()
{
	AddFileToDownloadsTable("materials/slotcard/scards0.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards1.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards2.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards3.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards4.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards5.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards6.vmt");
	AddFileToDownloadsTable("materials/slotcard/scards0.vtf");
	AddFileToDownloadsTable("materials/slotcard/scards1.vtf");
	AddFileToDownloadsTable("materials/slotcard/scards2.vtf");
	AddFileToDownloadsTable("materials/slotcard/scards3.vtf");
	AddFileToDownloadsTable("materials/slotcard/scards4.vtf");
	AddFileToDownloadsTable("materials/slotcard/scards5.vtf");
	AddFileToDownloadsTable("materials/slotcard/scards6.vtf");
	
	PrecacheModel("materials/slotcard/scards0.vmt", true);
	PrecacheModel("materials/slotcard/scards1.vmt", true);
	PrecacheModel("materials/slotcard/scards2.vmt", true);
	PrecacheModel("materials/slotcard/scards3.vmt", true);
	PrecacheModel("materials/slotcard/scards4.vmt", true);
	PrecacheModel("materials/slotcard/scards5.vmt", true);
	PrecacheModel("materials/slotcard/scards6.vmt", true);
	
	AutoExecConfig_SetFile("nmrih_event_slot");
	KilledMax = AutoExecConfig_CreateConVar("sm_slot_start", "40", "How many zombies have to be killed for slot event?");
	AutoExecConfig_ExecuteFile();
	
	zkcount = 0;
	stslot = 0;
	mranint = 6;
	slotspe = 0.1;
}

public Action Event_NPCKilled(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetEventInt(event, "killeridx");
	ZombieKilled(client);
	return Plugin_Continue;
}

public Action Event_ZombieKilledByFire(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetEventInt(event, "igniter_id");
	ZombieKilled(client);
	return Plugin_Continue;
}

public ZombieKilled(int client)
{
	if(client == 0 || client > MaxClients || IsFakeClient(client) || !IsClientAuthorized(client))
		return;
	
	if(KilledMax.IntValue > 0)
	{
		if(zkcount != -1)
		{
			zkcount += 1;
			if(zkcount >= KilledMax.IntValue)
			{
				zkcount = -1;
				CreateTimer(0.1, Infslot);
			}
		}
	}
}

public Action Infslot(Handle timer)
{
	stslot += 1;
	int rNum = GetRandomInt(1, mranint);
	int iFlags = GetCommandFlags("r_screenoverlay") & (~FCVAR_CHEAT);
	SetCommandFlags("r_screenoverlay", iFlags);
	if((slotspe < 0.4) && (rNum < 2))
	{
		if(mranint > 2)
		{
			mranint -= 2;
		}
		slotspe += 0.1;
		//PrintToChatAll("속도 : %f", slotspe);
	}

	if(stslot == 1)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards1");
				//PrintCenterText(client, "card 1");
			}
		}
	}
	if(stslot == 2)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards2");
				//PrintCenterText(client, "card 2");
			}
		}
	}
	if(stslot == 3)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards3");
				//PrintCenterText(client, "card 3");
			}
		}
	}
	if(stslot == 4)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards4");
				//PrintCenterText(client, "card 4");
			}
		}
	}
	if(stslot == 5)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards5");
				//PrintCenterText(client, "card 5");
			}
		}
	}
	if(stslot == 6)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards6");
				//PrintCenterText(client, "card 6");
			}
		}
	}
	if(stslot == 7)
	{
		for (int client = 1; client <= MaxClients; client++)
		{
			if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
			{
				ClientCommand(client, "r_screenoverlay slotcard/scards0");
				//PrintCenterText(client, "card 7");
			}
		}
		stslot = 0;
	}
	
	if(slotspe < 0.4)
	{
		CreateTimer(slotspe, Infslot);
	}
	else
	{
		CreateTimer(1.8, cleansc);
	}
	return Plugin_Continue;
}

public Action cleansc(Handle timer)
{
	for (int client = 1; client <= MaxClients; client++)
	{
		if ((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
		{
			ClientCommand(client, "r_screenoverlay \\");
			if(IsPlayerAlive(client))
			{
				if(stslot == 1)
				{
					SetEntPropFloat(client, Prop_Send, "m_flStamina", (GetEntPropFloat(client, Prop_Send, "m_flStamina") / 2));
				}
				if(stslot == 2)
				{
					SetEntPropFloat(client, Prop_Send, "m_flStamina", 130.0);
				}
				if(stslot == 4)
				{
					SetEntProp(client, Prop_Send, "_bleedingOut", 0);
					if(GetEntProp(client, Prop_Data, "m_iMaxHealth") > GetEntProp(client, Prop_Data, "m_iHealth"))
					{
						if((GetEntProp(client, Prop_Data, "m_iMaxHealth") - GetEntProp(client, Prop_Data, "m_iHealth")) < 10)
						{
							SetEntProp(client, Prop_Data, "m_iHealth", GetEntProp(client, Prop_Data, "m_iMaxHealth"));
						}
						else
						{
							SetEntProp(client, Prop_Data, "m_iHealth", GetEntProp(client, Prop_Data, "m_iHealth")+10);
						}
					}
				}
				if(stslot == 5)
				{
					FakeClientCommand(client, "dropweapon");
				}
				if(stslot == 6)
				{
					FakeClientCommand(client, "suicide");
				}
				if(stslot == 0)
				{
					if(GetEntPropFloat(client, Prop_Send, "m_flInfectionTime") > 0.0 && GetEntPropFloat(client, Prop_Send, "m_flInfectionDeathTime") > 0.0)
					{
						SetEntPropFloat(client, Prop_Send, "m_flInfectionTime", -1.0);
						SetEntPropFloat(client, Prop_Send, "m_flInfectionDeathTime", -1.0);
						if(GetEntProp(client, Prop_Send, "m_iObserverMode") != 1)
						{
							SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", 0);
							SetEntProp(client, Prop_Send, "m_iObserverMode", 1);
							SetEntProp(client, Prop_Send, "m_bDrawViewmodel", 0);
							CreateTimer(0.4, Reobmode, client);
						}
					}
				}
			}
		}
	}
	mranint = 6;
	zkcount = 0;
	slotspe = 0.1;
	return Plugin_Continue;
}

public Action Reobmode(Handle timer, int client)
{
	if((0 < client <= MaxClients) && IsClientConnected(client) && IsClientInGame(client) && IsPlayerAlive(client))
	{
		if(GetEntProp(client, Prop_Send, "m_iObserverMode") != 0)
		{
			SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", client);
			SetEntProp(client, Prop_Send, "m_iObserverMode", 0);
			SetEntProp(client, Prop_Send, "m_bDrawViewmodel", 1);
			SetEntProp(client, Prop_Send, "m_iFOV", 90);
		}
	}
	return Plugin_Continue;
}