#############################################################################
##
##  homomorph.gi
##  Copyright (C) 2022                               Artemis Konstantinidi
##                                                         Chinmaya Nagpal
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains a method for finding a homomorphism between semigroups
#

InstallMethod(SemigroupHomomorphismByImages, "for two semigroups and two lists",
[IsSemigroup, IsSemigroup, IsList, IsList],
function(S, T, gens, imgs)
  local map, R, rel;

  if not ForAll(gens, x -> x in S) then
    ErrorNoReturn("the 3rd argument (a list) must consist of elements ",
                  "of the 1st argument (a semigroup)");
  elif Size(Semigroup(gens)) <> Size(S) then
    ErrorNoReturn("the 1st argument (a semigroup) is not generated by ",
                  "the 3rd argument (a list)");
  elif not ForAll(imgs, x -> x in T) then
    ErrorNoReturn("the 4th argument (a list) must consist of elements ",
                  "of the 2nd argument (a semigroup)");
  elif Size(gens) <> Size(imgs) then
    ErrorNoReturn("the 3rd argument (a list) and the 4th argument ",
                  "(a list) are not the same size");
  fi;

  # maps S to a finitely presented semigroup
  map := IsomorphismFpSemigroup(S);   # S (source) -> fp semigroup (range)
  # List of relations of the above finitely presented semigroup (hence of S)
  R   := RelationsOfFpSemigroup(Range(map));

  # check that each relation is satisfied by the elements imgs
  for rel in R do
    rel := List(rel, x -> SEMIGROUPS.ExtRepObjToWord(ExtRepOfObj(x)));
    if EvaluateWord(imgs, rel[1]) <> EvaluateWord(imgs, rel[2]) then
      return fail;
    fi;
  od;

  return SemigroupHomomorphismByImagesNC2(S, T, gens, imgs);
end);

InstallMethod(SemigroupHomomorphismByImagesNC2,
"for two semigroups and two lists",
[IsSemigroup, IsSemigroup, IsList, IsList],
function(S, T, gens, imgs)
  local hom;
  # if HasGeneratorsOfGroup(G)
  #    and IsIdenticalObj(GeneratorsOfGroup(G),mapi[1]) then
  #   Append(obj_args, [PreImagesRange, G]);
  #   filter := filter and IsTotal and HasPreImagesRange;
  # fi;
  #
  # if HasGeneratorsOfGroup(H)
  #    and IsIdenticalObj(GeneratorsOfGroup(H),mapi[2]) then
  #   Append(obj_args, [ImagesSource, H]);
  #   filter := filter and IsSurjective and HasImagesSource;
  # fi;

  hom := Objectify(NewType(GeneralMappingsFamily(ElementsFamily(FamilyObj(S)),
                                                 ElementsFamily(FamilyObj(T))),
                           IsSemigroupHomomorphismByImages), rec());
  SetSource(hom, S);
  SetRange(hom, T);
  SetMappingGeneratorsImages(hom, [Immutable(gens), Immutable(imgs)]);

  return hom;
end);

InstallMethod(ImageElm, "for a semigroup homom. by images and element",
[IsSemigroupHomomorphismByImages, IsMultiplicativeElement],
function(hom, x)
  if not x in Source(hom) then
    ErrorNoReturn("the 2nd argument is not an element of the source of the ",
    "1st argument (semigroup homom. by images)");
  fi;
  return EvaluateWord(MappingGeneratorsImages(hom)[2],
                      Factorization(Source(hom), x));
end);

InstallMethod(ImagesSource, "for SHBI",
    [IsSemigroupHomomorphismByImages],
    hom -> SubsemigroupNC(Range(hom), MappingGeneratorsImages(hom)[2]));

InstallMethod(PreImagesRange, "for SHBI",
    [IsSemigroupHomomorphismByImages],
    hom -> SubsemigroupNC(Source(hom), MappingGeneratorsImages(hom)[1]));

