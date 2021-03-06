{-# LANGUAGE Safe #-}
module BLS (
  keygen
) where

import Crypto.ECC.Weierstrass.Internal.Curvemath
import safe qualified Crypto.Fi as FP

-- Creates a secret and public key for the given domain.
keygen :: EC a -> ECPF a -> Either String (FP.FPrime, ECPF a)
keygen _C g = let x  =  FP.fromInteger 256 3 -- TODO: Hardcode a better secret.
                  g' = pmul _C g x
              in Right (x, g')

e :: EC a -> ECPF a -> ECPF a -> ECPF a
e c x h = h

