rand(range=5) {
	Random, r, -%range%, %range%
	return r
}

rand_range(min, max) {
	Random, r, %min%, %max%
	return r
}

rand_range_center(center, min, max) {
	Random, r, %min%, %max%
	center += r
	return center
}

set_rand_ref(ByRef var, min, max) {
	Random, r, %min%, %max%
	var = r
	return var
}

shift_rand_ref(ByRef var, min, max) {
	Random, r, %min%, %max%
	var += r
	return var
}

binomial(center, range, loops=10) {
	loop %loops% {
		Random r, 0, % range*2/loops
		sum += r
	}
	return sum-range+center
}

target_random(min, target, max){
	Random, lower, min, target
	Random, upper, target, max
	Random, weighted, lower, upper
	Return, weighted
}

; https://autohotkey.com/board/topic/64617-normaly-distributed-random-number/
NormalRand(x,y,int=1) { ;x lower y upper int for integer return
Loop 12
 {
 Random, var,0.0,1
 Num+=var
 }
norm := Round((y+x)/2+((Num-6)*(y-x))/6)
Return norm < x ? x : norm > y ? y : norm
}

NormalRandd(x,target,y) {
	eps := 0.5
	first := NormalRand(x,y) + target
	
	if (first < x OR first > y) {
		first := rand_range(x,y)
	}
	loop 5 {
		diff := target-first
		Random, r, 0.0, 1.0
		if (first < target) {
			ratio := Max((diff/(target - x))**2,0.10)
		} else {
			ratio := Max((diff/(y - target))**2,0.10)
		}
		if (r <= ratio) {
			first := rand_range(x,y)
		}
	}
	return first
}

; https://www.autohotkey.com/boards/viewtopic.php?p=172653#p172653
GetWeightedRandom(varName, base, diff) {
    static prior_base := {}
    if(prior_base[varName] == "")
        prior_base[varName] := base
    Random, random_base, % (prior_base[varName] - diff), % (prior_base[varName] + diff)
    next_random := (base + random_base) / 2
    prior_base[varName] := next_random
    return Round(next_random)
}

TripleBoxRandom(base, max_variance) {
    inner := (max_variance / 3)
    outer := inner * 2
    orbit := inner * 3

    low_inner := (base - inner), high_inner := (base + inner)
    low_outer := (base - outer), high_outer := (base + outer)
    low_orbit := (base - orbit), high_orbit := (base + orbit)

    Random, rng_base, %low_inner%, %high_inner%
    ;if(rng_base > (base + (inner / 2)) or rng_base < (base - (inner / 2))) {
        Random, roll, 1, 2
        if(roll > 1) {
            Random, rng_base, %low_outer%, %high_outer%
            ;if(rng_base > (base + (outer / 2)) or rng_base < (base - (outer / 2))) {
                Random, roll, 1, 2
                if(roll > 1) {
                    Random, rng_base, %low_orbit%, %high_orbit%
                }
            ;}
        }
    ;}
    return rng_base
}