-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 399;
local ReqClv = 1;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 6;
local RewCxp = 5;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 2030000;
local RewItem2 = 0;
local RewItemCount1 = 1;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points

	Saga.AddStep(cid, QuestID, 39901);
	Saga.AddStep(cid, QuestID, 39902);
	Saga.InsertQuest(cid, QuestID, 1);

	return 0;
end

function QUEST_FINISH(cid)
	-- Handout all rewards

	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk to Sally
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1147);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1147 then
		Saga.GeneralDialog(cid, 3939);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
		Saga.NpcGiveItem(cid, 4071, 1);
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
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Bring juice to Whitney
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1148);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1148 then
		Saga.GeneralDialog(cid, 3942);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
		Saga.NpcTakeItem(cid, 4071, 1);
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
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	local StepID = CurStepID;

	if CurStepID == 39901 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 39902 then
		ret = QUEST_STEP_2(cid, StepID);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end
