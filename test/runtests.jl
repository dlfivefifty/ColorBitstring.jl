using ColorBitstring, Test

@testset "ColorBitstring" begin
    io = IOBuffer()
    printbits(io, Float16(1))
    @test String(take!(io)) == "\e[31m0\e[0m\e[32m011110\e[0m\e[34m000000000\e[0m"
    printbits(io, Float32(1))
    @test String(take!(io)) == "\e[31m0\e[0m\e[32m01111111\e[0m\e[34m00000000000000000000000\e[0m"
    printbits(io, 1.0)
    @test String(take!(io)) == "\e[31m0\e[0m\e[32m01111111111\e[0m\e[34m0000000000000000000000000000000000000000000000000000\e[0m"
    printbits(io, 1)
    
end