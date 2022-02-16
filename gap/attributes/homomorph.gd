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

DeclareRepresentation("IsSemigroupHomomorphismByImages",
        IsSemigroupGeneralMapping and IsSPGeneralMapping and
        IsAttributeStoringRep, []);

DeclareOperation("ImageElm",
        [IsSemigroupHomomorphismByImages, IsMultiplicativeElement]);
