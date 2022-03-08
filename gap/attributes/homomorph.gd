#############################################################################
##
##  homomorph.gd
##  Copyright (C) 2022                               Artemis Konstantinidi
##                                                         Chinmaya Nagpal
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

DeclareOperation("SemigroupHomomorphismByImages",
        [IsSemigroup, IsSemigroup, IsList, IsList]);

DeclareOperation("SemigroupHomomorphismByImagesNC2",
        [IsSemigroup, IsSemigroup, IsList, IsList]);

DeclareOperation("SemigroupHomomorphismByFunction",
        [IsSemigroup, IsSemigroup, IsFunction]);

DeclareOperation("SemigroupHomomorphismByFunctionNC",
        [IsSemigroup, IsSemigroup, IsFunction]);

DeclareRepresentation("IsSemigroupHomomorphism2", 
	IsSemigroupGeneralMapping and IsAttributeStoringRep and
	IsSingleValued and IsTotal, []);

DeclareRepresentation("IsSemigroupHomomorphismByImages",
        IsSemigroupGeneralMapping and IsSPGeneralMapping and
        IsAttributeStoringRep and IsSingleValued and IsTotal, []);

DeclareRepresentation("IsSemigroupHomomorphismByFunction",
        IsSemigroupGeneralMapping and IsSPMappingByFunctionRep and
        IsAttributeStoringRep and IsSingleValued and IsTotal, []);
