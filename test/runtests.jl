using ColorBitstring, Test

@testset "ColorBitstring" begin
    io = IOBuffer()
    printbits(io, Float16(1))
    @test String(take!(io)) == "\e[31m0\e[0m\e[32m01111\e[0m\e[34m0000000000\e[0m"
    printbits(io, Float32(1))
    @test String(take!(io)) == "\e[31m0\e[0m\e[32m01111111\e[0m\e[34m00000000000000000000000\e[0m"
    printbits(io, 1.0)
    @test String(take!(io)) == "\e[31m0\e[0m\e[32m01111111111\e[0m\e[34m0000000000000000000000000000000000000000000000000000\e[0m"
    printbits(io, 1)
end

@testset "binarystring" begin
    @test binarystring(2) == "(10)_2"
    @test binarystring(-2) == "-(10)_2"
    @test binarystring(2.0) == "2^1 * (1.0000000000000000000000000000000000000000000000000000)_2"
    @test binarystring(Float16(2)) == "2^1 * (1.0000000000)_2"
    @test binarystring(-2.0) == "-2^1 * (1.0000000000000000000000000000000000000000000000000000)_2"
    @test binarystring(-Float16(2)) == "-2^1 * (1.0000000000)_2"

    @test binarystring(1/2.0) == "2^-1 * (1.0000000000000000000000000000000000000000000000000000)_2"
    @test binarystring(1/Float16(2)) == "2^-1 * (1.0000000000)_2"
    @test binarystring(-1/2.0) == "-2^-1 * (1.0000000000000000000000000000000000000000000000000000)_2"
    @test binarystring(-1/Float16(2)) == "-2^-1 * (1.0000000000)_2"
end

@testset "parsebinary" begin
    @test parsebinary(Float64, "1") ≡ 1.0
    @test parsebinary(Float32, "1") ≡ 1.0f0
    @test parsebinary(Float64, "-1") ≡ -1.0
    @test parsebinary(Float32, "-1") ≡ -1.0f0
    @test parsebinary(Float64, "10") ≡ 2.0
    @test parsebinary(Float32, "10") ≡ 2.0f0
    @test parsebinary(Float64, "-10") ≡ -2.0
    @test parsebinary(Float32, "-10") ≡ -2.0f0    
    @test parsebinary(Float32, "1.") ≡ 1.0f0
    @test parsebinary(Float32, "1.") ≡ 1.0f0
    @test parsebinary(Float64, "1.001") ≡ 1.125
    @test parsebinary(Float32, "1.001") ≡ 1.125f0
    @test parsebinary(Float64, "10.001") ≡ 2.125
    @test parsebinary(Float32, "10.001") ≡ 2.125f0

    @test parsebinary(Float64, ".001") ≡ parsebinary(Float64, "0.001") ≡ 0.125
    @test parsebinary(Float64, "-.001") ≡ parsebinary(Float64, "-0.001") ≡ -0.125
end