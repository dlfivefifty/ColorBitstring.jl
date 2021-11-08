module ColorBitstring
export printbits

printred(io::IO, x) = print(io, "\x1b[31m" * x * "\x1b[0m")
printgreen(io::IO, x) = print(io, "\x1b[32m" * x * "\x1b[0m")
printblue(io::IO, x) = print(io, "\x1b[34m" * x * "\x1b[0m")

function printbits(io::IO, x::Float16)
       bts = bitstring(x)
       printred(io, bts[1:1])
       printgreen(io, bts[2:7])
       printblue(io, bts[8:end])
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

function printbits(io::IO, x::Integer)
    bts = bitstring(x)
    printred(io, bts[1:1])
    printblue(io, bts[2:end])
end

printbits(x) = printbits(stdout, x)
end