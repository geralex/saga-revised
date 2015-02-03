-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM
--Spanner 7/26/08

local QuestID = 123;
local ReqClv = 7;
local ReqJlv = 0;
local NextQuest = 342;
local RewZeny = 187;
local RewCxp = 132;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 6;
local RewItemCount2 = 0;

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 12301);
	Saga.AddStep(cid, QuestID, 12302);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end
function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
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
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1001);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1001 then
		Saga.GeneralDialog(cid, 1813);
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
	--Talk with Scacciano Morrigan
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1003);
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003
	then
	Saga.GeneralDialog(cid, 1818);
	Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end

	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false
	then
	return -1;
	end
	end
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

	if CurStepID == 12301 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 12302 then
		ret = QUEST_STEP_2(cid, StepID);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end

