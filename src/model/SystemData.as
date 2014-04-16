package model
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	public class SystemData extends Entity
	{
		public var secrets_chat:Object;
	    public var assets:Object;
		public var secrets:Object;
		public var trashtalking:Array;
		public var command:Object;
		public var date_response:Object;
		public var chat_lenus:Object;
		public var chat_sirena:Object;
		public var chat_dea:Object;
		public var chat_sao:Object;
		public var chat_klaire:Object;
		public var chat_tomoru:Object;
		public var chat_ceil:Object;
		public var chat_zack:Object;
		public var cpu_teams:Object; 
		public var skillsys:Object;
		public var blackmarket:Object;
		public var commander_items:Object;
		public function SystemData()
		{
			this.publicAccess=Access.READ;
			/*var skillsys:Object={
				"f0":
				{
				   "agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				}
				,
				"f1":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_SPDragon","se":-10,"area":1
				},
				"f2":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"F_Kick","se":-10,"area":2
				},
				"f3":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"F_SPTornado","se":-10,"area":0
				},
				"f4":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"f5":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"w0":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				}
				,
				"w1":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":1
				},
				"w2":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":2
				},
				"w3":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"w4":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"w5":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"e0":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"e1":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":1
				},
				"e2":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":2
				},
				"e3":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"e4":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"e5":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"a0":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"a1":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":1
				},
				"a2":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":2
				},
				"a3":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"a4":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"a5":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"n0":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				}
				,
				"n1":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":1
				},
				"n2":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":2
				},
				"n3":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"n4":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				},
				"n5":
				{
					"agi":25,"atk":5,"ele":"fire","def":5,"label":"A_Punch","se":-10,"area":0
				}
				
			}*/
		}
		public function _cpuTeams():void
		{
			/* create data
			var id: String;
			var teams: Object = new Object();
			for (var t: uint = 0; t < 8; t++)
			{
				var team: Object = new Object();
				for (var i: uint = 0; i < 8; i++)
				{
					id = "t" + t + "_" + i;
					team.atk = 10;
					team.se=100;
					team.def = 10;
					team.agi = 10;
					team.ele="";
					teams[id]= team;
					//trace(id)
			        trace(id,":",JSON.stringify(team),",");
				}
				
				
				
			}
			*/
		 
			
			
			var teams:Object={
				t0_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t0_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t1_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t2_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t3_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t4_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t5_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t6_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t7_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t8_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_0 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_1 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_2 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_3 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_4 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_5 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_6 : {"atk":10,"agi":10,"label":"A_Punch","def":10} ,
				t9_7 : {"atk":10,"agi":10,"label":"A_Punch","def":10} 

			}
			
		}
	}
}