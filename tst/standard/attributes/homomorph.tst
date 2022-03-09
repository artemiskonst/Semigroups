#############################################################################
##
#W  standard/homomorph.tst
#Y  Copyright (C) 2022                               Artemis Konstantinidi
##                                                         Chinmaya Nagpal
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("Semigroups package: standard/attributes/homomorph.tst");
gap> LoadPackage("semigroups", false);;

#
gap> SEMIGROUPS.StartTest();

# helper functions
gap> BruteForceHomoCheck := function(homo)
>   local x, y;
>   for x in Generators(Source(homo)) do
>     for y in Generators(Source(homo)) do
>       if x ^ homo * y ^ homo <> (x * y) ^ homo then
>         return false;
>       fi;
>     od;
>   od;
>   return true;
> end;;
gap> S := FullTransformationMonoid(3);
<full transformation monoid of degree 3>
gap> gens := GeneratorsOfSemigroup(S);
[ IdentityTransformation, Transformation( [ 2, 3, 1 ] ), 
  Transformation( [ 2, 1 ] ), Transformation( [ 1, 2, 1 ] ) ]

# Test for every generator in the first list is in the first semigroup
gap> S := FullTransformationMonoid(3);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> y := [IdentityTransformation, Transformation([2, 3, 1]),        
>       Transformation([2, 1]), Transformation([1, 1, 1, 1])];;
gap> SemigroupHomomorphismByImages(S, S, y, gens);
Error, the 3rd argument (a list) must consist of elements of the 1st argument \
(a semigroup)

# Test for every element in the second list in the second semigroup
gap> S := FullTransformationMonoid(3);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> y := [IdentityTransformation, Transformation([2, 3, 1]),        
>       Transformation([2, 1]), Transformation([1, 1, 1, 1])];;
gap> SemigroupHomomorphismByImages(S, S, gens, y);
Error, the 4th argument (a list) must consist of elements of the 2nd argument \
(a semigroup)

# Test for the first list generating the first semigroup
gap> S := FullTransformationMonoid(3);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> z := [Transformation([2, 3, 1]), Transformation([2, 3, 1]),
>  Transformation([2, 1]), Transformation([2, 1])];;
gap> SemigroupHomomorphismByImages(S, S, z, gens);
Error, the 1st argument (a semigroup) is not generated by the 3rd argument (a \
list)

# Test for the two lists being the same size
gap> S := FullTransformationMonoid(3);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> j := [IdentityTransformation, Transformation([2, 3, 1]), 
>  Transformation([2, 1]), Transformation([1, 2, 1]), 
>  Transformation([1, 1])];;
gap> SemigroupHomomorphismByImages(S, S, j, gens);
Error, the 3rd argument (a list) and the 4th argument (a list) are not the sam\
e size

# Check that isomorphism work
gap> S := Semigroup([
>  Matrix(IsNTPMatrix, [[0, 1, 2], [4, 3, 0], [0, 2, 0]], 9, 4),
>  Matrix(IsNTPMatrix, [[1, 1, 0], [4, 1, 1], [0, 0, 0]], 9, 4)]);
<semigroup of 3x3 ntp matrices with 2 generators>
gap> gens := GeneratorsOfSemigroup(S);;  
gap> T := AsSemigroup(IsTransformationSemigroup, S);
<transformation semigroup of size 46, degree 47 with 2 generators>
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);;
gap> BruteForceHomoCheck(hom);
true
gap> Source(hom) = S;
true
gap> Range(hom) = T;
true
gap> S := Semigroup(IdentityTransformation);
<trivial transformation group of degree 0 with 1 generator>
gap> gens := GeneratorsOfSemigroup(S);; 
gap> T := Semigroup(PartialPerm([]));
<trivial partial perm group of rank 0 with 1 generator>
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);;
gap> BruteForceHomoCheck(hom);
true

