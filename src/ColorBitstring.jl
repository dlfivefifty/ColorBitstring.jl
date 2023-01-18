module ColorBitstring
export printbits, printlnbits, binarystring, parsebinary

printred(io::IO, x) = print(io, "\x1b[31m" * x * "\x1b[0m")
printgreen(io::IO, x) = print(io, "\x1b[32m" * x * "\x1b[0m")
printblue(io::IO, x) = print(io, "\x1b[34m" * x * "\x1b[0m")

function printbits(io::IO, x::Float16)
       bts = bitstring(x)
       printred(io, bts[1:1])
       printgreen(io, bts[2:6])
       printblue(io, bts[7:end])
end

function printbits(io::IO, x::Float32)
   bts = bitstring(x)
    printred(io, bts[1:1])
    printgreen(io, bts[2:2+8-1])
    printblue(io, bts[2+8:end])
end

function printbits(io::IO, x::Float64)
    bts = bitstring(x)
    printred(io, bts[1:1])
    printgreen(io, bts[2:2+11-1])
    printblue(io, bts[2+11:end])
end

function printbits(io::IO, x::Signed)
    bts = bitstring(x)
    printred(io, bts[1:1])
    printblue(io, bts[2:end])
end

printbits(io::IO, x::Unsigned) = printblue(io, bitstring(x))

printbits(x) = printbits(stdout, x)
function printlnbits(x)
    printbits(x)
    println()
end


# routines for other binary
binarystring(x) = (signbit(x) ? "-" : "") * "(" * string(abs(x); base=2) * ")_2"

function binarystring(x::AbstractFloat)
    S = precision(x)-1
    j = exponent(x)
    str = string(BigInt(big(2)^S * significand(abs(x))); base=2)
    str =     "2^$j * (" * str[1] * "." * str[2:end] * ")_2"
    s_str = if x ≥ 0
        ""
    else
        "-"
    end
    s_str * str
end

function binarystring(x::AbstractIrrational)
    str = binarystring(big(x))
    
    str[1:end-3] * "…" * ")_2"
end

function parsebinary(T, str::String)
    if str[1] == '-'
        s = -1
        str = str[2:end]
    else
        s = 1
    end
    j = findfirst(isequal('.'), str)
    if isnothing(j)
        s*convert(T, parse(BigInt, str; base=2))
    else
        intpart = parse(BigInt, str[1:j-1] * str[j+1:end]; base=2)
        convert(T, s * intpart/(big(2)^(length(str)-j)))
    end
end

end