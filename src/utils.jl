module Utils

function is_prime(n::Int)
    if n == 2
        return true
    else
        for i = 2:Int(ceil(sqrt(n)))
            if n%i==0
                return false
            end
        end
        return true
    end
end

function next_prime(n::Int)
    i = n+1
    while !is_prime(i)
        i += 1
    end
    return i
end

# Prime number iterator.
struct Primes end
Base.start(::Primes) = 2
Base.next(P::Primes, state) = (state, next_prime(state))
Base.done(P::Primes, state) = false


function factorize(n::Int)
    # Factorizes n = p1^(e1) * p2^(e2) * ... * pk^(ek)
    # into array of tuples [(p1,e1),(p2,e2),...,(pk,ek)]
    # We'll do this by iteratively dividing n by ever
    # larger primes (and powers thereof) until n becomes 1, 
    # at which point we'll know factorization is complete.
    factors = []

    for prime in Primes()
        if n % prime == 0 # We've found a factor
            # Find the power to which the prime
            # factor is raised by progressively dividing
            # n by the factor until it no longer divides
            # evenly.
            power = 0
            while n % prime == 0
                n /= prime
                power += 1
            end
            push!(factors, (prime, power))
        end
        if n == 1
            break # We've fully factored n
        end
    end
    return factors
end

end