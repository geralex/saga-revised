-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 385;
local ReqClv = 19;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 791;
local RewCxp = 2820;
local RewJxp = 1140;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 4;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 38501);
	Saga.AddStep(cid, QuestID, 38502);
	Saga.AddStep(cid, QuestID, 38503);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Talk to ?
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1223);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1223 then
		Saga.GeneralDialog(cid, 3814);
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
	-- Capture a Chonchon Steel (8)
  	Saga.FindQuestItem(cid, QuestID, StepID, 10149, 4083, 10000, 8, 1);
  	Saga.FindQuestItem(cid, QuestID, StepID, 10150, 4083, 10000, 8, 1);
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid, StepID)
	-- Deliver item to Teesin Mayor
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1223);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1223 then
		Saga.GeneralDialog(cid, 3819);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4083);
		if ItemCountA > 7 then
			Saga.NpcTakeItem(cid, 4083, 8);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
	end
	
	-- Check if all substeps are completed
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
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local StepID = CurStepID;
	local ret = -1;

	if CurStepID == 38501 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 38502 then
		ret = QUEST_STEP_2(cid, StepID);
	elseif CurStepID == 38503 then
		ret = QUEST_STEP_3(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
