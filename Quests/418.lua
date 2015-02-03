-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 418;
local ReqClv = 26;
local ReqJlv = 0;
local NextQuest = 419;
local RewZeny = 853;
local RewCxp = 1980;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 0;
local RewItem2 = 0;
local RewItemCount1 = 0;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 41801);
	Saga.AddStep(cid, QuestID, 41802);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1182);

	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1182 then
		Saga.GeneralDialog(cid, 4653);
		Saga.NpcGiveItem(cid, 4225, 1);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end

	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Deliver toy to Yan
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1181);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1181 then
		Saga.GeneralDialog(cid, 4658);

		local ItemCountA = Saga.CheckUserInventory(cid, 4225);
		if ItemCountA > 0 then
			Saga.NpcTakeItem(cid, 4225, 1);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.ItemNotFound(cid);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end


function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	local StepID = CurStepID;
	
	if CurStepID == 41801 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 41802 then
		ret = QUEST_STEP_2(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
