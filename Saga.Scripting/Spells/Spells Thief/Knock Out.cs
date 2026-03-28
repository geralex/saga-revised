using Saga.PrimaryTypes;

namespace Saga.Skills
{
    static partial class Spelltable
    {
        public static void THIEF_KNOCKOUT(SkillBaseEventArgs bargument)
        {
            int Lvldiff;
			int rand;
            SkillUsageEventArgs.SkillMatrix matrix;
            Actor asource = bargument.Sender as Actor;
            Actor atarget = bargument.Target as Actor;

            if (asource != null && atarget != null && bargument.Context == Saga.Enumarations.SkillContext.SkillUse)
            {
                SkillUsageEventArgs arguments = (SkillUsageEventArgs)bargument;
                matrix = arguments.GetDefaultSkillMatrix(asource, atarget);
                Lvldiff = arguments.GetCappedLevelDifference(matrix);
				rand = (10 * arguments.SkillLevel);
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
                    arguments.DoLpIncrease(asource); // LP Increase
                    arguments.Damage = arguments.GetDamage(matrix);
                    arguments.Damage = arguments.GetDefenseReduction(matrix, arguments.Damage);
                    arguments.IsCritical(matrix);
					if(arguments.SkillRand(rand)) // 10% x SkillLVL chance
						Common.Skills.UpdateAddition(atarget, arguments.Addition, 5000); // Stun. TODO: Knock Out stat.
                }
            }
            else
            {
                bargument.Failed = true;
            }
        }
    }
}