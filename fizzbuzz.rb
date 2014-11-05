### fizzbuzz ###
def fizzbuzz
  for i in 0..99 do
    if i % 3 != 0 && i % 5 != 0 then
        printf("%d", i)
    end
    if i % 3 == 0 then
        printf("fizz")
    end
    if i % 5 == 0 then
        printf("buzz")
    end
    printf("\n")
  end
end
