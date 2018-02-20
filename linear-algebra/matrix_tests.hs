module Gla.MatrixTests where

import Gla.Matrices
import Gla.Vectors
import Test.HUnit
import Math.Polynomial

matrix2x2_1 = numMatrixToPolyMatrix [[1,2],[3,4]]
matrix2x2_2 = numMatrixToPolyMatrix [[1,1],[1,1]]
matrix2x2_3 = numMatrixToPolyMatrix [[0,1],[2,3]]
matrix2x2_4 = numMatrixToPolyMatrix [[2,4],[6,8]]
matrix2x2_5 = numMatrixToPolyMatrix [[1,2],[5,7]]
matrix2x2_6 = numMatrixToPolyMatrix [[1,5],[2,7]]
matrix2x2_7 = numMatrixToPolyMatrix [[4,7],[8,15]]
matrix3x3_1 = numMatrixToPolyMatrix [[1,2,2],[3,4,4],[5,6,7]]
matrix4x4_1 = numMatrixToPolyMatrix [[1,2,3,4],[2,2,2,2],[3,4,1,1],[5,3,3,2]]

tests = TestList [
  TestCase (assertEqual "nums to polys test 1" [[numToPoly 1,numToPoly 2],[numToPoly 3, numToPoly 4]] matrix2x2_1),
  TestCase (assertEqual "polys to nums test 2" [[1,2],[3,4]] (polyMatrixToNumMatrix matrix2x2_1)),
  TestCase (assertEqual "scale test 1" matrix2x2_4 (Gla.Matrices.scale (numToPoly 2) matrix2x2_1)),
  TestCase (assertEqual "minor test 1" matrix2x2_1 (minor matrix3x3_1 2 2)),
  TestCase (assertEqual "minor test 2" matrix2x2_5 (minor matrix3x3_1 1 1)),
  TestCase (assertEqual "cofactor test 1" (numToPoly (-3)) (cofactor matrix3x3_1 1 1)),
  TestCase (assertEqual "determinant test 1" (numToPoly (-8)) (determinant matrix2x2_4)),
  TestCase (assertEqual "determinant test 2" (numToPoly (-2)) (determinant matrix3x3_1)),
  TestCase (assertEqual "determinant test 3" (numToPoly 4) (determinant matrix4x4_1)),
  TestCase (assertEqual "mirror test 1" matrix2x2_6 (mirror matrix2x2_5)),
  TestCase (assertEqual "multiply test 1" matrix2x2_7 (multipy matrix2x2_1 matrix2x2_3)),
  TestCase (assertEqual "for commas" True True)
  ]

runTests = runTestTT (tests)
