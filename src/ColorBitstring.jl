module ColorBitstring
export printbits, printlnbits

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
end