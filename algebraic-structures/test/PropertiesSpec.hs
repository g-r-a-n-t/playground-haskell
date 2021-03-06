module PropertiesSpec (spec) where

import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import Properties

-- Sets
first10PositiveIntegers = [1..10]
first10PositiveIntegersAsFloats = [1..10] :: [Float]
integersMod7 = [0..6]
aThruD = ["A", "B", "C", "D"]
bThruD = ["B", "C", "D"]

-- maps
nonGeneralMap x
  | x == 1 = "Foo"
  | x == 2 = "B"
  | x == 3 = "C"
  | x == 4 = "D"

generalMapOnly x
  | x == 1 = "D"
  | x == 2 = "D"
  | x == 3 = "C"

injectiveOnly x
  | x == 1 = "D"
  | x == 2 = "B"
  | x == 3 = "A"

surjectiveOnly x
  | x == 1 = "D"
  | x == 2 = "B"
  | x == 3 = "C"
  | x == 4 = "C"

bijective x
  | x == 1 = "D"
  | x == 2 = "B"
  | x == 3 = "C"
  | x == 4 = "A"

-- functions
additionMod7 a b = (a + b) `mod` 7
additiveInverseMod7 a = (-a) `mod` 7

spec :: Spec
spec = do
  describe "Properties.hasClossure" $ do
    it "returns true for integers mod 7 over addition." $ do
      hasClosure integersMod7 additionMod7 `shouldBe` True
    it "returns false for first 10 positive integers over addition." $ do
      hasClosure first10PositiveIntegers (+) `shouldBe` False

  describe "Properties.isAssociative" $ do
    it "returns true for first 10 positive integers over addition." $ do
      isAssociative first10PositiveIntegers (+) `shouldBe` True
    it "returns false for first 10 positive integers over exponentiation." $ do
      isAssociative first10PositiveIntegers (^) `shouldBe` False
    it "returns false for first 10 positive integers as floats over division." $ do
      isAssociative first10PositiveIntegersAsFloats (/) `shouldBe` False

  describe "Properties.isCommutative" $ do
    it "returns true for first 10 positive integers over addition." $ do
      isCommutative first10PositiveIntegers (+) `shouldBe` True
    it "returns false for first 10 positive integers over exponentiation." $ do
      isCommutative first10PositiveIntegers (^) `shouldBe` False
    it "returns false for first 10 positive floats over division." $ do
      isCommutative first10PositiveIntegersAsFloats (/) `shouldBe` False

  describe "Properties.hasIdentity" $ do
    it "returns true for the first 10 positive integers over multiplication" $ do
      hasIdentity first10PositiveIntegers (*) `shouldBe` True
    it "returns false for the first 10 positive integers over addition" $ do
      hasIdentity first10PositiveIntegers (+) `shouldBe` False

  describe "Properties.isInvertible" $ do
    it "returns true for the integers mod 7 over addition." $ do
      isInvertible integersMod7 additionMod7 `shouldBe` True

  describe "Properties.isDistributive" $ do
    it "returns true for addition and multiplication 'a * (b + c) = ab + ac'" $ do
      isDistributive first10PositiveIntegers (+) (*) `shouldBe` True
    it "returns false for multiplication and addition 'a + (b * c) /= (a + b) * (a + c)'" $ do
      isDistributive first10PositiveIntegers (*) (+) `shouldBe` False

  describe "Properties.isGeneralMap" $ do
    it "returns false for a non-general map." $ do
      isGeneralMap nonGeneralMap [1..4] aThruD `shouldBe` False
    it "returns true for a general-only map." $ do
      isGeneralMap generalMapOnly [1..3] aThruD `shouldBe` True
    it "returns true for an injective-only map." $ do
      isGeneralMap injectiveOnly [1..3] aThruD `shouldBe` True
    it "returns true for a surjectve-only map." $ do
      isGeneralMap surjectiveOnly [1..4] bThruD `shouldBe` True
    it "returns true for a bijective map." $ do
      isGeneralMap bijective [1..4] aThruD `shouldBe` True

  describe "Properties.isInjective" $ do
    it "returns false for a non-general map." $ do
      isInjective nonGeneralMap [1..4] aThruD `shouldBe` False
    it "returns false for a general-only map." $ do
      isInjective generalMapOnly [1..3] aThruD `shouldBe` False
    it "returns true for an injective-only map." $ do
      isInjective injectiveOnly [1..3] aThruD `shouldBe` True
    it "returns false for a surjective-only map." $ do
      isInjective surjectiveOnly [1..4] bThruD `shouldBe` False
    it "returns true for a bijective map." $ do
      isInjective bijective [1..4] aThruD `shouldBe` True

  describe "Properties.isSurjective" $ do
    it "returns false for a non-general map." $ do
      isSurjective nonGeneralMap [1..4] aThruD `shouldBe` False
    it "returns false for a general-only map." $ do
      isSurjective generalMapOnly [1..3] aThruD `shouldBe` False
    it "returns false for an injective-only map." $ do
      isSurjective injectiveOnly [1..3] aThruD `shouldBe` False
    it "returns true for a surjective-only map." $ do
      isSurjective surjectiveOnly [1..4] bThruD `shouldBe` True
    it "returns true for a bijective map." $ do
      isSurjective bijective [1..4] aThruD `shouldBe` True

  describe "Properties.isBijective" $ do
    it "returns false for a non-general map." $ do
      isBijective nonGeneralMap [1..4] aThruD `shouldBe` False
    it "returns false for a general-only map." $ do
      isBijective generalMapOnly [1..3] aThruD `shouldBe` False
    it "returns false for an injective-only map." $ do
      isBijective injectiveOnly [1..3] aThruD `shouldBe` False
    it "returns false for a surjective-only map." $ do
      isBijective surjectiveOnly [1..4] bThruD `shouldBe` False
    it "returns true for a bijective map." $ do
      isBijective bijective [1..4] aThruD `shouldBe` True
