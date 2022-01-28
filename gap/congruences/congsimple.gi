############################################################################
##
##  congruences/congsimple.gi
##  Copyright (C) 2015-2022                               Michael C. Young
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## This file contains methods for congruences on finite (0-)simple semigroups,
## using isomorphisms to Rees (0-)matrix semigroups and methods in
## congruences/congrms.gd/gi.

InstallMethod(SemigroupCongruenceByGeneratingPairs,
"for a simple semigroup and list of pairs",
[IsSimpleSemigroup, IsHomogeneousList],
ToBeat([IsSimpleSemigroup, IsHomogeneousList],
       [IsSemigroup and CanComputeCppCongruences,
        IsList and IsEmpty]),
function(S, pairs)
  local map, R, P, C;
  if (HasIsFreeSemigroup(S) and IsFreeSemigroup(S))
      or (HasIsFreeMonoid(S) and IsFreeMonoid(S))
      or IsFreeGroup(S) then
    TryNextMethod();
  fi;
  map := IsomorphismReesMatrixSemigroup(S);
  R   := Range(map);
  P   := List(pairs, p -> [p[1] ^ map, p[2] ^ map]);
  C   := SemigroupCongruenceByGeneratingPairs(R, P);
  if IsUniversalSemigroupCongruence(C) then
    C := UniversalSemigroupCongruence(S);
  else
    C := SemigroupCongruence(S, map, C);
  fi;
  SetGeneratingPairsOfMagmaCongruence(C, pairs);
  return C;
end);

InstallMethod(SemigroupCongruenceByGeneratingPairs,
"for a 0-simple semigroup and list of pairs",
[IsZeroSimpleSemigroup, IsHomogeneousList],
ToBeat([IsZeroSimpleSemigroup, IsHomogeneousList],
       [IsSemigroup and CanComputeCppCongruences,
        IsList and IsEmpty]),
function(S, pairs)
  local map, R, P, C;
  map := IsomorphismReesZeroMatrixSemigroup(S);
  R   := Range(map);
  P   := List(pairs, p -> [p[1] ^ map, p[2] ^ map]);
  C   := SemigroupCongruenceByGeneratingPairs(R, P);
  if IsUniversalSemigroupCongruence(C) then
    C := UniversalSemigroupCongruence(S);
  else
    C := SemigroupCongruence(S, map, C);
  fi;
  SetGeneratingPairsOfMagmaCongruence(C, pairs);
  return C;
end);

InstallMethod(CongruenceByIsomorphism,
"for a general mapping and semigroup congruence",
[IsGeneralMapping, IsSemigroupCongruence],
function(map, C)
  local S, fam;
  if Range(C) <> Range(map) then
    Error("the range of the 1st argument (a general mapping) is not ",
          "equal to the range of the 2nd argument (a congruence)");
  fi;
  S   := Source(map);
  fam := GeneralMappingsFamily(ElementsFamily(FamilyObj(S)),
                               ElementsFamily(FamilyObj(S)));
  C := Objectify(NewType(fam, IsSimpleSemigroupCongruence),
                    rec(rmscong := C, iso := map));
  SetSource(C, S);
  SetRange(C, S);
  return C;
end);

InstallMethod(ViewObj, "for a (0-)simple semigroup congruence",
[IsSimpleSemigroupCongruence],
function(C)
  Print("<semigroup congruence over ");
  ViewObj(Range(C));
  Print(" with linked triple (",
        StructureDescription(C!.rmscong!.n:short), ",",
        Size(C!.rmscong!.colBlocks), ",",
        Size(C!.rmscong!.rowBlocks), ")>");
end);

InstallMethod(CongruencesOfSemigroup, "for a (0-)simple semigroup",
[IsSemigroup],
1,  # Try this before the method in conglatt.gi
function(S)
  local iso, R, congs, i;
  if not (IsFinite(S)
      and (IsSimpleSemigroup(S) or IsZeroSimpleSemigroup(S))) then
    TryNextMethod();
  elif IsReesMatrixSemigroup(S) or IsReesZeroMatrixSemigroup(S) then
    return CongruencesOfSemigroup(S);
  elif IsSimpleSemigroup(S) then
    iso := IsomorphismReesMatrixSemigroup(S);
  else
    iso := IsomorphismReesZeroMatrixSemigroup(S);
  fi;
  R := Range(iso);
  congs := ShallowCopy(CongruencesOfSemigroup(R));
  if IsReesMatrixSemigroup(R) then
    # The universal congruence has a linked triple
    return List(congs,
                x -> CongruenceByIsomorphism(iso, x));
  else
    # The universal congruence has no linked triple
    for i in [1 .. Length(congs)] do
      if IsRZMSCongruenceByLinkedTriple(congs[i]) then
        congs[i] := CongruenceByIsomorphism(iso, congs[i]);
      else
        congs[i] := UniversalSemigroupCongruence(S);
      fi;
    od;
    return congs;
  fi;
end);

