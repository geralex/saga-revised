using Saga.PrimaryTypes;

namespace Saga.Skills
{
    static partial class Spelltable
    {
        public static void THIEF_TEARINGWOUND(SkillBaseEventArgs bargument)
        {
            int Lvldiff;
			int rand;
			uint aID;
            SkillUsageEventArgs.SkillMatrix matrix;
            Actor asource = bargument.Sender as Actor;
            Actor atarget = bargument.Target as Actor;

            if (asource != null && atarget != null && bargument.Context == Saga.Enumarations.SkillContext.SkillUse)
            {
                SkillUsageEventArgs arguments = (SkillUsageEventArgs)bargument;
                matrix = arguments.GetDefaultSkillMatrix(asource, atarget);
                Lvldiff = arguments.GetCappedLevelDifference(matrix);
				rand = (15 * arguments.SkillLevel);
				aID = (uint)( 50551200 + arguments.SkillLevel );
                matrix[1, 2] = (int)((double)(matrix[1, 2]) * (double)(0.7 + 0.05 * arguments.SkillLevel));
                matrix[2, 3] = (int)((double)(matrix[2, 3]) * (double)(1.3 + 0.05 * arguments.SkillLevel));
                matrix[4, 3] += (Lvldiff * 120);

                if (arguments.IsMissed(matrix) || arguments.IsBlocked(matrix))
                {
                    return;
                }
                else
                {
                    arguments.CanCheckEquipmentDurabillity = true;
                    arguments.CanCheckWeaponDurabillity = true;
                    arguments.DoLpIncrease(asource);
                    arguments.Damage = arguments.GetDamage(matrix);
                    arguments.Damage = arguments.GetDefenseReduction(matrix, arguments.Damage);
                    arguments.IsCritical(matrix);
					if(arguments.SkillRand(rand)) // 15% x SkillLVL chance
						Common.Skills.UpdateAddition(atarget, (uint)aID, 10000); // Bleeding
                }
            }
            else
            {
                bargument.Failed = true;
            }
        }
    }
}