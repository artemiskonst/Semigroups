############################################################################
##
#W  acting.gd
#Y  Copyright (C) 2013-15                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

DeclareCategory("IsSemigroupData", IsList);
DeclareFilter("IsClosedData", IsSemigroupData);

DeclareAttribute("SemigroupData", IsActingSemigroup, "mutable");

DeclareOperation("Enumerate", [IsSemigroupData]);
DeclareOperation("Enumerate", [IsSemigroupData, IsCyclotomic]);
DeclareOperation("Enumerate", [IsSemigroupData, IsCyclotomic, IsFunction]);
DeclareOperation("OrbitGraphAsSets", [IsSemigroupData]);
DeclareOperation("OrbitGraph", [IsSemigroupData]);
DeclareOperation("PositionOfFound", [IsSemigroupData]);

# these must be here since SEMIGROUPS.UniversalFakeOne is used in lots of other
# places

DeclareCategory("SEMIGROUPS_IsUniversalFakeOne", IsAssociativeElement);

SEMIGROUPS.UniversalFakeOne :=
           Objectify(NewType(NewFamily("SEMIGROUPS.UniversalFakeOneFamily",
                                       SEMIGROUPS_IsUniversalFakeOne,
                                       CanEasilyCompareElements,
                                       CanEasilyCompareElements),
                             SEMIGROUPS_IsUniversalFakeOne),
                     rec());
