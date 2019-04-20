module Wesolowski where

import Data.Bits
import Math.NumberTheory.Powers.Modular

-- Generate a keypair(pk, sk) based on some seed(s).
-- keygen(s) -> (pk, sk)
keygen :: Integer ->  (Integer, Integer)
keygen s = (143, 120) -- temporary keypair based on prime numbers, 11 and 13.

-- Compute a value(y) from input(x) with a specified number of sequential
-- steps(t) using the secret key(sk) and provide a proof(p).
-- trapdoor(sk, x, t) -> (y, p)
trapdoor :: Integer -> Integer -> Integer -> Integer -> (Integer, Integer)
trapdoor pk sk x t =
  let g = x -- Hash x to G
      e = powMod 2 t sk -- 2^t mod |G|
      y = powMod g e pk -- g^e mod G
  --     l = -- ???
  --     r = -- least residue of 2^t mod l
  --     q = -- (2^t - r)l^-1 mod |G|
  --     p = -- g^q
  -- in (y, p)
  in (y, 0)


-- Compute a value(y) from input(x) with a specified number of sequential
-- steps(t) using the pubic key(pk) and provide a proof(p).
-- eval(pk, x, t) -> (y, p)
eval :: Integer -> Integer -> Integer -> (Integer, Integer)
eval pk x t =
  let g = x
      y = powMod g (2 ^ t) pk
  in (y, 0)

-- Verifies that either eval or trapdoor have been computed correctly given
-- the inputs and outputs.
-- verify(pk, x, y, p, t) -> valid
verify :: Integer -> Integer -> Integer -> Integer -> Integer -> Bool
verify pk x y p t = False
