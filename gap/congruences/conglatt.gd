############################################################################
##
##  congruences/conglatt.gd
##  Copyright (C) 2016-2022                               Michael C. Young
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## This file contains functions for a poset of congruences.
##
## When the congruences of a semigroup are computed, they form a lattice with
## respect to containment.  The information about the congruences' positions in
## this lattice may be stored in an IsCongruencePoset object (a component object
## based on a record) and can be retrieved from this object using the methods in
## this file.
##

DeclareCategory("IsCongruencePoset", IsDigraph);

DeclareAttribute("CongruencesOfPoset", IsCongruencePoset);
DeclareAttribute("UnderlyingSemigroupOfCongruencePoset", IsCongruencePoset);

DeclareAttribute("LatticeOfCongruences", IsSemigroup);
DeclareAttribute("LatticeOfLeftCongruences", IsSemigroup);
DeclareAttribute("LatticeOfRightCongruences", IsSemigroup);
DeclareOperation("LatticeOfCongruences",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("LatticeOfLeftCongruences",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("LatticeOfRightCongruences",
                 [IsSemigroup, IsMultiplicativeElementCollection]);

DeclareAttribute("PosetOfPrincipalCongruences", IsSemigroup);
DeclareAttribute("PosetOfPrincipalLeftCongruences", IsSemigroup);
DeclareAttribute("PosetOfPrincipalRightCongruences", IsSemigroup);
DeclareOperation("PosetOfPrincipalCongruences",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("PosetOfPrincipalLeftCongruences",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("PosetOfPrincipalRightCongruences",
                 [IsSemigroup, IsMultiplicativeElementCollection]);

DeclareOperation("PosetOfCongruences", [IsListOrCollection]);

DeclareOperation("JoinSemilatticeOfCongruences",
                 [IsListOrCollection, IsFunction]);
DeclareOperation("JoinSemilatticeOfCongruences",
                 [IsCongruencePoset, IsFunction]);

DeclareAttribute("MinimalCongruences", IsListOrCollection);
DeclareAttribute("MinimalCongruences", IsCongruencePoset);

DeclareAttribute("Size", IsCongruencePoset);

DeclareAttribute("CongruencesOfSemigroup", IsSemigroup);
DeclareAttribute("LeftCongruencesOfSemigroup", IsSemigroup);
DeclareAttribute("RightCongruencesOfSemigroup", IsSemigroup);

DeclareAttribute("MinimalCongruencesOfSemigroup", IsSemigroup);
DeclareAttribute("MinimalLeftCongruencesOfSemigroup", IsSemigroup);
DeclareAttribute("MinimalRightCongruencesOfSemigroup", IsSemigroup);

DeclareOperation("MinimalCongruencesOfSemigroup",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("MinimalLeftCongruencesOfSemigroup",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("MinimalRightCongruencesOfSemigroup",
                 [IsSemigroup, IsMultiplicativeElementCollection]);

DeclareAttribute("PrincipalCongruencesOfSemigroup", IsSemigroup);
DeclareAttribute("PrincipalLeftCongruencesOfSemigroup", IsSemigroup);
DeclareAttribute("PrincipalRightCongruencesOfSemigroup", IsSemigroup);

DeclareOperation("PrincipalCongruencesOfSemigroup",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("PrincipalLeftCongruencesOfSemigroup",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
DeclareOperation("PrincipalRightCongruencesOfSemigroup",
                 [IsSemigroup, IsMultiplicativeElementCollection]);
