-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 40;
local ReqClv = 10;
local ReqJlv = 0;
local NextQuest = 150;
local RewZeny = 430;
local RewCxp = 480;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 52;
local RewItemCount1 = 11;
local RewItemCount2 = 1;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

function QUEST_START(cid)

	Saga.AddStep(cid, QuestID, 4001);
	Saga.AddStep(cid, QuestID, 4002);
	Saga.AddStep(cid, QuestID, 4003);
	-- Initialize all quest steps
	-- Initialize all starting navigation points
		Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk to ?
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1003);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003 then
		Saga.GeneralDialog(cid, 349);
		Saga.SubstepComplete(cid, QuestID, 501, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, 501, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 501);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Lancement des �tapes
	Saga.FindPosition(cid, QuestID, StepID, 1, 4187, -32199, -711, 2, 1000);
	
	-- V�rifie si l'�tape en cours est termin�
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Lancement des �tapes
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1003);
	
	-- V�rifie que l'on parle au Npc
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003 then
		Saga.GeneralDialog(cid, 352);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- V�rifie si l'�tape en cours est termin�
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- V�rifie toutes les �tapes
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	local StepID = CurStepID;
	
	if CurStepID == 4001 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 4002 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 4003 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