InstallMethod(PreImagesRepresentative,
"for a semigroup homom. by images and an element in the range",
[IsSemigroupHomomorphismByImages, IsMultiplicativeElement],
function(hom, x)
  if not x in Range(hom) then
    ErrorNoReturn("the 2nd argument is not an element of the range of the ",
    "1st argument (semigroup homom. by images)");
  elif not x in ImagesSource(hom) then
    return fail;
  fi;
  return EvaluateWord(MappingGeneratorsImages(hom)[1],
                      Factorization(ImagesSource(hom), x));
end);

InstallMethod(PreImagesElm,
"for a semigroup homom. by images and an element in the range",
[IsSemigroupHomomorphismByImages, IsMultiplicativeElement],
function(hom, x)
  local preim, y;
  if not x in Range(hom) then
    ErrorNoReturn("the 2nd argument is not an element of the range of the ",
                  "1st argument (semigroup homom. by images)");
  elif not x in ImagesSource(hom) then
    ErrorNoReturn("the 2nd argument is not mapped to by the 1st argument ",
                  "(semigroup homom. by images)");
  fi;
  preim := [];
  for y in Source(hom) do
    if ImageElm(hom, y) = x then
      Add(preim, y);
    fi;
  od;
  return preim;
end);

InstallMethod(PreImagesSet,
"for a semigroup homom. by images and a set of elements in the range", 
[IsSemigroupHomomorphismByImages, IsList],
function(hom, elms)
  local y, preim;
  if not IsSubsetSet(AsList(Range(hom)), elms) then
    ErrorNoReturn("the 2nd argument is not a subset of the range of the ",
                  "1st argument (semigroup homom. by images)");
  fi;
  if not IsSubsetSet(AsList(ImagesSource(hom)), elms) then
    ErrorNoReturn("the 2nd argument is not a subset of the image of the ",
                  "source of the 1st argument (semigroup homom. by images)");
  fi;
  preim := [];
  for y in elms do
    Append(preim, PreImagesElm(hom, y));
  od;
  return preim;
end);

InstallMethod(ViewObj, "for SHBI",
    [IsSemigroupHomomorphismByImages],
function(hom)
  local mapi;
  mapi := MappingGeneratorsImages(hom);
  View(mapi[1]);
  Print(" -> ");
  View(mapi[2]);
end);

InstallMethod(String, "for SHBI",
    [IsSemigroupHomomorphismByImages],
function(hom)
  local mapi;
  mapi := MappingGeneratorsImages(hom);
  return Concatenation(String(mapi[1]), " -> ", String(mapi[2]));
end);

InstallMethod(PrintObj, "for semigroup homom. by images",
  [IsSemigroupHomomorphismByImages],
function(hom)
  local mapi;
  mapi := MappingGeneratorsImages(hom);
  Print("SemigroupHomomorphismByImages( ",
          Source(hom), ", ", Range(hom), ", ",
          mapi[1], ", ", mapi[2], " )");
end);

InstallMethod(\=, "compare homom. by images", IsIdenticalObj,
    [IsSemigroupHomomorphismByImages, IsSemigroupHomomorphismByImages],
function(hom1, hom2)
  local i;
  if Source(hom1) <> Source(hom2)
      or Range(hom1) <> Range(hom2)
      or PreImagesRange(hom1) <> PreImagesRange(hom2)
      or ImagesSource(hom1) <> ImagesSource(hom2) then
        return false;
  fi;
  hom1 := MappingGeneratorsImages(hom1);
  return hom1[2] = List(hom1[1], i -> ImageElm(hom2, i));
end);

InstallMethod(IsSurjective, "for semigroup homom. by images",
  [IsSemigroupHomomorphismByImages],
function(hom)
  if Size(ImagesSource(hom)) <> Size(Range(hom)) then
    return false;
  else
    return true;
  fi;
end);

InstallMethod(IsInjective, "for semigroup homom. by images",
  [IsSemigroupHomomorphismByImages],
function(hom)
  if Size(Source(hom)) <> Size(ImagesSource(hom)) then
    return false;
  else
    return true;
  fi;
end);
