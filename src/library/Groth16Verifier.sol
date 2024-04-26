// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

contract Groth16Verifier {
    // Scalar field size
    uint256 constant r =
        21_888_242_871_839_275_222_246_405_745_257_275_088_548_364_400_416_034_343_698_204_186_575_808_495_617;
    // Base field size
    uint256 constant q =
        21_888_242_871_839_275_222_246_405_745_257_275_088_696_311_157_297_823_662_689_037_894_645_226_208_583;

    // Verification Key data
    uint256 constant alphax =
        20_491_192_805_390_485_299_153_009_773_594_534_940_189_261_866_228_447_918_068_658_471_970_481_763_042;
    uint256 constant alphay =
        9_383_485_363_053_290_200_918_347_156_157_836_566_562_967_994_039_712_273_449_902_621_266_178_545_958;
    uint256 constant betax1 =
        4_252_822_878_758_300_859_123_897_981_450_591_353_533_073_413_197_771_768_651_442_665_752_259_397_132;
    uint256 constant betax2 =
        6_375_614_351_688_725_206_403_948_262_868_962_793_625_744_043_794_305_715_222_011_528_459_656_738_731;
    uint256 constant betay1 =
        21_847_035_105_528_745_403_288_232_691_147_584_728_191_162_732_299_865_338_377_159_692_350_059_136_679;
    uint256 constant betay2 =
        10_505_242_626_370_262_277_552_901_082_094_356_697_409_835_680_220_590_971_873_171_140_371_331_206_856;
    uint256 constant gammax1 =
        11_559_732_032_986_387_107_991_004_021_392_285_783_925_812_861_821_192_530_917_403_151_452_391_805_634;
    uint256 constant gammax2 =
        10_857_046_999_023_057_135_944_570_762_232_829_481_370_756_359_578_518_086_990_519_993_285_655_852_781;
    uint256 constant gammay1 =
        4_082_367_875_863_433_681_332_203_403_145_435_568_316_851_327_593_401_208_105_741_076_214_120_093_531;
    uint256 constant gammay2 =
        8_495_653_923_123_431_417_604_973_247_489_272_438_418_190_587_263_600_148_770_280_649_306_958_101_930;
    uint256 constant deltax1 =
        5_701_948_894_775_097_554_889_227_568_279_884_650_930_148_391_635_805_634_673_131_389_526_821_210_618;
    uint256 constant deltax2 =
        17_141_898_790_073_007_158_938_048_620_460_234_931_891_602_976_624_046_036_226_044_196_542_862_754_508;
    uint256 constant deltay1 =
        1_903_935_888_322_038_789_354_516_707_626_118_024_027_107_325_602_975_632_492_349_123_185_225_356_751;
    uint256 constant deltay2 =
        7_401_014_610_486_021_776_592_937_345_810_437_572_317_467_069_731_172_709_979_246_235_223_609_111_423;

    uint256 constant IC0x =
        7_829_834_164_141_340_468_945_519_632_121_285_149_340_700_977_405_224_212_399_652_050_189_075_332_345;
    uint256 constant IC0y =
        14_652_087_846_466_719_594_245_284_308_830_228_491_552_922_448_003_035_067_564_492_597_332_585_376_627;

    uint256 constant IC1x =
        12_665_944_230_854_301_525_850_564_693_857_323_394_800_763_761_835_555_310_693_943_968_474_190_468_688;
    uint256 constant IC1y =
        18_855_977_167_050_596_080_836_459_425_677_890_631_450_206_135_060_193_192_767_107_597_756_342_707_208;

    uint256 constant IC2x =
        9_826_862_903_287_946_685_507_117_418_386_829_785_388_826_271_407_763_565_018_591_429_772_249_150_394;
    uint256 constant IC2y =
        1_663_201_430_777_649_774_912_689_005_645_271_251_187_373_568_810_967_219_309_269_841_263_292_168_723;

    uint256 constant IC3x =
        506_703_761_601_409_803_259_651_664_516_325_881_527_057_551_477_051_095_790_557_304_178_414_155_949;
    uint256 constant IC3y =
        17_416_989_158_860_539_079_068_228_534_815_601_302_707_956_531_148_895_643_788_613_451_959_072_732_245;

    uint256 constant IC4x =
        19_379_601_859_934_974_793_040_299_834_794_437_509_845_464_854_212_367_331_709_740_481_966_558_272_979;
    uint256 constant IC4y =
        10_536_626_508_639_435_690_485_164_201_221_755_274_398_052_909_688_844_504_647_890_378_340_371_269_340;

    uint256 constant IC5x =
        19_531_624_072_049_969_238_455_853_382_914_847_775_794_823_834_128_953_790_272_941_666_062_464_902_475;
    uint256 constant IC5y =
        5_762_646_756_277_111_292_816_054_259_227_499_449_214_070_224_958_135_684_898_527_043_751_224_824_476;

    uint256 constant IC6x =
        6_275_410_603_256_462_010_308_005_224_090_500_996_942_470_308_890_005_037_205_162_813_127_244_578_175;
    uint256 constant IC6y =
        5_487_101_711_287_125_582_049_594_061_562_094_315_335_881_233_859_080_513_030_501_086_087_586_757_589;

    uint256 constant IC7x =
        6_894_283_408_894_895_872_470_387_829_573_598_278_132_752_807_548_394_302_054_803_009_984_033_238_968;
    uint256 constant IC7y =
        15_319_674_532_507_061_062_118_462_374_729_929_967_779_706_446_856_499_954_507_244_407_312_598_767_164;

    uint256 constant IC8x =
        12_321_921_087_917_658_748_822_073_220_245_854_284_051_241_303_054_479_084_613_234_341_788_263_683_871;
    uint256 constant IC8y =
        7_487_854_211_404_778_061_265_600_070_892_201_894_853_746_020_533_293_505_846_560_493_659_130_702_689;

    uint256 constant IC9x =
        14_731_934_856_329_974_905_816_220_718_127_536_721_614_687_374_198_880_436_805_098_854_352_768_546_612;
    uint256 constant IC9y =
        8_153_900_867_314_223_735_681_358_517_366_095_106_838_612_727_231_152_671_766_726_630_838_972_657_951;

    uint256 constant IC10x =
        17_471_938_829_150_016_296_694_327_218_304_751_649_139_439_822_200_617_681_478_090_963_702_124_065_205;
    uint256 constant IC10y =
        18_315_243_483_345_753_632_137_968_012_159_649_916_418_141_183_369_404_567_896_378_130_377_144_638_823;

    uint256 constant IC11x =
        14_655_636_492_594_869_063_952_561_702_552_147_110_953_978_969_987_306_480_578_764_047_615_492_037_812;
    uint256 constant IC11y =
        11_845_085_658_644_725_531_750_029_466_126_467_656_714_439_148_635_315_339_128_964_390_635_082_381_713;

    uint256 constant IC12x =
        3_680_956_112_061_994_320_862_840_757_875_168_674_054_534_403_706_065_589_182_838_992_948_460_914_829;
    uint256 constant IC12y =
        10_412_653_155_581_567_067_344_831_956_213_192_379_125_199_194_949_719_994_204_659_685_674_064_170_114;

    uint256 constant IC13x =
        21_798_012_483_233_711_725_271_620_090_897_784_222_313_829_046_031_212_520_931_975_393_768_550_999_975;
    uint256 constant IC13y =
        4_296_487_231_457_999_166_233_626_669_829_507_454_745_493_750_798_718_908_749_668_849_368_591_950_011;

    uint256 constant IC14x =
        15_721_417_814_591_678_486_616_669_823_046_167_928_524_432_266_500_176_772_757_999_455_705_057_860_059;
    uint256 constant IC14y =
        18_168_303_352_540_934_768_584_051_530_714_964_659_397_491_637_395_284_586_829_913_792_459_366_234_514;

    uint256 constant IC15x =
        7_077_518_692_424_212_081_926_712_187_277_020_659_834_253_548_893_677_224_394_852_648_374_166_982_230;
    uint256 constant IC15y =
        1_405_575_137_644_410_930_010_908_462_020_131_181_321_267_080_237_986_507_583_313_122_993_529_501_578;

    uint256 constant IC16x =
        16_338_117_439_754_953_205_625_704_567_921_563_790_800_330_493_675_965_355_189_989_525_355_224_948_353;
    uint256 constant IC16y =
        12_390_721_167_670_310_804_777_982_757_484_931_428_377_042_286_563_505_064_465_343_118_486_037_013_575;

    uint256 constant IC17x =
        16_518_815_021_744_744_943_342_836_007_699_412_454_230_537_051_776_882_614_819_124_258_031_864_555_789;
    uint256 constant IC17y =
        12_946_424_124_132_971_261_345_595_167_202_439_665_482_763_430_793_276_610_458_701_612_494_350_463_109;

    uint256 constant IC18x =
        14_724_500_978_440_550_979_676_734_074_572_368_080_751_547_510_054_855_270_300_418_769_593_891_186_812;
    uint256 constant IC18y =
        21_357_176_446_308_408_176_009_156_203_216_501_424_851_183_580_422_290_901_917_086_657_905_856_829_622;

    uint256 constant IC19x =
        667_516_093_505_323_270_391_107_436_093_089_526_343_684_766_032_347_935_464_924_544_841_459_543_072;
    uint256 constant IC19y =
        12_713_219_675_933_558_229_091_866_185_735_093_650_535_871_997_043_514_435_112_621_219_631_021_952_441;

    uint256 constant IC20x =
        3_179_187_918_890_941_822_082_318_415_147_973_934_918_656_565_143_741_830_412_835_106_040_644_949_266;
    uint256 constant IC20y =
        4_536_576_418_190_059_050_274_482_473_349_374_914_398_412_917_710_309_412_963_738_640_331_841_597_361;

    uint256 constant IC21x =
        10_296_363_162_767_667_325_534_605_631_508_271_155_463_496_250_656_272_242_457_936_759_719_934_412_911;
    uint256 constant IC21y =
        1_146_565_873_766_510_307_981_220_066_722_990_711_969_787_837_394_176_396_154_645_097_946_388_110_324;

    uint256 constant IC22x =
        7_101_312_272_240_726_789_665_784_899_531_467_073_032_443_074_315_173_362_657_778_437_127_230_147_617;
    uint256 constant IC22y =
        16_289_484_061_223_058_676_141_789_432_178_916_954_527_332_378_211_487_811_915_988_132_553_233_164_994;

    uint256 constant IC23x =
        14_527_448_150_190_183_422_662_750_319_493_990_479_434_399_137_549_857_645_665_177_508_626_906_094_923;
    uint256 constant IC23y =
        8_066_868_087_350_144_027_422_900_511_076_323_618_766_253_853_874_551_489_389_703_126_863_195_679_814;

    uint256 constant IC24x =
        1_981_358_986_648_263_262_438_883_540_308_189_513_337_273_860_667_046_460_726_188_696_965_077_246_677;
    uint256 constant IC24y =
        9_614_502_607_791_585_910_406_065_017_762_909_141_709_271_696_108_238_178_796_497_924_923_334_813_447;

    uint256 constant IC25x =
        13_781_313_582_529_201_925_745_612_034_545_463_155_953_394_127_173_142_951_509_009_361_838_155_987_652;
    uint256 constant IC25y =
        6_184_854_308_428_404_686_953_104_660_872_209_666_272_973_035_514_403_718_698_799_476_705_419_628_641;

    uint256 constant IC26x =
        12_334_789_464_163_929_631_233_800_353_667_349_309_063_681_237_348_227_790_930_609_013_930_036_478_619;
    uint256 constant IC26y =
        2_912_873_639_557_671_796_289_062_720_925_374_604_590_018_962_640_428_877_665_338_841_644_298_317_653;

    uint256 constant IC27x =
        8_063_885_091_897_993_008_980_226_352_254_305_546_690_330_592_699_775_955_798_899_637_689_654_653_139;
    uint256 constant IC27y =
        4_008_436_779_594_382_054_308_505_307_854_934_990_418_284_419_722_403_542_614_611_947_982_841_697_477;

    uint256 constant IC28x =
        6_830_981_767_384_659_887_036_218_867_480_006_204_764_681_482_841_269_763_496_615_532_622_211_216_448;
    uint256 constant IC28y =
        15_950_715_696_020_929_920_376_472_455_176_248_166_286_888_134_509_518_248_250_335_798_036_339_009_933;

    uint256 constant IC29x =
        19_384_502_457_353_715_068_996_525_890_970_524_084_508_381_360_865_787_050_364_482_553_960_632_730_607;
    uint256 constant IC29y =
        9_712_094_362_188_014_995_528_163_123_423_193_379_209_932_406_243_429_849_746_346_521_196_722_435_378;

    uint256 constant IC30x =
        6_589_142_792_140_343_267_116_228_839_033_944_289_127_439_381_316_247_038_692_406_428_702_223_923_572;
    uint256 constant IC30y =
        13_999_920_152_560_629_292_398_880_854_803_886_658_698_186_298_063_472_735_733_541_760_493_583_952_922;

    uint256 constant IC31x =
        5_097_732_560_123_898_004_665_979_059_103_043_648_574_204_716_412_662_732_172_940_340_428_085_176_917;
    uint256 constant IC31y =
        10_952_974_352_850_969_426_801_594_078_476_500_065_712_106_293_248_015_930_363_182_491_843_388_896_966;

    uint256 constant IC32x =
        10_605_396_284_131_761_768_086_327_904_284_548_292_904_229_709_052_008_872_630_824_670_909_724_167_646;
    uint256 constant IC32y =
        17_611_647_774_802_217_941_206_627_281_738_805_040_409_908_242_999_997_970_205_165_424_507_439_030_461;

    uint256 constant IC33x =
        4_175_038_566_663_329_352_655_049_571_438_504_746_943_159_429_617_277_434_535_972_607_376_453_967_123;
    uint256 constant IC33y =
        4_646_782_806_941_607_889_272_256_678_316_134_244_937_693_598_601_119_061_624_327_188_703_580_485_403;

    uint256 constant IC34x =
        9_549_406_608_152_508_889_094_443_589_203_749_560_786_978_809_395_158_330_316_554_164_647_701_463_837;
    uint256 constant IC34y =
        6_381_522_712_973_803_524_913_963_017_418_643_303_984_841_222_100_528_150_182_988_904_199_331_582_505;

    uint256 constant IC35x =
        1_263_320_602_803_458_748_257_036_523_458_552_279_391_273_506_672_188_304_767_036_210_856_588_968_260;
    uint256 constant IC35y =
        9_002_033_670_991_148_742_836_469_656_216_559_553_194_617_728_752_954_942_667_515_930_647_075_202_837;

    uint256 constant IC36x =
        8_028_192_682_648_048_619_466_724_511_877_386_287_561_240_622_383_893_916_064_160_633_502_860_365_668;
    uint256 constant IC36y =
        5_105_732_082_193_037_657_278_794_591_993_605_671_626_734_482_443_031_475_351_474_913_021_158_078_220;

    uint256 constant IC37x =
        10_300_202_576_768_233_133_953_695_141_853_769_652_334_332_985_530_299_874_635_602_299_997_510_668_139;
    uint256 constant IC37y =
        19_229_395_124_294_155_173_586_868_841_805_296_334_589_576_723_382_304_412_741_148_566_532_240_409_977;

    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(
        uint256[2] calldata _pA,
        uint256[2][2] calldata _pB,
        uint256[2] calldata _pC,
        uint256[37] calldata _pubSignals
    ) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x

                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))

                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))

                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))

                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))

                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))

                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))

                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))

                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))

                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))

                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))

                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))

                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))

                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))

                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))

                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))

                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))

                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))

                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))

                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))

                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))

                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))

                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))

                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))

                g1_mulAccC(_pVk, IC24x, IC24y, calldataload(add(pubSignals, 736)))

                g1_mulAccC(_pVk, IC25x, IC25y, calldataload(add(pubSignals, 768)))

                g1_mulAccC(_pVk, IC26x, IC26y, calldataload(add(pubSignals, 800)))

                g1_mulAccC(_pVk, IC27x, IC27y, calldataload(add(pubSignals, 832)))

                g1_mulAccC(_pVk, IC28x, IC28y, calldataload(add(pubSignals, 864)))

                g1_mulAccC(_pVk, IC29x, IC29y, calldataload(add(pubSignals, 896)))

                g1_mulAccC(_pVk, IC30x, IC30y, calldataload(add(pubSignals, 928)))

                g1_mulAccC(_pVk, IC31x, IC31y, calldataload(add(pubSignals, 960)))

                g1_mulAccC(_pVk, IC32x, IC32y, calldataload(add(pubSignals, 992)))

                g1_mulAccC(_pVk, IC33x, IC33y, calldataload(add(pubSignals, 1024)))

                g1_mulAccC(_pVk, IC34x, IC34y, calldataload(add(pubSignals, 1056)))

                g1_mulAccC(_pVk, IC35x, IC35y, calldataload(add(pubSignals, 1088)))

                g1_mulAccC(_pVk, IC36x, IC36y, calldataload(add(pubSignals, 1120)))

                g1_mulAccC(_pVk, IC37x, IC37y, calldataload(add(pubSignals, 1152)))

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))

                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)

                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F

            checkField(calldataload(add(_pubSignals, 0)))

            checkField(calldataload(add(_pubSignals, 32)))

            checkField(calldataload(add(_pubSignals, 64)))

            checkField(calldataload(add(_pubSignals, 96)))

            checkField(calldataload(add(_pubSignals, 128)))

            checkField(calldataload(add(_pubSignals, 160)))

            checkField(calldataload(add(_pubSignals, 192)))

            checkField(calldataload(add(_pubSignals, 224)))

            checkField(calldataload(add(_pubSignals, 256)))

            checkField(calldataload(add(_pubSignals, 288)))

            checkField(calldataload(add(_pubSignals, 320)))

            checkField(calldataload(add(_pubSignals, 352)))

            checkField(calldataload(add(_pubSignals, 384)))

            checkField(calldataload(add(_pubSignals, 416)))

            checkField(calldataload(add(_pubSignals, 448)))

            checkField(calldataload(add(_pubSignals, 480)))

            checkField(calldataload(add(_pubSignals, 512)))

            checkField(calldataload(add(_pubSignals, 544)))

            checkField(calldataload(add(_pubSignals, 576)))

            checkField(calldataload(add(_pubSignals, 608)))

            checkField(calldataload(add(_pubSignals, 640)))

            checkField(calldataload(add(_pubSignals, 672)))

            checkField(calldataload(add(_pubSignals, 704)))

            checkField(calldataload(add(_pubSignals, 736)))

            checkField(calldataload(add(_pubSignals, 768)))

            checkField(calldataload(add(_pubSignals, 800)))

            checkField(calldataload(add(_pubSignals, 832)))

            checkField(calldataload(add(_pubSignals, 864)))

            checkField(calldataload(add(_pubSignals, 896)))

            checkField(calldataload(add(_pubSignals, 928)))

            checkField(calldataload(add(_pubSignals, 960)))

            checkField(calldataload(add(_pubSignals, 992)))

            checkField(calldataload(add(_pubSignals, 1024)))

            checkField(calldataload(add(_pubSignals, 1056)))

            checkField(calldataload(add(_pubSignals, 1088)))

            checkField(calldataload(add(_pubSignals, 1120)))

            checkField(calldataload(add(_pubSignals, 1152)))

            checkField(calldataload(add(_pubSignals, 1184)))

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
            return(0, 0x20)
        }
    }
}
