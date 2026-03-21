{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns -Wno-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module CMM.Par
  ( happyError
  , myLexer
  , pProgram
  , pDef
  , pListDef
  , pArg
  , pListArg
  , pStm
  , pListStm
  , pExp6
  , pExp5
  , pExp4
  , pExp3
  , pExp2
  , pExp1
  , pExp
  , pListExp
  , pIncDecOp
  , pMulOp
  , pAddOp
  , pCmpOp
  , pBoolLit
  , pType
  , pListId
  ) where

import Prelude

import qualified CMM.Abs
import CMM.Lex
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn25 (Double)
	| HappyAbsSyn26 (Integer)
	| HappyAbsSyn27 (CMM.Abs.Id)
	| HappyAbsSyn28 (CMM.Abs.Program)
	| HappyAbsSyn29 (CMM.Abs.Def)
	| HappyAbsSyn30 ([CMM.Abs.Def])
	| HappyAbsSyn31 (CMM.Abs.Arg)
	| HappyAbsSyn32 ([CMM.Abs.Arg])
	| HappyAbsSyn33 (CMM.Abs.Stm)
	| HappyAbsSyn34 ([CMM.Abs.Stm])
	| HappyAbsSyn35 (CMM.Abs.Exp)
	| HappyAbsSyn42 ([CMM.Abs.Exp])
	| HappyAbsSyn43 (CMM.Abs.IncDecOp)
	| HappyAbsSyn44 (CMM.Abs.MulOp)
	| HappyAbsSyn45 (CMM.Abs.AddOp)
	| HappyAbsSyn46 (CMM.Abs.CmpOp)
	| HappyAbsSyn47 (CMM.Abs.BoolLit)
	| HappyAbsSyn48 (CMM.Abs.Type)
	| HappyAbsSyn49 ([CMM.Abs.Id])

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163 :: () => Prelude.Int -> ({-HappyReduction (Err) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86 :: () => ({-HappyReduction (Err) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,634) ([0,0,0,0,2328,0,0,0,0,35840,4,0,0,0,0,582,0,0,0,0,8960,1,0,0,0,32768,145,0,0,0,9280,65216,497,0,0,8192,24594,63743,0,0,0,2320,2176,112,0,0,34816,16388,14340,0,0,0,580,544,28,0,0,8704,4097,3585,0,0,0,145,136,7,0,0,18560,17408,896,0,0,16384,36,49186,1,0,0,4640,4352,224,0,0,0,9,0,0,0,0,2080,0,0,0,0,8192,1,0,0,0,32768,55296,1,0,0,0,0,34816,0,0,0,0,32768,145,0,0,0,0,0,256,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9280,4,0,0,0,0,0,0,0,0,0,4160,0,0,0,0,16896,1890,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,2048,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,1160,1088,56,0,0,0,0,0,0,0,0,0,0,0,0,0,37120,0,0,0,0,0,0,1024,0,0,0,32,0,0,0,0,0,0,0,0,0,0,1152,0,0,0,0,8192,8,0,0,0,0,0,0,0,0,0,8704,62977,3983,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,32,0,0,0,0,4096,32777,28680,0,0,0,8,0,0,0,0,17408,60418,7967,0,0,0,290,272,14,0,0,0,0,4,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,1164,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,582,0,0,0,37120,64256,1991,0,0,0,256,0,0,0,0,0,0,4,0,0,8192,18,57361,0,0,0,8192,0,0,0,0,34816,16388,14340,0,0,0,16512,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,36,49186,1,0,0,4640,4352,224,0,0,4096,32777,28680,0,0,0,1160,1088,56,0,0,0,0,0,0,0,0,290,272,14,0,0,512,0,0,0,0,0,0,0,0,0,0,9280,8704,448,0,0,8192,18,57361,0,0,0,2320,2176,112,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,4096,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,72,32836,3,0,0,128,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,37248,0,0,0,32768,0,0,0,0,0,0,0,4,0,0,4096,45065,31871,0,0,0,1160,16344,62,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,16384,0,0,0,34816,55300,15935,0,0,0,0,1164,0,0,0,8704,62977,3983,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,1024,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,8192,0,0,0,17408,60418,7967,0,0,0,0,8192,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","%start_pDef","%start_pListDef","%start_pArg","%start_pListArg","%start_pStm","%start_pListStm","%start_pExp6","%start_pExp5","%start_pExp4","%start_pExp3","%start_pExp2","%start_pExp1","%start_pExp","%start_pListExp","%start_pIncDecOp","%start_pMulOp","%start_pAddOp","%start_pCmpOp","%start_pBoolLit","%start_pType","%start_pListId","Double","Integer","Id","Program","Def","ListDef","Arg","ListArg","Stm","ListStm","Exp6","Exp5","Exp4","Exp3","Exp2","Exp1","Exp","ListExp","IncDecOp","MulOp","AddOp","CmpOp","BoolLit","Type","ListId","'!='","'&&'","'('","')'","'*'","'+'","'++'","','","'-'","'--'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'bool'","'double'","'else'","'false'","'if'","'int'","'return'","'true'","'void'","'while'","'{'","'||'","'}'","'catch'","'throw'","'try'","L_doubl","L_integ","L_Id","%eof"]
        bit_start = st Prelude.* 87
        bit_end = (st Prelude.+ 1) Prelude.* 87
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..86]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (68) = happyShift action_28
action_0 (69) = happyShift action_29
action_0 (73) = happyShift action_30
action_0 (76) = happyShift action_31
action_0 (28) = happyGoto action_93
action_0 (29) = happyGoto action_89
action_0 (30) = happyGoto action_94
action_0 (48) = happyGoto action_91
action_0 _ = happyReduce_27

action_1 (68) = happyShift action_28
action_1 (69) = happyShift action_29
action_1 (73) = happyShift action_30
action_1 (76) = happyShift action_31
action_1 (29) = happyGoto action_92
action_1 (48) = happyGoto action_91
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (68) = happyShift action_28
action_2 (69) = happyShift action_29
action_2 (73) = happyShift action_30
action_2 (76) = happyShift action_31
action_2 (29) = happyGoto action_89
action_2 (30) = happyGoto action_90
action_2 (48) = happyGoto action_91
action_2 _ = happyReduce_27

action_3 (68) = happyShift action_28
action_3 (69) = happyShift action_29
action_3 (73) = happyShift action_30
action_3 (76) = happyShift action_31
action_3 (31) = happyGoto action_88
action_3 (48) = happyGoto action_87
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (68) = happyShift action_28
action_4 (69) = happyShift action_29
action_4 (73) = happyShift action_30
action_4 (76) = happyShift action_31
action_4 (31) = happyGoto action_85
action_4 (32) = happyGoto action_86
action_4 (48) = happyGoto action_87
action_4 _ = happyReduce_30

action_5 (52) = happyShift action_64
action_5 (56) = happyShift action_49
action_5 (59) = happyShift action_50
action_5 (68) = happyShift action_28
action_5 (69) = happyShift action_29
action_5 (71) = happyShift action_33
action_5 (72) = happyShift action_78
action_5 (73) = happyShift action_30
action_5 (74) = happyShift action_79
action_5 (75) = happyShift action_34
action_5 (76) = happyShift action_31
action_5 (77) = happyShift action_80
action_5 (78) = happyShift action_81
action_5 (82) = happyShift action_82
action_5 (83) = happyShift action_83
action_5 (84) = happyShift action_23
action_5 (85) = happyShift action_65
action_5 (86) = happyShift action_26
action_5 (25) = happyGoto action_51
action_5 (26) = happyGoto action_52
action_5 (27) = happyGoto action_53
action_5 (33) = happyGoto action_84
action_5 (35) = happyGoto action_54
action_5 (36) = happyGoto action_55
action_5 (37) = happyGoto action_56
action_5 (38) = happyGoto action_57
action_5 (39) = happyGoto action_58
action_5 (40) = happyGoto action_59
action_5 (41) = happyGoto action_76
action_5 (43) = happyGoto action_62
action_5 (47) = happyGoto action_63
action_5 (48) = happyGoto action_77
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (52) = happyShift action_64
action_6 (56) = happyShift action_49
action_6 (59) = happyShift action_50
action_6 (68) = happyShift action_28
action_6 (69) = happyShift action_29
action_6 (71) = happyShift action_33
action_6 (72) = happyShift action_78
action_6 (73) = happyShift action_30
action_6 (74) = happyShift action_79
action_6 (75) = happyShift action_34
action_6 (76) = happyShift action_31
action_6 (77) = happyShift action_80
action_6 (78) = happyShift action_81
action_6 (82) = happyShift action_82
action_6 (83) = happyShift action_83
action_6 (84) = happyShift action_23
action_6 (85) = happyShift action_65
action_6 (86) = happyShift action_26
action_6 (25) = happyGoto action_51
action_6 (26) = happyGoto action_52
action_6 (27) = happyGoto action_53
action_6 (33) = happyGoto action_74
action_6 (34) = happyGoto action_75
action_6 (35) = happyGoto action_54
action_6 (36) = happyGoto action_55
action_6 (37) = happyGoto action_56
action_6 (38) = happyGoto action_57
action_6 (39) = happyGoto action_58
action_6 (40) = happyGoto action_59
action_6 (41) = happyGoto action_76
action_6 (43) = happyGoto action_62
action_6 (47) = happyGoto action_63
action_6 (48) = happyGoto action_77
action_6 _ = happyReduce_42

action_7 (52) = happyShift action_64
action_7 (56) = happyShift action_49
action_7 (59) = happyShift action_50
action_7 (71) = happyShift action_33
action_7 (75) = happyShift action_34
action_7 (84) = happyShift action_23
action_7 (85) = happyShift action_65
action_7 (86) = happyShift action_26
action_7 (25) = happyGoto action_51
action_7 (26) = happyGoto action_52
action_7 (27) = happyGoto action_67
action_7 (35) = happyGoto action_73
action_7 (43) = happyGoto action_62
action_7 (47) = happyGoto action_63
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (52) = happyShift action_64
action_8 (56) = happyShift action_49
action_8 (59) = happyShift action_50
action_8 (71) = happyShift action_33
action_8 (75) = happyShift action_34
action_8 (84) = happyShift action_23
action_8 (85) = happyShift action_65
action_8 (86) = happyShift action_26
action_8 (25) = happyGoto action_51
action_8 (26) = happyGoto action_52
action_8 (27) = happyGoto action_67
action_8 (35) = happyGoto action_54
action_8 (36) = happyGoto action_72
action_8 (43) = happyGoto action_62
action_8 (47) = happyGoto action_63
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (52) = happyShift action_64
action_9 (56) = happyShift action_49
action_9 (59) = happyShift action_50
action_9 (71) = happyShift action_33
action_9 (75) = happyShift action_34
action_9 (84) = happyShift action_23
action_9 (85) = happyShift action_65
action_9 (86) = happyShift action_26
action_9 (25) = happyGoto action_51
action_9 (26) = happyGoto action_52
action_9 (27) = happyGoto action_67
action_9 (35) = happyGoto action_54
action_9 (36) = happyGoto action_55
action_9 (37) = happyGoto action_71
action_9 (43) = happyGoto action_62
action_9 (47) = happyGoto action_63
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (52) = happyShift action_64
action_10 (56) = happyShift action_49
action_10 (59) = happyShift action_50
action_10 (71) = happyShift action_33
action_10 (75) = happyShift action_34
action_10 (84) = happyShift action_23
action_10 (85) = happyShift action_65
action_10 (86) = happyShift action_26
action_10 (25) = happyGoto action_51
action_10 (26) = happyGoto action_52
action_10 (27) = happyGoto action_67
action_10 (35) = happyGoto action_54
action_10 (36) = happyGoto action_55
action_10 (37) = happyGoto action_56
action_10 (38) = happyGoto action_70
action_10 (43) = happyGoto action_62
action_10 (47) = happyGoto action_63
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (52) = happyShift action_64
action_11 (56) = happyShift action_49
action_11 (59) = happyShift action_50
action_11 (71) = happyShift action_33
action_11 (75) = happyShift action_34
action_11 (84) = happyShift action_23
action_11 (85) = happyShift action_65
action_11 (86) = happyShift action_26
action_11 (25) = happyGoto action_51
action_11 (26) = happyGoto action_52
action_11 (27) = happyGoto action_67
action_11 (35) = happyGoto action_54
action_11 (36) = happyGoto action_55
action_11 (37) = happyGoto action_56
action_11 (38) = happyGoto action_57
action_11 (39) = happyGoto action_69
action_11 (43) = happyGoto action_62
action_11 (47) = happyGoto action_63
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (52) = happyShift action_64
action_12 (56) = happyShift action_49
action_12 (59) = happyShift action_50
action_12 (71) = happyShift action_33
action_12 (75) = happyShift action_34
action_12 (84) = happyShift action_23
action_12 (85) = happyShift action_65
action_12 (86) = happyShift action_26
action_12 (25) = happyGoto action_51
action_12 (26) = happyGoto action_52
action_12 (27) = happyGoto action_67
action_12 (35) = happyGoto action_54
action_12 (36) = happyGoto action_55
action_12 (37) = happyGoto action_56
action_12 (38) = happyGoto action_57
action_12 (39) = happyGoto action_58
action_12 (40) = happyGoto action_68
action_12 (43) = happyGoto action_62
action_12 (47) = happyGoto action_63
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (52) = happyShift action_64
action_13 (56) = happyShift action_49
action_13 (59) = happyShift action_50
action_13 (71) = happyShift action_33
action_13 (75) = happyShift action_34
action_13 (84) = happyShift action_23
action_13 (85) = happyShift action_65
action_13 (86) = happyShift action_26
action_13 (25) = happyGoto action_51
action_13 (26) = happyGoto action_52
action_13 (27) = happyGoto action_53
action_13 (35) = happyGoto action_54
action_13 (36) = happyGoto action_55
action_13 (37) = happyGoto action_56
action_13 (38) = happyGoto action_57
action_13 (39) = happyGoto action_58
action_13 (40) = happyGoto action_59
action_13 (41) = happyGoto action_66
action_13 (43) = happyGoto action_62
action_13 (47) = happyGoto action_63
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (52) = happyShift action_64
action_14 (56) = happyShift action_49
action_14 (59) = happyShift action_50
action_14 (71) = happyShift action_33
action_14 (75) = happyShift action_34
action_14 (84) = happyShift action_23
action_14 (85) = happyShift action_65
action_14 (86) = happyShift action_26
action_14 (25) = happyGoto action_51
action_14 (26) = happyGoto action_52
action_14 (27) = happyGoto action_53
action_14 (35) = happyGoto action_54
action_14 (36) = happyGoto action_55
action_14 (37) = happyGoto action_56
action_14 (38) = happyGoto action_57
action_14 (39) = happyGoto action_58
action_14 (40) = happyGoto action_59
action_14 (41) = happyGoto action_60
action_14 (42) = happyGoto action_61
action_14 (43) = happyGoto action_62
action_14 (47) = happyGoto action_63
action_14 _ = happyReduce_64

action_15 (56) = happyShift action_49
action_15 (59) = happyShift action_50
action_15 (43) = happyGoto action_48
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (54) = happyShift action_46
action_16 (60) = happyShift action_47
action_16 (44) = happyGoto action_45
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (55) = happyShift action_43
action_17 (58) = happyShift action_44
action_17 (45) = happyGoto action_42
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (50) = happyShift action_36
action_18 (62) = happyShift action_37
action_18 (63) = happyShift action_38
action_18 (65) = happyShift action_39
action_18 (66) = happyShift action_40
action_18 (67) = happyShift action_41
action_18 (46) = happyGoto action_35
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (71) = happyShift action_33
action_19 (75) = happyShift action_34
action_19 (47) = happyGoto action_32
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (68) = happyShift action_28
action_20 (69) = happyShift action_29
action_20 (73) = happyShift action_30
action_20 (76) = happyShift action_31
action_20 (48) = happyGoto action_27
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (86) = happyShift action_26
action_21 (27) = happyGoto action_24
action_21 (49) = happyGoto action_25
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (84) = happyShift action_23
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_22

action_24 (57) = happyShift action_120
action_24 _ = happyReduce_85

action_25 (87) = happyAccept
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_24

action_27 (87) = happyAccept
action_27 _ = happyFail (happyExpListPerState 27)

action_28 _ = happyReduce_81

action_29 _ = happyReduce_83

action_30 _ = happyReduce_82

action_31 _ = happyReduce_84

action_32 (87) = happyAccept
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_80

action_34 _ = happyReduce_79

action_35 (87) = happyAccept
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_78

action_37 _ = happyReduce_73

action_38 _ = happyReduce_75

action_39 _ = happyReduce_77

action_40 _ = happyReduce_74

action_41 _ = happyReduce_76

action_42 (87) = happyAccept
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_71

action_44 _ = happyReduce_72

action_45 (87) = happyAccept
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_69

action_47 _ = happyReduce_70

action_48 (87) = happyAccept
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_67

action_50 _ = happyReduce_68

action_51 _ = happyReduce_46

action_52 _ = happyReduce_45

action_53 (52) = happyShift action_114
action_53 (56) = happyShift action_49
action_53 (59) = happyShift action_50
action_53 (64) = happyShift action_119
action_53 (43) = happyGoto action_113
action_53 _ = happyReduce_47

action_54 _ = happyReduce_53

action_55 (54) = happyShift action_46
action_55 (60) = happyShift action_47
action_55 (44) = happyGoto action_109
action_55 _ = happyReduce_55

action_56 (50) = happyShift action_36
action_56 (55) = happyShift action_43
action_56 (58) = happyShift action_44
action_56 (62) = happyShift action_37
action_56 (63) = happyShift action_38
action_56 (65) = happyShift action_39
action_56 (66) = happyShift action_40
action_56 (67) = happyShift action_41
action_56 (45) = happyGoto action_110
action_56 (46) = happyGoto action_118
action_56 _ = happyReduce_57

action_57 _ = happyReduce_59

action_58 (51) = happyShift action_111
action_58 _ = happyReduce_61

action_59 (79) = happyShift action_112
action_59 _ = happyReduce_63

action_60 (57) = happyShift action_117
action_60 _ = happyReduce_65

action_61 (87) = happyAccept
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (86) = happyShift action_26
action_62 (27) = happyGoto action_116
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_44

action_64 (52) = happyShift action_64
action_64 (56) = happyShift action_49
action_64 (59) = happyShift action_50
action_64 (71) = happyShift action_33
action_64 (75) = happyShift action_34
action_64 (84) = happyShift action_23
action_64 (85) = happyShift action_65
action_64 (86) = happyShift action_26
action_64 (25) = happyGoto action_51
action_64 (26) = happyGoto action_52
action_64 (27) = happyGoto action_53
action_64 (35) = happyGoto action_54
action_64 (36) = happyGoto action_55
action_64 (37) = happyGoto action_56
action_64 (38) = happyGoto action_57
action_64 (39) = happyGoto action_58
action_64 (40) = happyGoto action_59
action_64 (41) = happyGoto action_115
action_64 (43) = happyGoto action_62
action_64 (47) = happyGoto action_63
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_23

action_66 (87) = happyAccept
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (52) = happyShift action_114
action_67 (56) = happyShift action_49
action_67 (59) = happyShift action_50
action_67 (43) = happyGoto action_113
action_67 _ = happyReduce_47

action_68 (79) = happyShift action_112
action_68 (87) = happyAccept
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (51) = happyShift action_111
action_69 (87) = happyAccept
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (87) = happyAccept
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (55) = happyShift action_43
action_71 (58) = happyShift action_44
action_71 (87) = happyAccept
action_71 (45) = happyGoto action_110
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (54) = happyShift action_46
action_72 (60) = happyShift action_47
action_72 (87) = happyAccept
action_72 (44) = happyGoto action_109
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (87) = happyAccept
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (52) = happyShift action_64
action_74 (56) = happyShift action_49
action_74 (59) = happyShift action_50
action_74 (68) = happyShift action_28
action_74 (69) = happyShift action_29
action_74 (71) = happyShift action_33
action_74 (72) = happyShift action_78
action_74 (73) = happyShift action_30
action_74 (74) = happyShift action_79
action_74 (75) = happyShift action_34
action_74 (76) = happyShift action_31
action_74 (77) = happyShift action_80
action_74 (78) = happyShift action_81
action_74 (82) = happyShift action_82
action_74 (83) = happyShift action_83
action_74 (84) = happyShift action_23
action_74 (85) = happyShift action_65
action_74 (86) = happyShift action_26
action_74 (25) = happyGoto action_51
action_74 (26) = happyGoto action_52
action_74 (27) = happyGoto action_53
action_74 (33) = happyGoto action_74
action_74 (34) = happyGoto action_108
action_74 (35) = happyGoto action_54
action_74 (36) = happyGoto action_55
action_74 (37) = happyGoto action_56
action_74 (38) = happyGoto action_57
action_74 (39) = happyGoto action_58
action_74 (40) = happyGoto action_59
action_74 (41) = happyGoto action_76
action_74 (43) = happyGoto action_62
action_74 (47) = happyGoto action_63
action_74 (48) = happyGoto action_77
action_74 _ = happyReduce_42

action_75 (87) = happyAccept
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (61) = happyShift action_107
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (86) = happyShift action_26
action_77 (27) = happyGoto action_105
action_77 (49) = happyGoto action_106
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (52) = happyShift action_104
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (52) = happyShift action_64
action_79 (56) = happyShift action_49
action_79 (59) = happyShift action_50
action_79 (71) = happyShift action_33
action_79 (75) = happyShift action_34
action_79 (84) = happyShift action_23
action_79 (85) = happyShift action_65
action_79 (86) = happyShift action_26
action_79 (25) = happyGoto action_51
action_79 (26) = happyGoto action_52
action_79 (27) = happyGoto action_53
action_79 (35) = happyGoto action_54
action_79 (36) = happyGoto action_55
action_79 (37) = happyGoto action_56
action_79 (38) = happyGoto action_57
action_79 (39) = happyGoto action_58
action_79 (40) = happyGoto action_59
action_79 (41) = happyGoto action_103
action_79 (43) = happyGoto action_62
action_79 (47) = happyGoto action_63
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (52) = happyShift action_102
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (52) = happyShift action_64
action_81 (56) = happyShift action_49
action_81 (59) = happyShift action_50
action_81 (68) = happyShift action_28
action_81 (69) = happyShift action_29
action_81 (71) = happyShift action_33
action_81 (72) = happyShift action_78
action_81 (73) = happyShift action_30
action_81 (74) = happyShift action_79
action_81 (75) = happyShift action_34
action_81 (76) = happyShift action_31
action_81 (77) = happyShift action_80
action_81 (78) = happyShift action_81
action_81 (82) = happyShift action_82
action_81 (83) = happyShift action_83
action_81 (84) = happyShift action_23
action_81 (85) = happyShift action_65
action_81 (86) = happyShift action_26
action_81 (25) = happyGoto action_51
action_81 (26) = happyGoto action_52
action_81 (27) = happyGoto action_53
action_81 (33) = happyGoto action_74
action_81 (34) = happyGoto action_101
action_81 (35) = happyGoto action_54
action_81 (36) = happyGoto action_55
action_81 (37) = happyGoto action_56
action_81 (38) = happyGoto action_57
action_81 (39) = happyGoto action_58
action_81 (40) = happyGoto action_59
action_81 (41) = happyGoto action_76
action_81 (43) = happyGoto action_62
action_81 (47) = happyGoto action_63
action_81 (48) = happyGoto action_77
action_81 _ = happyReduce_42

action_82 (52) = happyShift action_64
action_82 (56) = happyShift action_49
action_82 (59) = happyShift action_50
action_82 (71) = happyShift action_33
action_82 (75) = happyShift action_34
action_82 (84) = happyShift action_23
action_82 (85) = happyShift action_65
action_82 (86) = happyShift action_26
action_82 (25) = happyGoto action_51
action_82 (26) = happyGoto action_52
action_82 (27) = happyGoto action_53
action_82 (35) = happyGoto action_54
action_82 (36) = happyGoto action_55
action_82 (37) = happyGoto action_56
action_82 (38) = happyGoto action_57
action_82 (39) = happyGoto action_58
action_82 (40) = happyGoto action_59
action_82 (41) = happyGoto action_100
action_82 (43) = happyGoto action_62
action_82 (47) = happyGoto action_63
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (78) = happyShift action_99
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (87) = happyAccept
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (57) = happyShift action_98
action_85 _ = happyReduce_31

action_86 (87) = happyAccept
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (86) = happyShift action_26
action_87 (27) = happyGoto action_97
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (87) = happyAccept
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (68) = happyShift action_28
action_89 (69) = happyShift action_29
action_89 (73) = happyShift action_30
action_89 (76) = happyShift action_31
action_89 (29) = happyGoto action_89
action_89 (30) = happyGoto action_96
action_89 (48) = happyGoto action_91
action_89 _ = happyReduce_27

action_90 (87) = happyAccept
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (86) = happyShift action_26
action_91 (27) = happyGoto action_95
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (87) = happyAccept
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (87) = happyAccept
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_25

action_95 (52) = happyShift action_140
action_95 _ = happyFail (happyExpListPerState 95)

action_96 _ = happyReduce_28

action_97 _ = happyReduce_29

action_98 (68) = happyShift action_28
action_98 (69) = happyShift action_29
action_98 (73) = happyShift action_30
action_98 (76) = happyShift action_31
action_98 (31) = happyGoto action_85
action_98 (32) = happyGoto action_139
action_98 (48) = happyGoto action_87
action_98 _ = happyReduce_30

action_99 (52) = happyShift action_64
action_99 (56) = happyShift action_49
action_99 (59) = happyShift action_50
action_99 (68) = happyShift action_28
action_99 (69) = happyShift action_29
action_99 (71) = happyShift action_33
action_99 (72) = happyShift action_78
action_99 (73) = happyShift action_30
action_99 (74) = happyShift action_79
action_99 (75) = happyShift action_34
action_99 (76) = happyShift action_31
action_99 (77) = happyShift action_80
action_99 (78) = happyShift action_81
action_99 (82) = happyShift action_82
action_99 (83) = happyShift action_83
action_99 (84) = happyShift action_23
action_99 (85) = happyShift action_65
action_99 (86) = happyShift action_26
action_99 (25) = happyGoto action_51
action_99 (26) = happyGoto action_52
action_99 (27) = happyGoto action_53
action_99 (33) = happyGoto action_74
action_99 (34) = happyGoto action_138
action_99 (35) = happyGoto action_54
action_99 (36) = happyGoto action_55
action_99 (37) = happyGoto action_56
action_99 (38) = happyGoto action_57
action_99 (39) = happyGoto action_58
action_99 (40) = happyGoto action_59
action_99 (41) = happyGoto action_76
action_99 (43) = happyGoto action_62
action_99 (47) = happyGoto action_63
action_99 (48) = happyGoto action_77
action_99 _ = happyReduce_42

action_100 (61) = happyShift action_137
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (80) = happyShift action_136
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (52) = happyShift action_64
action_102 (56) = happyShift action_49
action_102 (59) = happyShift action_50
action_102 (71) = happyShift action_33
action_102 (75) = happyShift action_34
action_102 (84) = happyShift action_23
action_102 (85) = happyShift action_65
action_102 (86) = happyShift action_26
action_102 (25) = happyGoto action_51
action_102 (26) = happyGoto action_52
action_102 (27) = happyGoto action_53
action_102 (35) = happyGoto action_54
action_102 (36) = happyGoto action_55
action_102 (37) = happyGoto action_56
action_102 (38) = happyGoto action_57
action_102 (39) = happyGoto action_58
action_102 (40) = happyGoto action_59
action_102 (41) = happyGoto action_135
action_102 (43) = happyGoto action_62
action_102 (47) = happyGoto action_63
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (61) = happyShift action_134
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (52) = happyShift action_64
action_104 (56) = happyShift action_49
action_104 (59) = happyShift action_50
action_104 (71) = happyShift action_33
action_104 (75) = happyShift action_34
action_104 (84) = happyShift action_23
action_104 (85) = happyShift action_65
action_104 (86) = happyShift action_26
action_104 (25) = happyGoto action_51
action_104 (26) = happyGoto action_52
action_104 (27) = happyGoto action_53
action_104 (35) = happyGoto action_54
action_104 (36) = happyGoto action_55
action_104 (37) = happyGoto action_56
action_104 (38) = happyGoto action_57
action_104 (39) = happyGoto action_58
action_104 (40) = happyGoto action_59
action_104 (41) = happyGoto action_133
action_104 (43) = happyGoto action_62
action_104 (47) = happyGoto action_63
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (57) = happyShift action_120
action_105 (64) = happyShift action_132
action_105 _ = happyReduce_85

action_106 (61) = happyShift action_131
action_106 _ = happyFail (happyExpListPerState 106)

action_107 _ = happyReduce_33

action_108 _ = happyReduce_43

action_109 (52) = happyShift action_64
action_109 (56) = happyShift action_49
action_109 (59) = happyShift action_50
action_109 (71) = happyShift action_33
action_109 (75) = happyShift action_34
action_109 (84) = happyShift action_23
action_109 (85) = happyShift action_65
action_109 (86) = happyShift action_26
action_109 (25) = happyGoto action_51
action_109 (26) = happyGoto action_52
action_109 (27) = happyGoto action_67
action_109 (35) = happyGoto action_130
action_109 (43) = happyGoto action_62
action_109 (47) = happyGoto action_63
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (52) = happyShift action_64
action_110 (56) = happyShift action_49
action_110 (59) = happyShift action_50
action_110 (71) = happyShift action_33
action_110 (75) = happyShift action_34
action_110 (84) = happyShift action_23
action_110 (85) = happyShift action_65
action_110 (86) = happyShift action_26
action_110 (25) = happyGoto action_51
action_110 (26) = happyGoto action_52
action_110 (27) = happyGoto action_67
action_110 (35) = happyGoto action_54
action_110 (36) = happyGoto action_129
action_110 (43) = happyGoto action_62
action_110 (47) = happyGoto action_63
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (52) = happyShift action_64
action_111 (56) = happyShift action_49
action_111 (59) = happyShift action_50
action_111 (71) = happyShift action_33
action_111 (75) = happyShift action_34
action_111 (84) = happyShift action_23
action_111 (85) = happyShift action_65
action_111 (86) = happyShift action_26
action_111 (25) = happyGoto action_51
action_111 (26) = happyGoto action_52
action_111 (27) = happyGoto action_67
action_111 (35) = happyGoto action_54
action_111 (36) = happyGoto action_55
action_111 (37) = happyGoto action_56
action_111 (38) = happyGoto action_128
action_111 (43) = happyGoto action_62
action_111 (47) = happyGoto action_63
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (52) = happyShift action_64
action_112 (56) = happyShift action_49
action_112 (59) = happyShift action_50
action_112 (71) = happyShift action_33
action_112 (75) = happyShift action_34
action_112 (84) = happyShift action_23
action_112 (85) = happyShift action_65
action_112 (86) = happyShift action_26
action_112 (25) = happyGoto action_51
action_112 (26) = happyGoto action_52
action_112 (27) = happyGoto action_67
action_112 (35) = happyGoto action_54
action_112 (36) = happyGoto action_55
action_112 (37) = happyGoto action_56
action_112 (38) = happyGoto action_57
action_112 (39) = happyGoto action_127
action_112 (43) = happyGoto action_62
action_112 (47) = happyGoto action_63
action_112 _ = happyFail (happyExpListPerState 112)

action_113 _ = happyReduce_49

action_114 (52) = happyShift action_64
action_114 (56) = happyShift action_49
action_114 (59) = happyShift action_50
action_114 (71) = happyShift action_33
action_114 (75) = happyShift action_34
action_114 (84) = happyShift action_23
action_114 (85) = happyShift action_65
action_114 (86) = happyShift action_26
action_114 (25) = happyGoto action_51
action_114 (26) = happyGoto action_52
action_114 (27) = happyGoto action_53
action_114 (35) = happyGoto action_54
action_114 (36) = happyGoto action_55
action_114 (37) = happyGoto action_56
action_114 (38) = happyGoto action_57
action_114 (39) = happyGoto action_58
action_114 (40) = happyGoto action_59
action_114 (41) = happyGoto action_60
action_114 (42) = happyGoto action_126
action_114 (43) = happyGoto action_62
action_114 (47) = happyGoto action_63
action_114 _ = happyReduce_64

action_115 (53) = happyShift action_125
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_50

action_117 (52) = happyShift action_64
action_117 (56) = happyShift action_49
action_117 (59) = happyShift action_50
action_117 (71) = happyShift action_33
action_117 (75) = happyShift action_34
action_117 (84) = happyShift action_23
action_117 (85) = happyShift action_65
action_117 (86) = happyShift action_26
action_117 (25) = happyGoto action_51
action_117 (26) = happyGoto action_52
action_117 (27) = happyGoto action_53
action_117 (35) = happyGoto action_54
action_117 (36) = happyGoto action_55
action_117 (37) = happyGoto action_56
action_117 (38) = happyGoto action_57
action_117 (39) = happyGoto action_58
action_117 (40) = happyGoto action_59
action_117 (41) = happyGoto action_60
action_117 (42) = happyGoto action_124
action_117 (43) = happyGoto action_62
action_117 (47) = happyGoto action_63
action_117 _ = happyReduce_64

action_118 (52) = happyShift action_64
action_118 (56) = happyShift action_49
action_118 (59) = happyShift action_50
action_118 (71) = happyShift action_33
action_118 (75) = happyShift action_34
action_118 (84) = happyShift action_23
action_118 (85) = happyShift action_65
action_118 (86) = happyShift action_26
action_118 (25) = happyGoto action_51
action_118 (26) = happyGoto action_52
action_118 (27) = happyGoto action_67
action_118 (35) = happyGoto action_54
action_118 (36) = happyGoto action_55
action_118 (37) = happyGoto action_123
action_118 (43) = happyGoto action_62
action_118 (47) = happyGoto action_63
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (52) = happyShift action_64
action_119 (56) = happyShift action_49
action_119 (59) = happyShift action_50
action_119 (71) = happyShift action_33
action_119 (75) = happyShift action_34
action_119 (84) = happyShift action_23
action_119 (85) = happyShift action_65
action_119 (86) = happyShift action_26
action_119 (25) = happyGoto action_51
action_119 (26) = happyGoto action_52
action_119 (27) = happyGoto action_53
action_119 (35) = happyGoto action_54
action_119 (36) = happyGoto action_55
action_119 (37) = happyGoto action_56
action_119 (38) = happyGoto action_57
action_119 (39) = happyGoto action_58
action_119 (40) = happyGoto action_59
action_119 (41) = happyGoto action_122
action_119 (43) = happyGoto action_62
action_119 (47) = happyGoto action_63
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (86) = happyShift action_26
action_120 (27) = happyGoto action_24
action_120 (49) = happyGoto action_121
action_120 _ = happyFail (happyExpListPerState 120)

action_121 _ = happyReduce_86

action_122 _ = happyReduce_62

action_123 (55) = happyShift action_43
action_123 (58) = happyShift action_44
action_123 (45) = happyGoto action_110
action_123 _ = happyReduce_56

action_124 _ = happyReduce_66

action_125 _ = happyReduce_51

action_126 (53) = happyShift action_146
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (51) = happyShift action_111
action_127 _ = happyReduce_60

action_128 _ = happyReduce_58

action_129 (54) = happyShift action_46
action_129 (60) = happyShift action_47
action_129 (44) = happyGoto action_109
action_129 _ = happyReduce_54

action_130 _ = happyReduce_52

action_131 _ = happyReduce_34

action_132 (52) = happyShift action_64
action_132 (56) = happyShift action_49
action_132 (59) = happyShift action_50
action_132 (71) = happyShift action_33
action_132 (75) = happyShift action_34
action_132 (84) = happyShift action_23
action_132 (85) = happyShift action_65
action_132 (86) = happyShift action_26
action_132 (25) = happyGoto action_51
action_132 (26) = happyGoto action_52
action_132 (27) = happyGoto action_53
action_132 (35) = happyGoto action_54
action_132 (36) = happyGoto action_55
action_132 (37) = happyGoto action_56
action_132 (38) = happyGoto action_57
action_132 (39) = happyGoto action_58
action_132 (40) = happyGoto action_59
action_132 (41) = happyGoto action_145
action_132 (43) = happyGoto action_62
action_132 (47) = happyGoto action_63
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (53) = happyShift action_144
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_36

action_135 (53) = happyShift action_143
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_38

action_137 _ = happyReduce_40

action_138 (80) = happyShift action_142
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_32

action_140 (68) = happyShift action_28
action_140 (69) = happyShift action_29
action_140 (73) = happyShift action_30
action_140 (76) = happyShift action_31
action_140 (31) = happyGoto action_85
action_140 (32) = happyGoto action_141
action_140 (48) = happyGoto action_87
action_140 _ = happyReduce_30

action_141 (53) = happyShift action_151
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (81) = happyShift action_150
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (52) = happyShift action_64
action_143 (56) = happyShift action_49
action_143 (59) = happyShift action_50
action_143 (68) = happyShift action_28
action_143 (69) = happyShift action_29
action_143 (71) = happyShift action_33
action_143 (72) = happyShift action_78
action_143 (73) = happyShift action_30
action_143 (74) = happyShift action_79
action_143 (75) = happyShift action_34
action_143 (76) = happyShift action_31
action_143 (77) = happyShift action_80
action_143 (78) = happyShift action_81
action_143 (82) = happyShift action_82
action_143 (83) = happyShift action_83
action_143 (84) = happyShift action_23
action_143 (85) = happyShift action_65
action_143 (86) = happyShift action_26
action_143 (25) = happyGoto action_51
action_143 (26) = happyGoto action_52
action_143 (27) = happyGoto action_53
action_143 (33) = happyGoto action_149
action_143 (35) = happyGoto action_54
action_143 (36) = happyGoto action_55
action_143 (37) = happyGoto action_56
action_143 (38) = happyGoto action_57
action_143 (39) = happyGoto action_58
action_143 (40) = happyGoto action_59
action_143 (41) = happyGoto action_76
action_143 (43) = happyGoto action_62
action_143 (47) = happyGoto action_63
action_143 (48) = happyGoto action_77
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (52) = happyShift action_64
action_144 (56) = happyShift action_49
action_144 (59) = happyShift action_50
action_144 (68) = happyShift action_28
action_144 (69) = happyShift action_29
action_144 (71) = happyShift action_33
action_144 (72) = happyShift action_78
action_144 (73) = happyShift action_30
action_144 (74) = happyShift action_79
action_144 (75) = happyShift action_34
action_144 (76) = happyShift action_31
action_144 (77) = happyShift action_80
action_144 (78) = happyShift action_81
action_144 (82) = happyShift action_82
action_144 (83) = happyShift action_83
action_144 (84) = happyShift action_23
action_144 (85) = happyShift action_65
action_144 (86) = happyShift action_26
action_144 (25) = happyGoto action_51
action_144 (26) = happyGoto action_52
action_144 (27) = happyGoto action_53
action_144 (33) = happyGoto action_148
action_144 (35) = happyGoto action_54
action_144 (36) = happyGoto action_55
action_144 (37) = happyGoto action_56
action_144 (38) = happyGoto action_57
action_144 (39) = happyGoto action_58
action_144 (40) = happyGoto action_59
action_144 (41) = happyGoto action_76
action_144 (43) = happyGoto action_62
action_144 (47) = happyGoto action_63
action_144 (48) = happyGoto action_77
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (61) = happyShift action_147
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_48

action_147 _ = happyReduce_35

action_148 (70) = happyShift action_154
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_37

action_150 (52) = happyShift action_153
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (78) = happyShift action_152
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (52) = happyShift action_64
action_152 (56) = happyShift action_49
action_152 (59) = happyShift action_50
action_152 (68) = happyShift action_28
action_152 (69) = happyShift action_29
action_152 (71) = happyShift action_33
action_152 (72) = happyShift action_78
action_152 (73) = happyShift action_30
action_152 (74) = happyShift action_79
action_152 (75) = happyShift action_34
action_152 (76) = happyShift action_31
action_152 (77) = happyShift action_80
action_152 (78) = happyShift action_81
action_152 (82) = happyShift action_82
action_152 (83) = happyShift action_83
action_152 (84) = happyShift action_23
action_152 (85) = happyShift action_65
action_152 (86) = happyShift action_26
action_152 (25) = happyGoto action_51
action_152 (26) = happyGoto action_52
action_152 (27) = happyGoto action_53
action_152 (33) = happyGoto action_74
action_152 (34) = happyGoto action_157
action_152 (35) = happyGoto action_54
action_152 (36) = happyGoto action_55
action_152 (37) = happyGoto action_56
action_152 (38) = happyGoto action_57
action_152 (39) = happyGoto action_58
action_152 (40) = happyGoto action_59
action_152 (41) = happyGoto action_76
action_152 (43) = happyGoto action_62
action_152 (47) = happyGoto action_63
action_152 (48) = happyGoto action_77
action_152 _ = happyReduce_42

action_153 (68) = happyShift action_28
action_153 (69) = happyShift action_29
action_153 (73) = happyShift action_30
action_153 (76) = happyShift action_31
action_153 (48) = happyGoto action_156
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (52) = happyShift action_64
action_154 (56) = happyShift action_49
action_154 (59) = happyShift action_50
action_154 (68) = happyShift action_28
action_154 (69) = happyShift action_29
action_154 (71) = happyShift action_33
action_154 (72) = happyShift action_78
action_154 (73) = happyShift action_30
action_154 (74) = happyShift action_79
action_154 (75) = happyShift action_34
action_154 (76) = happyShift action_31
action_154 (77) = happyShift action_80
action_154 (78) = happyShift action_81
action_154 (82) = happyShift action_82
action_154 (83) = happyShift action_83
action_154 (84) = happyShift action_23
action_154 (85) = happyShift action_65
action_154 (86) = happyShift action_26
action_154 (25) = happyGoto action_51
action_154 (26) = happyGoto action_52
action_154 (27) = happyGoto action_53
action_154 (33) = happyGoto action_155
action_154 (35) = happyGoto action_54
action_154 (36) = happyGoto action_55
action_154 (37) = happyGoto action_56
action_154 (38) = happyGoto action_57
action_154 (39) = happyGoto action_58
action_154 (40) = happyGoto action_59
action_154 (41) = happyGoto action_76
action_154 (43) = happyGoto action_62
action_154 (47) = happyGoto action_63
action_154 (48) = happyGoto action_77
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_39

action_156 (86) = happyShift action_26
action_156 (27) = happyGoto action_159
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (80) = happyShift action_158
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_26

action_159 (53) = happyShift action_160
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (78) = happyShift action_161
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (52) = happyShift action_64
action_161 (56) = happyShift action_49
action_161 (59) = happyShift action_50
action_161 (68) = happyShift action_28
action_161 (69) = happyShift action_29
action_161 (71) = happyShift action_33
action_161 (72) = happyShift action_78
action_161 (73) = happyShift action_30
action_161 (74) = happyShift action_79
action_161 (75) = happyShift action_34
action_161 (76) = happyShift action_31
action_161 (77) = happyShift action_80
action_161 (78) = happyShift action_81
action_161 (82) = happyShift action_82
action_161 (83) = happyShift action_83
action_161 (84) = happyShift action_23
action_161 (85) = happyShift action_65
action_161 (86) = happyShift action_26
action_161 (25) = happyGoto action_51
action_161 (26) = happyGoto action_52
action_161 (27) = happyGoto action_53
action_161 (33) = happyGoto action_74
action_161 (34) = happyGoto action_162
action_161 (35) = happyGoto action_54
action_161 (36) = happyGoto action_55
action_161 (37) = happyGoto action_56
action_161 (38) = happyGoto action_57
action_161 (39) = happyGoto action_58
action_161 (40) = happyGoto action_59
action_161 (41) = happyGoto action_76
action_161 (43) = happyGoto action_62
action_161 (47) = happyGoto action_63
action_161 (48) = happyGoto action_77
action_161 _ = happyReduce_42

action_162 (80) = happyShift action_163
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_41

happyReduce_22 = happySpecReduce_1  25 happyReduction_22
happyReduction_22 (HappyTerminal (PT _ (TD happy_var_1)))
	 =  HappyAbsSyn25
		 ((read happy_var_1) :: Double
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  26 happyReduction_23
happyReduction_23 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn26
		 ((read happy_var_1) :: Integer
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  27 happyReduction_24
happyReduction_24 (HappyTerminal (PT _ (T_Id happy_var_1)))
	 =  HappyAbsSyn27
		 (CMM.Abs.Id happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  28 happyReduction_25
happyReduction_25 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (CMM.Abs.PDefs happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happyReduce 8 29 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_2) `HappyStk`
	(HappyAbsSyn48  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (CMM.Abs.DFun happy_var_1 happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_0  30 happyReduction_27
happyReduction_27  =  HappyAbsSyn30
		 ([]
	)

happyReduce_28 = happySpecReduce_2  30 happyReduction_28
happyReduction_28 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn30
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  31 happyReduction_29
happyReduction_29 (HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn31
		 (CMM.Abs.ADecl happy_var_1 happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  32 happyReduction_30
happyReduction_30  =  HappyAbsSyn32
		 ([]
	)

happyReduce_31 = happySpecReduce_1  32 happyReduction_31
happyReduction_31 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ((:[]) happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  32 happyReduction_32
happyReduction_32 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  33 happyReduction_33
happyReduction_33 _
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn33
		 (CMM.Abs.SExp happy_var_1
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  33 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn49  happy_var_2)
	(HappyAbsSyn48  happy_var_1)
	 =  HappyAbsSyn33
		 (CMM.Abs.SDecls happy_var_1 happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happyReduce 5 33 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_2) `HappyStk`
	(HappyAbsSyn48  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (CMM.Abs.SInit happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_3  33 happyReduction_36
happyReduction_36 _
	(HappyAbsSyn35  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (CMM.Abs.SReturn happy_var_2
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happyReduce 5 33 happyReduction_37
happyReduction_37 ((HappyAbsSyn33  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (CMM.Abs.SWhile happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_3  33 happyReduction_38
happyReduction_38 _
	(HappyAbsSyn34  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (CMM.Abs.SBlock happy_var_2
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happyReduce 7 33 happyReduction_39
happyReduction_39 ((HappyAbsSyn33  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn33  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn35  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (CMM.Abs.SIfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_3  33 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn35  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (CMM.Abs.SThrow happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 12 33 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_11) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_8) `HappyStk`
	(HappyAbsSyn48  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn34  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (CMM.Abs.STryCatch happy_var_3 happy_var_7 happy_var_8 happy_var_11
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_0  34 happyReduction_42
happyReduction_42  =  HappyAbsSyn34
		 ([]
	)

happyReduce_43 = happySpecReduce_2  34 happyReduction_43
happyReduction_43 (HappyAbsSyn34  happy_var_2)
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn34
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  35 happyReduction_44
happyReduction_44 (HappyAbsSyn47  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EBool happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  35 happyReduction_45
happyReduction_45 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EInt happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  35 happyReduction_46
happyReduction_46 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EDouble happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  35 happyReduction_47
happyReduction_47 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EId happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happyReduce 4 35 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn42  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn27  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn35
		 (CMM.Abs.EApp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_2  35 happyReduction_49
happyReduction_49 (HappyAbsSyn43  happy_var_2)
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EPost happy_var_1 happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  35 happyReduction_50
happyReduction_50 (HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EPre happy_var_1 happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  35 happyReduction_51
happyReduction_51 _
	(HappyAbsSyn35  happy_var_2)
	_
	 =  HappyAbsSyn35
		 (happy_var_2
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  36 happyReduction_52
happyReduction_52 (HappyAbsSyn35  happy_var_3)
	(HappyAbsSyn44  happy_var_2)
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EMul happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  36 happyReduction_53
happyReduction_53 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  37 happyReduction_54
happyReduction_54 (HappyAbsSyn35  happy_var_3)
	(HappyAbsSyn45  happy_var_2)
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EAdd happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  37 happyReduction_55
happyReduction_55 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  38 happyReduction_56
happyReduction_56 (HappyAbsSyn35  happy_var_3)
	(HappyAbsSyn46  happy_var_2)
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.ECmp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  38 happyReduction_57
happyReduction_57 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  39 happyReduction_58
happyReduction_58 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EAnd happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  39 happyReduction_59
happyReduction_59 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  40 happyReduction_60
happyReduction_60 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EOr happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  40 happyReduction_61
happyReduction_61 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  41 happyReduction_62
happyReduction_62 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn35
		 (CMM.Abs.EAss happy_var_1 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  41 happyReduction_63
happyReduction_63 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn35
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_0  42 happyReduction_64
happyReduction_64  =  HappyAbsSyn42
		 ([]
	)

happyReduce_65 = happySpecReduce_1  42 happyReduction_65
happyReduction_65 (HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn42
		 ((:[]) happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  42 happyReduction_66
happyReduction_66 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn35  happy_var_1)
	 =  HappyAbsSyn42
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  43 happyReduction_67
happyReduction_67 _
	 =  HappyAbsSyn43
		 (CMM.Abs.OInc
	)

happyReduce_68 = happySpecReduce_1  43 happyReduction_68
happyReduction_68 _
	 =  HappyAbsSyn43
		 (CMM.Abs.ODec
	)

happyReduce_69 = happySpecReduce_1  44 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn44
		 (CMM.Abs.OTimes
	)

happyReduce_70 = happySpecReduce_1  44 happyReduction_70
happyReduction_70 _
	 =  HappyAbsSyn44
		 (CMM.Abs.ODiv
	)

happyReduce_71 = happySpecReduce_1  45 happyReduction_71
happyReduction_71 _
	 =  HappyAbsSyn45
		 (CMM.Abs.OPlus
	)

happyReduce_72 = happySpecReduce_1  45 happyReduction_72
happyReduction_72 _
	 =  HappyAbsSyn45
		 (CMM.Abs.OMinus
	)

happyReduce_73 = happySpecReduce_1  46 happyReduction_73
happyReduction_73 _
	 =  HappyAbsSyn46
		 (CMM.Abs.OLt
	)

happyReduce_74 = happySpecReduce_1  46 happyReduction_74
happyReduction_74 _
	 =  HappyAbsSyn46
		 (CMM.Abs.OGt
	)

happyReduce_75 = happySpecReduce_1  46 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn46
		 (CMM.Abs.OLtEq
	)

happyReduce_76 = happySpecReduce_1  46 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn46
		 (CMM.Abs.OGtEq
	)

happyReduce_77 = happySpecReduce_1  46 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn46
		 (CMM.Abs.OEq
	)

happyReduce_78 = happySpecReduce_1  46 happyReduction_78
happyReduction_78 _
	 =  HappyAbsSyn46
		 (CMM.Abs.ONEq
	)

happyReduce_79 = happySpecReduce_1  47 happyReduction_79
happyReduction_79 _
	 =  HappyAbsSyn47
		 (CMM.Abs.LTrue
	)

happyReduce_80 = happySpecReduce_1  47 happyReduction_80
happyReduction_80 _
	 =  HappyAbsSyn47
		 (CMM.Abs.LFalse
	)

happyReduce_81 = happySpecReduce_1  48 happyReduction_81
happyReduction_81 _
	 =  HappyAbsSyn48
		 (CMM.Abs.Type_bool
	)

happyReduce_82 = happySpecReduce_1  48 happyReduction_82
happyReduction_82 _
	 =  HappyAbsSyn48
		 (CMM.Abs.Type_int
	)

happyReduce_83 = happySpecReduce_1  48 happyReduction_83
happyReduction_83 _
	 =  HappyAbsSyn48
		 (CMM.Abs.Type_double
	)

happyReduce_84 = happySpecReduce_1  48 happyReduction_84
happyReduction_84 _
	 =  HappyAbsSyn48
		 (CMM.Abs.Type_void
	)

happyReduce_85 = happySpecReduce_1  49 happyReduction_85
happyReduction_85 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn49
		 ((:[]) happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  49 happyReduction_86
happyReduction_86 (HappyAbsSyn49  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn49
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 87 87 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 50;
	PT _ (TS _ 2) -> cont 51;
	PT _ (TS _ 3) -> cont 52;
	PT _ (TS _ 4) -> cont 53;
	PT _ (TS _ 5) -> cont 54;
	PT _ (TS _ 6) -> cont 55;
	PT _ (TS _ 7) -> cont 56;
	PT _ (TS _ 8) -> cont 57;
	PT _ (TS _ 9) -> cont 58;
	PT _ (TS _ 10) -> cont 59;
	PT _ (TS _ 11) -> cont 60;
	PT _ (TS _ 12) -> cont 61;
	PT _ (TS _ 13) -> cont 62;
	PT _ (TS _ 14) -> cont 63;
	PT _ (TS _ 15) -> cont 64;
	PT _ (TS _ 16) -> cont 65;
	PT _ (TS _ 17) -> cont 66;
	PT _ (TS _ 18) -> cont 67;
	PT _ (TS _ 19) -> cont 68;
	PT _ (TS _ 20) -> cont 69;
	PT _ (TS _ 21) -> cont 70;
	PT _ (TS _ 22) -> cont 71;
	PT _ (TS _ 23) -> cont 72;
	PT _ (TS _ 24) -> cont 73;
	PT _ (TS _ 25) -> cont 74;
	PT _ (TS _ 26) -> cont 75;
	PT _ (TS _ 27) -> cont 76;
	PT _ (TS _ 28) -> cont 77;
	PT _ (TS _ 29) -> cont 78;
	PT _ (TS _ 30) -> cont 79;
	PT _ (TS _ 31) -> cont 80;
	PT _ (TS _ 32) -> cont 81;
	PT _ (TS _ 33) -> cont 82;
	PT _ (TS _ 34) -> cont 83;
	PT _ (TD happy_dollar_dollar) -> cont 84;
	PT _ (TI happy_dollar_dollar) -> cont 85;
	PT _ (T_Id happy_dollar_dollar) -> cont 86;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 87 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = ((>>=))
happyReturn :: () => a -> Err a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn28 z -> happyReturn z; _other -> notHappyAtAll })

pDef tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn29 z -> happyReturn z; _other -> notHappyAtAll })

pListDef tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn30 z -> happyReturn z; _other -> notHappyAtAll })

pArg tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_3 tks) (\x -> case x of {HappyAbsSyn31 z -> happyReturn z; _other -> notHappyAtAll })

pListArg tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_4 tks) (\x -> case x of {HappyAbsSyn32 z -> happyReturn z; _other -> notHappyAtAll })

pStm tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_5 tks) (\x -> case x of {HappyAbsSyn33 z -> happyReturn z; _other -> notHappyAtAll })

pListStm tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_6 tks) (\x -> case x of {HappyAbsSyn34 z -> happyReturn z; _other -> notHappyAtAll })

pExp6 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_7 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pExp5 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_8 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pExp4 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_9 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pExp3 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_10 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pExp2 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_11 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pExp1 tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_12 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pExp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_13 tks) (\x -> case x of {HappyAbsSyn35 z -> happyReturn z; _other -> notHappyAtAll })

pListExp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_14 tks) (\x -> case x of {HappyAbsSyn42 z -> happyReturn z; _other -> notHappyAtAll })

pIncDecOp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_15 tks) (\x -> case x of {HappyAbsSyn43 z -> happyReturn z; _other -> notHappyAtAll })

pMulOp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_16 tks) (\x -> case x of {HappyAbsSyn44 z -> happyReturn z; _other -> notHappyAtAll })

pAddOp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_17 tks) (\x -> case x of {HappyAbsSyn45 z -> happyReturn z; _other -> notHappyAtAll })

pCmpOp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_18 tks) (\x -> case x of {HappyAbsSyn46 z -> happyReturn z; _other -> notHappyAtAll })

pBoolLit tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_19 tks) (\x -> case x of {HappyAbsSyn47 z -> happyReturn z; _other -> notHappyAtAll })

pType tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_20 tks) (\x -> case x of {HappyAbsSyn48 z -> happyReturn z; _other -> notHappyAtAll })

pListId tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_21 tks) (\x -> case x of {HappyAbsSyn49 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
