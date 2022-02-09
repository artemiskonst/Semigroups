#############################################################################
##
##  homomorph.gi
##  Copyright (C) 2022                                 Artemis Konstantinidi
##                                                     Chinmaya Nagpal
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains a method for finding a homomorphism between semigroups

InstallMethod(SemigroupHomomorphismByImages, "for two semigroups and two lists",
[IsSemigroup, IsSemigroup, IsList, IsList],
function(S, T, gens, imgs)
  local map, R, rel, fun;

  if not IsSemigroup(S) then
    ErrorNoReturn("the 1st argument is not a semigroup");
  elif not IsSemigroup(T) then
    ErrorNoReturn("the 2nd argument is not a semigroup");
  elif not ForAll(gens, x -> x in S) then
    ErrorNoReturn("the 3rd argument (a list) must consist of elements "
                  "of the 1st argument (a semigroup)");
  elif Size(Semigroup(gens)) <> Size(S) then
    ErrorNoReturn("the 1st argument (a semigroup) is not generated by "
                  "the 3rd argument (a list)");
  elif not ForAll(imgs, x -> x in S) then
    ErrorNoReturn("the 4th argument (a list) must consist of elements "
                  "of the 2nd argument (a semigroup)");
  fi;

  if Size(gens) <> Size(imgs) then
    ErrorNoReturn("the 3rd argument (a list) and the 4th argument "
                  "(a list) are not the same size");
  fi;

  map := IsomorphismFpSemigroup(S);   # S (source) -> fp semigroup (range)
  R   := RelationsOfFpSemigroup(Range(map));

  for rel in R do
    rel := List(rel, x -> SEMIGROUPS.ExtRepObjToWord(ExtRepOfObj(x)));
    if EvaluateWord(imgs, rel[1]) <> EvaluateWord(imgs, rel[2]) then
      return fail;
    fi;
  od;

  # fun : S -> T (GAP function, input is an element x of S, and the output is the
  # element of T equal to phi(x)
  fun := function(x)
    if not x in S then
      ErrorNoReturn("the argument is not an element of the semigroup");
    fi;
    return EvaluateWord(imgs, Factorization(S, x));
  end;

  return MagmaHomomorphismByFunctionNC(S, T, fun);
end);