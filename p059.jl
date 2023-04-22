#=
XOR decryption
Problem 59
Each character on a computer is assigned a unique code and the preferred standard is ASCII (American Standard Code for Information Interchange). For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.

A modern encryption method is to take a text file, convert the bytes to ASCII, then XOR each byte with a given value, taken from a secret key. The advantage with the XOR function is that using the same encryption key on the cipher text, restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.

For unbreakable encryption, the key is the same length as the plain text message, and the key is made up of random bytes. The user would keep the encrypted message and the encryption key in different locations, and without both "halves", it is impossible to decrypt the message.

Unfortunately, this method is impractical for most users, so the modified method is to use a password as a key. If the password is shorter than the message, which is likely, the key is repeated cyclically throughout the message. The balance for this method is using a sufficiently long password key for security, but short enough to be memorable.

Your task has been made easy, as the encryption key consists of three lower case characters. Using p059_cipher.txt (right click and 'Save Link/Target As...'), a file containing the encrypted ASCII codes, and the knowledge that the plain text must contain common English words, decrypt the message and find the sum of the ASCII values in the original text.
=#

# note: when XOR-ing a binary string S with another binary string T, every 1 in T keeps the corresponding digit in S the same. On the other hand, 0s in T leave digits in S unchanged


# READ CIPHER DATA

f = open("data/p059_cipher.txt", "r")
# to count total lines in the file
line_count = 0

for line in readlines(f)
    #note: there's only one line
    global chars_encrypted = split(line, ',', keepempty=false)
end
close(f)

# READ ENGLISH DICTIONARY (source: https://www.mit.edu/~ecprice/wordlist.10000 )

words_arr = []

open("data/english_words.txt") do f
    for (i, line) in enumerate(eachline(f))
        push!(words_arr, string(line))
    end
end

words = Dict([ (words_arr[i], i) for i in 1:length(words_arr) ])                # (key, value) = ("word", # in list [Int] )




# How to convert (letters <--> ASCII) in julia
#julia> c = Int('x')
#120
#julia> Char(120)
#'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)


l = length(chars_encrypted)


# I was able to narrow it down by examining the printed strings. It was pretty clear, k=112 because some recognizable,
# even if the translation wasn't complete, and it seemed to get most of the spaces right.

for i=0:255
 println(i)
 for j in [61, 120]    # 0:255
  for k=112:112        # 0:255
   count32 = 0   # count the number of spaces (see if spaces are decrypted correctly)
   pass = ([i,j,k])
   passind = 1
   ascii_sum = 0
    chars_decrypted = Vector{Char}(repeat(' ', l))
    for il in 1:l
     n = parse(Int, chars_encrypted[il])
     #println(pass[passind])
     #println(' ', n, xor(pass[passind], n))
     nxor = xor(pass[passind], n)
     ascii_sum += nxor
     if nxor == 32
      count32 += 1
     end
     chars_decrypted[il] = Char(nxor)
     passind += 1
     if passind == 4
      passind = 1
     end
    end
    s = string(join(chars_decrypted))
    #println(s)
    ws = split(s, ' ', keepempty=false)
    if length(ws) > 1
     #if haskey(words, lowercase(ws[1])) & haskey(words, lowercase(ws[2]))
     # println("i=$i, j=$j, k=$k: ")
     # println(ws)
     #end
    end
   if count32 > 200      # 150
    println("i=$i, j=$j, k=$k: ")
    println("length $count32")
    println(ws)
    println("ASCII sum: $ascii_sum")
   end
  end
 end
end


