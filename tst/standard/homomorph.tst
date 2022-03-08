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
gap> START_TEST("Semigroups package: standard/homomorph.tst");
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
gap> gens := GeneratorsOfSemigroup(S);;

# Test for every generator in the first list is in the first semigroup
gap> y := [IdentityTransformation, Transformation([2, 3, 1]),        
>       Transformation([2, 1]), Transformation([1, 1, 1, 1])];;
gap> SemigroupHomomorphismByImages(S, S, y, gens);
Error, the 3rd argument (a list) must consist of elements of the 1st argument \
(a semigroup)

# Test for the first list generating the first semigroup
gap> z := [Transformation([2, 3, 1]), Transformation([2, 1])];;
gap> SemigroupHomomorphismByImages(S, S, z, gens);
Error, the 1st argument (a semigroup) is not generated by the 3rd argument (a \
list)

# Test for every element in the second list in the second semigroup
gap> SemigroupHomomorphismByImages(S, S, gens, y);
Error, the 4th argument (a list) must consist of elements of the 2nd argument \
(a semigroup)

# Test for the two lists being the same size
gap> j := [IdentityTransformation, Transformation([2, 3, 1]), 
>  Transformation([2, 1]), Transformation([1, 2, 1]), 
>  Transformation([1, 1])];;
gap> SemigroupHomomorphismByImages(S, S, j, gens);
Error, the 3rd argument (a list) and the 4th argument (a list) are not the sam\
e size

# Tests with the same group
gap> imgs := List([1 .. 4], x -> ConstantTransformation(3, 1));;
gap> hom1 := SemigroupHomomorphismByImages(S, S, gens, imgs);;
gap> Source(hom1) = S;
true
gap> Range(hom1) = S;
true
gap> hom2 := SemigroupHomomorphismByImages(S, S, gens, gens);;
gap> Range(hom2) = S;
true
gap> Source(hom2) = S;
true
gap> ImagesSource(hom2) = S;
true
gap> map := hom2;;
gap> ForAll(S, x -> ForAll(S, y -> (x * y) ^ map = x ^ map * y ^ map));
true
gap> x := ConstantTransformation(2, 1);
Transformation( [ 1, 1 ] )
gap> x ^ map;
Transformation( [ 1, 1 ] )
gap> imgs2 := [gens[2], gens[2], gens[1], gens[3]];;
gap> hom3 := SemigroupHomomorphismByImages(S, S, gens, imgs2);
fail

# Tests with semigroups of different sizes
gap> J := FullTransformationMonoid(4);
<full transformation monoid of degree 4>
gap> hom := SemigroupHomomorphismByImages(S, J, gens, imgs);
[ IdentityTransformation, Transformation( [ 2, 3, 1 ] ), 
  Transformation( [ 2, 1 ] ), Transformation( [ 1, 2, 1 ] ) ] -> 
[ Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1, 1 ] ), 
  Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1, 1 ] ) ]
gap> J := FullTransformationMonoid(2);
<full transformation monoid of degree 2>
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

# Tests with semigroups to the trivial semigroup
gap> T := Semigroup(IdentityTransformation);
<trivial transformation group of degree 0 with 1 generator>
gap> S := GLM(2, 2);
<general linear monoid 2x2 over GF(2)>
gap> gens := GeneratorsOfSemigroup(S);
[ Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), 0*Z(2)]]) ]
gap> imgs := ListX(gens, x -> IdentityTransformation);
[ IdentityTransformation, IdentityTransformation, IdentityTransformation, 
  IdentityTransformation ]
gap> hom:= SemigroupHomomorphismByImages(S, T, gens, imgs);
[ Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[Z(2)^0, Z(2)^0], [0*Z(2), Z(2)^0]]), 
  Matrix(GF(2), [[0*Z(2), Z(2)^0], [Z(2)^0, 0*Z(2)]]), 
  Matrix(GF(2), [[Z(2)^0, 0*Z(2)], [0*Z(2), 0*Z(2)]]) ] -> 
[ IdentityTransformation, IdentityTransformation, IdentityTransformation, 
  IdentityTransformation ]
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

# Test with quotient semigroup
gap> S := Semigroup([Transformation([2, 1, 5, 1, 5]),
>       Transformation([1, 1, 1, 5, 3]), Transformation([2, 5, 3, 5, 3])]);;
gap> congs := CongruencesOfSemigroup(S);;
gap> cong := congs[3];;
gap> T := S / cong;;
gap> gens := GeneratorsOfSemigroup(S);;
gap> images := List(gens, gen -> EquivalenceClassOfElement(cong, gen));;
gap> hom := SemigroupHomomorphismByImagesNC2(S, T, gens, images);;
gap> gens[1] ^ hom;              
<congruence class of Transformation( [ 2, 1, 5, 1, 5 ] )>
gap> ImageElm(hom, gens[1]);
<congruence class of Transformation( [ 2, 1, 5, 1, 5 ] )>
gap> IsSurjective(hom);
true
gap> hom1 := hom;;
gap> hom1 = hom;
true
gap> gens2 := [gens[3], gens[1], gens[2]];;
gap> images2 := [images[3], images[1], images[2]];;
gap> hom2 := SemigroupHomomorphismByImages(Semigroup(gens2),
>       Semigroup(images2), gens2, images2);;
gap> hom = hom2;
true

# Test with transformation semigroup isomorphic to quotient semigroup above
gap> map := IsomorphismTransformationSemigroup(ImagesSource(hom));;
gap> K := Range(map);;
gap> images3 := GeneratorsOfSemigroup(K);;
gap> hom3 := SemigroupHomomorphismByImages(S, K, gens, images3);;
gap> ImagesSource(hom3);
<transformation semigroup of degree 7 with 3 generators>
gap> PreImagesRange(hom3);
<transformation semigroup of size 59, degree 5 with 3 generators>
gap> PreImagesRepresentative(hom3, images3[2]);
Transformation( [ 1, 1, 1, 5, 3 ] )
gap> PreImagesSet(hom3, images3{[2..3]});
[ Transformation( [ 1, 1, 1, 5, 3 ] ), Transformation( [ 2, 5, 3, 5, 3 ] ) ]
gap> ImageElm(hom3, gens[1]);
Transformation( [ 4, 5, 5, 1, 5, 5, 1 ] )
gap> IsSurjective(hom3);
true
gap> SEMIGROUPS.StopTest();
gap> STOP_TEST("Semigroups package: standard/homomorph.tst");