InstallMethod(\=,
"for two (0-)simple semigroup congruences",
[IsSimpleSemigroupCongruence, IsSimpleSemigroupCongruence],
function(lhop, rhop)
  return lhop!.rmscong = rhop!.rmscong;
end);

InstallMethod(JoinSemigroupCongruences,
"for two (0-)simple semigroup congruences",
[IsSimpleSemigroupCongruence, IsSimpleSemigroupCongruence],
function(lhop, rhop)
  local join;
  join := JoinSemigroupCongruences(lhop!.rmscong, rhop!.rmscong);
  return CongruenceByIsomorphism(lhop!.iso, join);
end);

InstallMethod(MeetSemigroupCongruences,
"for two (0-)simple semigroup congruences",
[IsSimpleSemigroupCongruence, IsSimpleSemigroupCongruence],
function(lhop, rhop)
  local meet;
  meet := MeetSemigroupCongruences(lhop!.rmscong, rhop!.rmscong);
  return CongruenceByIsomorphism(lhop!.iso, meet);
end);

InstallMethod(CongruenceTestMembershipNC,
"for (0-)simple semigroup congruence and two multiplicative elements",
[IsSimpleSemigroupCongruence,
 IsMultiplicativeElement,
 IsMultiplicativeElement],
function(C, x, y)
  return [x ^ C!.iso, y ^ C!.iso] in C!.rmscong;
end);

InstallMethod(ImagesElm,
"for a (0-)simple semigroup congruence and a multiplicative element",
[IsSimpleSemigroupCongruence, IsMultiplicativeElement],
function(C, x)
  return List(ImagesElm(C!.rmscong, x ^ C!.iso),
              y -> y ^ InverseGeneralMapping(C!.iso));
end);

BindGlobal("_SimpleClassFromRMSclass",
function(C, rmsclass)
  local fam, class;
  fam := FamilyObj(Range(C));
  class := Objectify(NewType(fam, IsSimpleSemigroupCongruenceClass),
                     rec(rmsclass := rmsclass, iso := C!.iso));
  SetParentAttr(class, Range(C));
  SetEquivalenceClassRelation(class, C);
  SetRepresentative(class, Representative(rmsclass) ^
                           InverseGeneralMapping(C!.iso));
  return class;
end);

InstallMethod(EquivalenceClasses,
"for a (0-)simple semigroup congruence",
[IsSimpleSemigroupCongruence],
function(C)
  return List(EquivalenceClasses(C!.rmscong),
              c -> _SimpleClassFromRMSclass(C, c));
end);

InstallMethod(EquivalenceClassOfElementNC,
"for a (0-)simple semigroup congruence and multiplicative element",
[IsSimpleSemigroupCongruence, IsMultiplicativeElement],
function(C, elm)
  local class;
  class := EquivalenceClassOfElementNC(C!.rmscong, elm ^ C!.iso);
  return _SimpleClassFromRMSclass(C, class);
end);

InstallMethod(NrEquivalenceClasses,
"for a (0-)simple semigroup congruence",
[IsSimpleSemigroupCongruence],
function(C)
  return NrEquivalenceClasses(C!.rmscong);
end);

InstallMethod(\in,
"for a multiplicative element and a (0-)simple semigroup congruence class",
[IsMultiplicativeElement, IsSimpleSemigroupCongruenceClass],
function(x, class)
  return (x ^ EquivalenceClassRelation(class)!.iso in class!.rmsclass);
end);

InstallMethod(Size,
"for a (0-)simple semigroup congruence class",
[IsSimpleSemigroupCongruenceClass],
function(class)
  return Size(class!.rmsclass);
end);

InstallMethod(\=,
"for two (0-)simple semigroup congruence classes",
[IsSimpleSemigroupCongruenceClass, IsSimpleSemigroupCongruenceClass],
function(lhop, rhop)
  return lhop!.rmsclass = rhop!.rmsclass;
end);

InstallMethod(GeneratingPairsOfSemigroupCongruence,
"for a (0-)simple semigroup congruence",
[IsSimpleSemigroupCongruence],
function(C)
  local map;
  map := InverseGeneralMapping(C!.iso);
  return List(GeneratingPairsOfSemigroupCongruence(C!.rmscong),
               x -> [x[1] ^ map, x[2] ^ map]);
end);

InstallMethod(IsSubrelation,
"for two (0-)simple semigroup congruences",
[IsSimpleSemigroupCongruence, IsSimpleSemigroupCongruence],
function(lhop, rhop)
  return IsSubrelation(lhop!.rmscong, rhop!.rmscong);
end);

InstallMethod(EquivalenceRelationPartition,
"for a (0-)simple semigroup congruence",
[IsSimpleSemigroupCongruence],
function(C)
  local map;
  map := InverseGeneralMapping(C!.iso);
  return List(EquivalenceRelationPartition(C!.rmscong),
              C -> List(C, x -> x ^ map));
end);