# homomorph: SemigroupHomomorphismByImages, for infinite semigroup(s)
gap> S := FreeSemigroup(1);;
gap> gens := GeneratorsOfSemigroup(S);; 
gap> T := TrivialSemigroup();;
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 2nd choice method found for `IsomorphismFpSemigroup' on 1 arguments

# homomorph: SemigroupHomomorphismByImages, for trivial semigroups
gap> S := TrivialSemigroup(IsTransformationSemigroup);
<trivial transformation group of degree 0 with 1 generator>
gap> gens := GeneratorsOfSemigroup(S);; 
gap> T := TrivialSemigroup(IsBipartitionSemigroup);
<trivial block bijection group of degree 1 with 1 generator>
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);;
gap> BruteForceHomoCheck(hom);
true

# homomorph: SemigroupHomomorphismByImages, for monogenic semigroups
gap> S := MonogenicSemigroup(IsTransformationSemigroup, 3, 2);
<commutative non-regular transformation semigroup of size 4, degree 5 with 1 
 generator>
gap> gens := GeneratorsOfSemigroup(S);; 
gap> T := MonogenicSemigroup(IsBipartitionSemigroup, 3, 2);
<commutative non-regular block bijection semigroup of size 4, degree 6 with 1 
 generator>
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);
[ Transformation( [ 2, 1, 2, 3, 4 ] ) ] -> 
[ <block bijection: [ 1, -2 ], [ 2, -1 ], [ 3, 4, -3, -6 ], [ 5, -4 ], 
     [ 6, -5 ]> ]
gap> BruteForceHomoCheck(map);
true

# homomorph: SemigroupHomomorphismByImages, for simple semigroups
gap> S := ReesMatrixSemigroup(SymmetricGroup(3), [[(), (1, 3, 2)],
>                                                 [(2, 3), (1, 2)],
>                                                 [(), (2, 3, 1)]]);
<Rees matrix semigroup 2x3 over Sym( [ 1 .. 3 ] )>
gap> gensS := GeneratorsOfSemigroup(S);;
gap> U := AsSemigroup(IsBipartitionSemigroup, S);
<bipartition semigroup of size 36, degree 37 with 4 generators>
gap> gensU := GeneratorsOfSemigroup(U);;
gap> V := AsSemigroup(IsTransformationSemigroup, S);
<transformation semigroup of size 36, degree 37 with 4 generators>
gap> gensV := GeneratorsOfSemigroup(V);;
gap> hom := SemigroupHomomorphismByImages(S, U, gensS, gensU);;
gap> BruteForceHomoCheck(hom);
true
gap> hom := SemigroupHomomorphismByImages(U, S, gensU, gensS);;
gap> BruteForceHomoCheck(hom);
true
gap> hom := SemigroupHomomorphismByImages(U, V, gensU, gensV);;
gap> BruteForceHomoCheck(hom);
true

# homomorph: SemigroupHomomorphismByImages, for 0-simple semigroups
gap> S := ReesZeroMatrixSemigroup(SymmetricGroup(3), [[(), (1, 3, 2)],
>                                                     [0, (1, 2)],
>                                                     [(), (2, 3, 1)]]);
<Rees 0-matrix semigroup 2x3 over Sym( [ 1 .. 3 ] )>
gap> gensS := GeneratorsOfSemigroup(S);;
gap> T := ReesZeroMatrixSemigroup(SymmetricGroup(3), [[(), ()],
>                                                     [(), ()],
>                                                     [(), 0]]);
<Rees 0-matrix semigroup 2x3 over Sym( [ 1 .. 3 ] )>
gap> gensT := GeneratorsOfSemigroup(T);;
gap> U := AsSemigroup(IsBipartitionSemigroup, S);
<bipartition semigroup of size 37, degree 38 with 5 generators>
gap> gensU := GeneratorsOfSemigroup(U);;
gap> V := AsSemigroup(IsTransformationSemigroup, S);
<transformation semigroup of size 37, degree 38 with 5 generators>
gap> gensV := GeneratorsOfSemigroup(V);;
gap> hom := SemigroupHomomorphismByImages(S, U, gensS, gensU);;
gap> BruteForceHomoCheck(hom);
true
gap> hom := SemigroupHomomorphismByImages(U, S, gensU, gensS);;
gap> BruteForceHomoCheck(hom);
true
gap> hom := SemigroupHomomorphismByImages(U, V, gensU, gensV);;
gap> BruteForceHomoCheck(hom);
true
gap> SemigroupHomomorphismByImages(U, T, gensU, gensT);
fail
gap> F := FreeSemigroup(1);;
gap> F := F / [[F.1 ^ 4, F.1]];;
gap> S := ReesZeroMatrixSemigroup(F, [[F.1]]);;
gap> gens := GeneratorsOfSemigroup(S);; 
gap> T := ReesZeroMatrixSemigroup(F, [[F.1 ^ 2]]);;
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);;
gap> BruteForceHomoCheck(map);
true

# for monogenic semigroups
gap> S := MonogenicSemigroup(4, 5);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> T := MonogenicSemigroup(20, 1);;
gap> imgs := GeneratorsOfSemigroup(T);;
gap> SemigroupHomomorphismByImages(S, T, gens, imgs);
fail
gap> S := MonogenicSemigroup(1, 4);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> T := MonogenicSemigroup(2, 3);;
gap> imgs := GeneratorsOfSemigroup(T);;
gap> SemigroupHomomorphismByImages(S, T, gens, imgs);
fail
gap> S := MonogenicSemigroup(1, 4);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> T := Semigroup(Generators(S) ^ (1, 2));;
gap> imgs := GeneratorsOfSemigroup(T);;
gap> SemigroupHomomorphismByImages(S, T, gens, imgs) <> fail;
true

# SemigroupHomomorphismByImages
gap> S := FullTransformationMonoid(3);
<full transformation monoid of degree 3>
gap> gens := GeneratorsOfSemigroup(S);;
gap> T := AsMonoid(IsPBRMonoid, S);
<pbr monoid of size 27, degree 3 with 3 generators>
gap> imgs := GeneratorsOfSemigroup(T);;
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);
[ IdentityTransformation, Transformation( [ 2, 3, 1 ] ), 
  Transformation( [ 2, 1 ] ), Transformation( [ 1, 2, 1 ] ) ] -> 
[ PBR([ [ -1 ], [ -2 ], [ -3 ] ], [ [ 1 ], [ 2 ], [ 3 ] ]), 
  PBR([ [ -2 ], [ -3 ], [ -1 ] ], [ [ 3 ], [ 1 ], [ 2 ] ]), 
  PBR([ [ -2 ], [ -1 ], [ -3 ] ], [ [ 2 ], [ 1 ], [ 3 ] ]), 
  PBR([ [ -1 ], [ -2 ], [ -1 ] ], [ [ 1, 3 ], [ 2 ], [  ] ]) ]
gap> BruteForceHomoCheck(hom);
true

# Tests with the same group
gap> S := FullTransformationMonoid(3);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> imgs := List([1 .. 4], x -> ConstantTransformation(3, 1));;
gap> hom1 := SemigroupHomomorphismByImages(S, S, gens, imgs);;
gap> BruteForceHomoCheck(hom1);
true
gap> Source(hom1) = S;
true
gap> Range(hom1) = S;
true
gap> hom2 := SemigroupHomomorphismByImages(S, S, gens, gens);;
gap> BruteForceHomoCheck(hom2);
true
gap> Range(hom2) = S;
true
gap> Source(hom2) = S;
true
gap> ImagesSource(hom2) = S;
true
gap> map := hom2;;
gap> ForAll(S, x -> ForAll(S, y -> (x * y) ^ map = x ^ map * y ^ map));
true
gap> IsSurjective(hom2);
true
gap> IsInjective(hom2);
true
gap> IsBijective(hom2);
true
gap> x := ConstantTransformation(2, 1);
Transformation( [ 1, 1 ] )
gap> x ^ map;
Transformation( [ 1, 1 ] )
gap> imgs2 := [gens[2], gens[2], gens[1], gens[3]];;
gap> hom3 := SemigroupHomomorphismByImages(S, S, gens, imgs2);
fail

# Tests with semigroups of different sizes
gap> S := FullTransformationMonoid(3);;
gap> gens := GeneratorsOfSemigroup(S);;
gap> J := FullTransformationMonoid(4);;
gap> imgs := List([1 .. 4], x -> ConstantTransformation(3, 1));;
gap> hom := SemigroupHomomorphismByImages(S, J, gens, imgs);
[ IdentityTransformation, Transformation( [ 2, 3, 1 ] ), 
  Transformation( [ 2, 1 ] ), Transformation( [ 1, 2, 1 ] ) ] -> 
[ Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1, 1 ] ), 
  Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1, 1 ] ) ]
gap> BruteForceHomoCheck(hom);
true
gap> J := FullTransformationMonoid(2);;
gap> ImagesSource(hom);
<transformation semigroup of degree 3 with 4 generators>
gap> PreImagesElm(hom, Transformation([1, 1, 1]));
[ Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1, 2 ] ), 
  Transformation( [ 1, 1 ] ), Transformation( [ 1, 2, 1 ] ), 
  Transformation( [ 1, 2, 2 ] ), IdentityTransformation, 
  Transformation( [ 1, 3, 1 ] ), Transformation( [ 1, 3, 2 ] ), 
  Transformation( [ 1, 3, 3 ] ), Transformation( [ 2, 1, 1 ] ), 
  Transformation( [ 2, 1, 2 ] ), Transformation( [ 2, 1 ] ), 
  Transformation( [ 2, 2, 1 ] ), Transformation( [ 2, 2, 2 ] ), 
  Transformation( [ 2, 2 ] ), Transformation( [ 2, 3, 1 ] ), 
  Transformation( [ 2, 3, 2 ] ), Transformation( [ 2, 3, 3 ] ), 
  Transformation( [ 3, 1, 1 ] ), Transformation( [ 3, 1, 2 ] ), 
  Transformation( [ 3, 1, 3 ] ), Transformation( [ 3, 2, 1 ] ), 
  Transformation( [ 3, 2, 2 ] ), Transformation( [ 3, 2, 3 ] ), 
  Transformation( [ 3, 3, 1 ] ), Transformation( [ 3, 3, 2 ] ), 
  Transformation( [ 3, 3, 3 ] ) ]
gap> PreImagesSet(hom, [Transformation([1, 1, 1])]);
[ Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1, 2 ] ), 
  Transformation( [ 1, 1 ] ), Transformation( [ 1, 2, 1 ] ), 
  Transformation( [ 1, 2, 2 ] ), IdentityTransformation, 
  Transformation( [ 1, 3, 1 ] ), Transformation( [ 1, 3, 2 ] ), 
  Transformation( [ 1, 3, 3 ] ), Transformation( [ 2, 1, 1 ] ), 
  Transformation( [ 2, 1, 2 ] ), Transformation( [ 2, 1 ] ), 
  Transformation( [ 2, 2, 1 ] ), Transformation( [ 2, 2, 2 ] ), 
  Transformation( [ 2, 2 ] ), Transformation( [ 2, 3, 1 ] ), 
  Transformation( [ 2, 3, 2 ] ), Transformation( [ 2, 3, 3 ] ), 
  Transformation( [ 3, 1, 1 ] ), Transformation( [ 3, 1, 2 ] ), 
  Transformation( [ 3, 1, 3 ] ), Transformation( [ 3, 2, 1 ] ), 
  Transformation( [ 3, 2, 2 ] ), Transformation( [ 3, 2, 3 ] ), 
  Transformation( [ 3, 3, 1 ] ), Transformation( [ 3, 3, 2 ] ), 
  Transformation( [ 3, 3, 3 ] ) ]
gap> PreImagesRepresentative(hom, Transformation([1, 1, 1]));
IdentityTransformation
gap> IsSurjective(hom);
false
gap> IsInjective(hom);
false
gap> IsBijective(hom);
false

# Tests with semigroups to the trivial semigroup
gap> T := Semigroup(IdentityTransformation);;
gap> S := GLM(2, 2);;
gap> gens := GeneratorsOfSemigroup(S);
[ Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), 0*Z(2)]]) ]
gap> imgs := ListX(gens, x -> IdentityTransformation);
[ IdentityTransformation, IdentityTransformation, IdentityTransformation, 
  IdentityTransformation ]
gap> hom := SemigroupHomomorphismByImages(S, T, gens, imgs);
[ Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), 0*Z(2)]]) ] -> 
[ IdentityTransformation, IdentityTransformation, IdentityTransformation, 
  IdentityTransformation ]
gap> BruteForceHomoCheck(hom);
true
gap> PreImagesElm(hom, IdentityTransformation);
[ Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [Z(2)^0, Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), 0*Z(2)], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [0*Z(2), 0*Z(2)]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [0*Z(2), 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [Z(2)^0, Z(2)^0]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[0*Z(2), 0*Z(2)], [Z(2)^0, Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), 0*Z(2)], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), 0*Z(2)], [0*Z(2), 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [Z(2)^0, Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [0*Z(2), Z(2)^0]]) ]
gap> IsSurjective(hom);
true
gap> IsInjective(hom);
false

# Test with quotient semigroup
gap> S := Semigroup([Transformation([2, 1, 5, 1, 5]),
>       Transformation([1, 1, 1, 5, 3]), Transformation([2, 5, 3, 5, 3])]);;
gap> congs := CongruencesOfSemigroup(S);;
gap> cong := congs[3];;
gap> T := S / cong;;
gap> gens := GeneratorsOfSemigroup(S);;
gap> images := List(gens, gen -> EquivalenceClassOfElement(cong, gen));;
gap> hom1 := SemigroupHomomorphismByImagesNC2(S, T, gens, images);;
gap> BruteForceHomoCheck(hom1);
true
gap> gens[1] ^ hom1;              
<congruence class of Transformation( [ 2, 1, 5, 1, 5 ] )>
gap> ImageElm(hom1, gens[1]);
<congruence class of Transformation( [ 2, 1, 5, 1, 5 ] )>
gap> IsSurjective(hom1);
true
gap> IsInjective(hom1);
false
gap> hom2 := hom1;;
gap> hom2 = hom1;
true
gap> gens2 := [gens[3], gens[1], gens[2]];;
gap> images2 := [images[3], images[1], images[2]];;
gap> hom2 := SemigroupHomomorphismByImages(Semigroup(gens2),
>       Semigroup(images2), gens2, images2);;
gap> BruteForceHomoCheck(hom2);
true
gap> hom1 = hom2;
true

# Test with transformation semigroup isomorphic to quotient semigroup above
gap> S := Semigroup([Transformation([2, 1, 5, 1, 5]),
>       Transformation([1, 1, 1, 5, 3]), Transformation([2, 5, 3, 5, 3])]);;
gap> congs := CongruencesOfSemigroup(S);;
gap> cong := congs[3];;
gap> T := S / cong;;
gap> gens := GeneratorsOfSemigroup(S);;
gap> images := List(gens, gen -> EquivalenceClassOfElement(cong, gen));;
gap> hom1 := SemigroupHomomorphismByImagesNC2(S, T, gens, images);;
gap> BruteForceHomoCheck(hom1);
true
gap> map := IsomorphismTransformationSemigroup(ImagesSource(hom1));;
gap> K := Range(map);;
gap> images2 := GeneratorsOfSemigroup(K);;
gap> hom2 := SemigroupHomomorphismByImages(S, K, gens, images2);;
gap> BruteForceHomoCheck(hom2);
true
gap> ImagesSource(hom2);
<transformation semigroup of degree 7 with 3 generators>
gap> PreImagesRange(hom2);
<transformation semigroup of size 59, degree 5 with 3 generators>
gap> PreImagesRepresentative(hom2, images2[2]);
Transformation( [ 1, 1, 1, 5, 3 ] )
gap> PreImagesSet(hom2, images2{[2 .. 3]});
[ Transformation( [ 1, 1, 1, 5, 3 ] ), Transformation( [ 2, 5, 3, 5, 3 ] ) ]
gap> ImageElm(hom2, gens[1]);
Transformation( [ 4, 5, 5, 1, 5, 5, 1 ] )
gap> IsSurjective(hom2);
true
gap> IsInjective(hom2);
false
gap> IsBijective(hom2);
false
gap> gens3 := [gens[3], gens[1], gens[2]];;
gap> images3 := [images2[3], images2[1], images2[2]];;
gap> hom3 := SemigroupHomomorphismByImages(Semigroup(gens3),
>       Semigroup(images3), gens3, images3);;
gap> BruteForceHomoCheck(hom3);
true
gap> hom3 = hom2;
true

# Test with jumbled generators
gap> S := Semigroup([Transformation([2, 1, 5, 1, 5]), 
>  Transformation([1, 1, 1, 5, 3]), 
>  Transformation([2, 5, 3, 5, 3])]);;
gap> gens1 := GeneratorsOfSemigroup(S);;
gap> congs := CongruencesOfSemigroup(S);;
gap> cong := congs[3];;
gap> T := S / cong;;
gap> images1 := List(gens1, gen -> EquivalenceClassOfElement(cong, gen));;
gap> hom1 := SemigroupHomomorphismByImagesNC2(S, T, gens1, images1);;
gap> BruteForceHomoCheck(hom1);
true
gap> map := IsomorphismTransformationSemigroup(ImagesSource(hom1));;
gap> K := Range(map);;
gap> images2 := GeneratorsOfSemigroup(K);;
gap> hom2 := SemigroupHomomorphismByImages(S, K, gens1, images2);;
gap> BruteForceHomoCheck(hom1);
true
gap> gens1;
[ Transformation( [ 2, 1, 5, 1, 5 ] ), Transformation( [ 1, 1, 1, 5, 3 ] ), 
  Transformation( [ 2, 5, 3, 5, 3 ] ) ]
gap> gens2 := [gens1[3], gens1[1], gens1[2]];
[ Transformation( [ 2, 5, 3, 5, 3 ] ), Transformation( [ 2, 1, 5, 1, 5 ] ), 
  Transformation( [ 1, 1, 1, 5, 3 ] ) ]
gap> images2 := [images2[3], images2[1], images2[2]];
[ Transformation( [ 6, 5, 5, 3, 5, 5, 3 ] ), 
  Transformation( [ 4, 5, 5, 1, 5, 5, 1 ] ), 
  Transformation( [ 5, 5, 5, 5, 5, 5, 2 ] ) ]
gap> hom3 := SemigroupHomomorphismByImages(S, K, gens2, images2);
[ Transformation( [ 2, 5, 3, 5, 3 ] ), Transformation( [ 2, 1, 5, 1, 5 ] ), 
  Transformation( [ 1, 1, 1, 5, 3 ] ) ] -> 
[ Transformation( [ 6, 5, 5, 3, 5, 5, 3 ] ), 
  Transformation( [ 4, 5, 5, 1, 5, 5, 1 ] ), 
  Transformation( [ 5, 5, 5, 5, 5, 5, 2 ] ) ]
gap> BruteForceHomoCheck(hom3);
true
gap> String(hom3);
"[ Transformation( [ 2, 5, 3, 5, 3 ] ), Transformation( [ 2, 1, 5, 1, 5 ] ), T\
ransformation( [ 1, 1, 1, 5, 3 ] ) ] -> [ Transformation( [ 6, 5, 5, 3, 5, 5, \
3 ] ), Transformation( [ 4, 5, 5, 1, 5, 5, 1 ] ), Transformation( [ 5, 5, 5, 5\
, 5, 5, 2 ] ) ]"
gap> SEMIGROUPS.StopTest();
gap> STOP_TEST("Semigroups package: standard/attributes/homomorph.tst");
